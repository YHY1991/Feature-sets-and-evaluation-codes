function [Dataset] = get_data_Flevoland(dataset_name)
    % load data
    disp(['Load ' char(dataset_name) ' dataset...'])
    load('.\data\Flevoland_all_metrics_normalized.mat');
    A = all_metrics_normalized;
    A(find(isnan(A)==1)) = 0;
    load('.\data\Flevoland_GT.mat');
    ground_truth = label;

    % definition and initialization
    A = double(A);
    A = double(A);
    train_ratio = 0.08;
    [M, N, D] = size(A);
    num_classes = max(max(ground_truth));
    pixel_pos =cell(1, num_classes);

    for i = 1:M
        for j = 1:N
            if ground_truth(i, j) ~= 0
                pixel_pos{ground_truth(i, j)} = [pixel_pos{ground_truth(i, j)}; [i j]];
            end
        end
    end

    % generalize training and testing samples
    train_X = []; test_X = []; train_pos = [];
    train_labels = []; test_labels = []; test_pos = [];
    row_rank = cell(num_classes, 1);
    
    for i = 1:num_classes
        pos_mat = pixel_pos{i};
        row_rank{i} = randperm(size(pos_mat, 1));
        pos_mat = pos_mat(row_rank{i}, :);

        [m1, n1] = size(pos_mat);
        for j = 1 : floor(m1 * train_ratio)
            temp = A(pos_mat(j, 1), pos_mat(j, 2), :);
            train_X = [train_X temp(:)];
            train_labels = [train_labels;i];
            train_pos = [train_pos; [pos_mat(j, 1) pos_mat(j, 2)]];
        end
    end

    for i =  1: num_classes
        pos_mat = pixel_pos{i};
        pos_mat = pos_mat(row_rank{i}, :);
        [m1, n1] = size(pos_mat);
        for j = floor(m1 * train_ratio) + 1 : m1
            temp = A(pos_mat(j, 1), pos_mat(j, 2), :);
            test_X = [test_X temp(:)];
            test_labels = [test_labels;i];
            test_pos = [test_pos; [pos_mat(j, 1) pos_mat(j, 2)]];
        end
    end
    train_X = train_X';
    test_X = test_X';
    
    Dataset.train_X = train_X; %[number of samples ¡Á number of features  double]
    Dataset.train_labels = train_labels; %[number of samples ¡Á 1  double]
    Dataset.test_X = test_X; %[number of samples ¡Á number of features  double]
    Dataset.train_pos = train_pos; %[number of samples ¡Á 2  double]
    Dataset.test_labels = test_labels; %[number of samples ¡Á 1  double]
    Dataset.test_pos = test_pos; %[number of samples ¡Á 2  double]
    Dataset.A = A; %[512¡Á512¡Á90  double]
    Dataset.ground_truth = ground_truth; %[512¡Á512  double]
end