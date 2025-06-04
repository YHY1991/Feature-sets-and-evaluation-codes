clear all
close all
%Create folder
mkdir('result')
%All methods
method_names = {'All Features','FNGBS','SOPSRL','CNAFS',...
    'MGSR','OCF','TLR-MFS','ASPS-MN','AEFS','NGNMF','BS-net','RSR',...
    'CDSP','DISR', 'EUIAR', 'GPCBS','Inf-FS', 'WGAN-GP-UFS'};
start_dimension = 3; delta_dimension = 3; final_dimension = 30; 
x = start_dimension : delta_dimension : final_dimension; % Number of the selected features.
x_length=length(x);
classifier_names = {'SVM','KNN'};
dataset_names = {'MTAP'};
size_method_names=size(method_names);
svm_para = { '-c 10 -g 2 -m 500 -t 2 -q'}; % Parameters to perform svm. You should install LibSVM toolbox first.
updated_method_ids = 1:size_method_names(2); % Ids of feature selection method that you want to perform. If you want to perform some methods, you can set update_classifier_ids = [1 5 9 15].
update_classifier_ids = {[2]}; % Ids of classifier which you want to perform in algorithm comparison stage. 1, 2, 3 and 4 indicate SVM, KNN , CART and LDA classifiers, respectively.
num_repe = 6; % Repetitive experiments to reduce the randomness of choosing training and testing samples
plot_method_ids = 1:size_method_names(2);
plot_classfier_num = [2]; % Ids of classifier which you want to plot the classification accuracy in different feature numbers.
% save_accuracy_id : ids of accuracy index. 1, 2 and 3 indicate OA, MA and Kappa.
save_accuracy_id = 1;
C_cnt = size(classifier_names, 2);
M_cnt = size(method_names, 2);
D_cnt = size(dataset_names, 2);

% Initialize method struct
if ~exist('Methods')
    Methods = cell(1, 1);
    for i = 1 : size(method_names, 2)
        Methods{1, i} = get_method_struct(method_names{i}, dataset_names, classifier_names, x_length, num_repe);
    end
end

% Feature selection for MTAP dataset
for dataset_id = [1]
    % Load data
    [Dataset]= get_data_MTAP(dataset_names{dataset_id});
    Dataset.svm_para = svm_para{1, dataset_id};
    A = Dataset.A; 
    [M, N, d] = size(A);
    ground_truth = Dataset.ground_truth;
    % plot ground truth
    imaging_GT(ground_truth)
    % Calculate the feature set for each method
    Methods{1, 1}.feature_set{dataset_id, 1} = 1:d;
    % Initialization
    for i = updated_method_ids
        for classifier_id = update_classifier_ids{dataset_id}
            for j = 1 : size(x, 2)
                Methods{1, i}.accu(dataset_id, classifier_id, j) = 0;
            end
        end
    end
    
    for ite = 1 : num_repe
      % Update the training and testing samples
        if ite > 1
            Dataset = get_data_MTAP(dataset_names{dataset_id});
            Dataset.svm_para = svm_para{1, dataset_id};
        end
        for classifier_id = update_classifier_ids{dataset_id}
            % Calculate the accuracy without feature selection
            if find(updated_method_ids == 1)
                cur_accu = test_fs_accu_MTAP(Methods{1, 1}.feature_set{dataset_id, 1}, Dataset, classifier_names{classifier_id});
                Methods{1, 1}.accu(dataset_id, classifier_id, 1) = ...
                    Methods{1, 1}.accu(dataset_id, classifier_id, 1) + cur_accu.OA;
                Methods{1, 1}.all_accu(classifier_id, ite, 1) = cur_accu.OA;
                for j = 2 : size(x, 2)
                    Methods{1, 1}.accu(dataset_id, classifier_id, j) = Methods{1, 1}.accu(dataset_id, classifier_id, 1);
                    Methods{1, 1}.all_accu(classifier_id, ite, j) = Methods{1, 1}.all_accu(classifier_id, ite, 1);
                end
            end
            % Calculate accuracy of each feature selection method
            for j = updated_method_ids
                if j == 1 
                    if(ite == 1)
                        % Use KNN to plot classification maps
                        if(classifier_id == 1)
                            imaging(Methods{1, 1}.feature_set{dataset_id, 1}, Dataset, j, method_names);
                        end
                    end
                    continue 
                end
                cnt = 1;
                temp_feature_set=get_feature_set(j,x_length);
                for k = x
                    Methods{1, j}.feature_set{dataset_id, cnt}=temp_feature_set{cnt};
                    if(k==x(2))
                        if(ite==1)
                            if(classifier_id == 1)
                                % Only 3-dimension feature subsets are used to generate classification maps. Use KNN to plot classification maps.
                                imaging(Methods{1, j}.feature_set{dataset_id, cnt}, Dataset, j, method_names);
                            end
                        end
                    end
                    cur_accu = test_fs_accu_MTAP(Methods{1, j}.feature_set{dataset_id, cnt}, Dataset, classifier_names{classifier_id});
                    Methods{1, j}.accu(dataset_id, classifier_id, cnt) = ...
                        Methods{1, j}.accu(dataset_id, classifier_id, cnt) + cur_accu.OA;
                    Methods{1, j}.all_accu(classifier_id, ite, cnt) = cur_accu.OA;
                    str = fprintf('ite: %d\t%s----%s----%s----%f\n', ite, dataset_names{dataset_id}, classifier_names{classifier_id}, char(method_names{j}), Methods{1, j}.accu(dataset_id, classifier_id, cnt) / ite);
                    cnt = cnt + 1;
                end 
                fprintf('\n');
            end 
        end
    end
    
    % Calculate the mean accuracy over different iterations
    for classifier_id = update_classifier_ids{dataset_id}
        for j = updated_method_ids
            Methods{1, j}.accu(dataset_id, classifier_id, :) = ...
                Methods{1, j}.accu(dataset_id, classifier_id, :) / num_repe;
        end
    end
 end

% Plot the result. 
for plot_classfier_id=plot_classfier_num
    plot_method(Methods(plot_method_ids), x, classifier_names, plot_classfier_id, method_names(plot_method_ids), dataset_id, num_repe, save_accuracy_id);
end

% Get a struct of a feature selection method
function [method_struct] = get_method_struct(method_name, dataset_names, classifier_names, feature_num_cnt, num_repe)
    method_struct.method_name = method_name;
    dataset_cnt = size(dataset_names, 2);
    classifier_cnt = size(classifier_names, 2);
    
    method_struct.feature_set = cell(dataset_cnt, feature_num_cnt); 
    method_struct.feature_set_corr = cell(dataset_cnt, feature_num_cnt);
    method_struct.accu = zeros(dataset_cnt, classifier_cnt, feature_num_cnt);
    method_struct.all_accu = zeros(classifier_cnt, num_repe, feature_num_cnt);
end