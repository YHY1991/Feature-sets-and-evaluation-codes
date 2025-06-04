function [accu, result] = test_fs_accu_Flevoland(feature_set, Dataset, classifier_type)
    accu = struct('OA', 0, 'MA', 0, 'Kappa', 0);
    train_X = Dataset.train_X;
    train_labels = double(Dataset.train_labels);
    test_X = Dataset.test_X;
    test_labels = double(Dataset.test_labels);
    test_size = size(test_labels, 1);
    [no_rows, no_cols, ~] = size(Dataset.A);
    C = max(test_labels);
    warning('off');
    fs_train_X = train_X(:, feature_set);
    fs_test_X = test_X(:, feature_set);
    switch(classifier_type)
        case 'SVM'
            %You should install LibSVM toolbox first.
            model = svmtrain(train_labels, fs_train_X, Dataset.svm_para); 
            [predict_labels, corrected_num, ~] = svmpredict(test_labels, fs_test_X, model, '-q');
            
            accu.OA = corrected_num(1) / 100;
            cmat = confusionmat(test_labels, predict_labels);
            sum_accu = 0;
            for i = 1 : C
                sum_accu = sum_accu + cmat(i, i) / sum(cmat(i, :), 2);
            end
            accu.MA = sum_accu / C;
            Pe = 0;
            for i = 1 : C
                Pe = Pe + cmat(i, :) * cmat(:, i);
            end
            Pe = Pe / (test_size * test_size);
            accu.Kappa = (accu.OA - Pe) / (1 - Pe);
            
        case 'CART'
            tree = fitctree(fs_train_X, train_labels);
            predict_label = tree.predict(fs_test_X);
            accu.OA = length(find(predict_label == test_labels)) / length(test_labels);
            cmat = confusionmat(test_labels, predict_label);
            sum_accu = 0;
            for i = 1 : C
                sum_accu = sum_accu + cmat(i, i) / sum(cmat(i, :), 2);
            end
            accu.MA = sum_accu / C;
            Pe = 0;
            for i = 1 : C
                Pe = Pe + cmat(i, :) * cmat(:, i);
            end
            Pe = Pe / (test_size * test_size);
            accu.Kappa = (accu.OA - Pe) / (1 - Pe);
            
        case 'KNN'
            mdl = fitcknn(fs_train_X, train_labels,'NumNeighbors',5, 'Distance','euclidean');
            predict_label = predict(mdl,fs_test_X);
            accu.OA = 0;
            cmat = confusionmat(test_labels, predict_label);
            for i = 1 : size(predict_label, 1)
                if predict_label(i) == test_labels(i)
                    accu.OA = accu.OA + 1;
                end
            end
            accu.OA = accu.OA / size(predict_label, 1);
            sum_accu = 0;
            for i = 1 : C
                sum_accu = sum_accu + cmat(i, i) / sum(cmat(i, :), 2);
            end
            accu.MA = sum_accu / C;
            
            Pe = 0;
            for i = 1 : C
                Pe = Pe + cmat(i, :) * cmat(:, i);
            end
            Pe = Pe / (test_size*test_size);
            accu.Kappa = (accu.OA - Pe) / (1 - Pe);
            
        case 'LDA'
            factor = fitcdiscr(fs_train_X, train_labels);
            predict_label = double(factor.predict(fs_test_X));
            cmat = confusionmat(test_labels, predict_label);
            accu.OA = length(find(predict_label == test_labels)) / length(test_labels);
            sum_accu = 0;
            for i = 1 : C
                sum_accu = sum_accu + cmat(i, i) / sum(cmat(i, :), 2);
            end
            accu.MA = sum_accu / C;
            
            Pe = 0;
            for i = 1 : C
                Pe = Pe + cmat(i, :) * cmat(:, i);
            end
            Pe = Pe / (test_size*test_size);
            accu.Kappa = (accu.OA - Pe) / (1 - Pe);
    end
end