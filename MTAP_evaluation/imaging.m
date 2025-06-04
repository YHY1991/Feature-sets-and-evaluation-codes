function imaging(feature_set, Dataset, method_id, method_names)

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
    fs_train_test_X=[fs_train_X; fs_test_X];
    train_test_labels=[train_labels; test_labels];
    train_pos = Dataset.train_pos;
    test_pos = Dataset.test_pos;
    train_test_pos=[train_pos; test_pos];

    mdl = fitcknn(fs_train_X, train_labels,'NumNeighbors',5, 'Distance','euclidean');
    predict_label_temp= predict(mdl,fs_train_test_X);
    all_Labels=zeros(no_rows,no_cols);
    for i = 1:1:length(predict_label_temp)
        all_Labels(train_test_pos(i,2),train_test_pos(i,1)) = predict_label_temp(i);
    end
    result_map=label2color(all_Labels,'mtap');figure,imshow(result_map);
    title(char(method_names{method_id}))
    name=sprintf('classif_%s.tif',char(method_names{method_id}));
    imwrite(result_map,['.\result\' name]);
end