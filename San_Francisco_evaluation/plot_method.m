function fig = plot_method(Methods, x, classifier_names, classifier_id, method_names, dataset_id, n_rep, type_accu)
    
    M_cnt = size(Methods, 2);
    colors = [linspecer(M_cnt); 0, 0, 0];
    colors_cnt = size(colors, 1);
    line_types = {'-^', '--', '-.p', '-d', '-v', '--x', '-.', '-*', '-^'};
    line_types_cnt = size(line_types, 2);
    x_cnt = size(x, 2);
    y = zeros(1, x_cnt);
    set(gcf,'unit','normalized','position',[0, 0, 0.22,0.35]);
    fig = figure(1);

    ymin = zeros(M_cnt, 1);
    y_max = 0;
    figure
    accuracy_comparison=zeros(M_cnt,x_cnt);
    for i = 1 : M_cnt
        for j = 1 : x_cnt
            switch type_accu
                case 1
                    y(1, j) = Methods{1, i}.accu(dataset_id, classifier_id,j);
                    accuracy_comparison(i,j)=Methods{1, i}.accu(dataset_id, classifier_id,j);
                    save_name='OA';
                case 2
                    y(1, j) = Methods{1, i}.accu(dataset_id, classifier_id,j);
                    accuracy_comparison(i,j)=Methods{1, i}.accu(dataset_id, classifier_id,j);
                    save_name='MA';
                case 3
                    y(1, j) = Methods{1, i}.accu(dataset_id, classifier_id,j);
                    accuracy_comparison(i,j)=Methods{1, i}.accu(dataset_id, classifier_id,j);
                    save_name='Kappa';
            end
        end
        ymin(i) = y(1, 1);
        y_max = max(y_max, max(y));
        plot(x, y(1:x_cnt), line_types{1, mod(i, line_types_cnt)+1}, 'Color', colors(mod(i, colors_cnt)+1, :),'LineWidth', 0.5);
        hold on;
    end
    accuracy_comparison=roundn(accuracy_comparison,-3);
    all_accuracy_comparison=zeros(M_cnt,n_rep,x_cnt);
    for i = 1 : M_cnt
        for j = 1 : x_cnt
            for k=1 : n_rep
                switch type_accu
                    case 1
                        all_accuracy_comparison(i,k,j)=Methods{1, i}.all_accu(classifier_id,k,j);
                    case 2
                        all_accuracy_comparison(i,k,j)=Methods{1, i}.all_accu(classifier_id,k,j);
                    case 3
                        all_accuracy_comparison(i,k,j)=Methods{1, i}.all_accu(classifier_id,k,j);
                end
            end
        end
    end
    all_accuracy_comparison=roundn(all_accuracy_comparison,-3);
    save(['.\result\' classifier_names{classifier_id} '_' save_name num2str(n_rep) '.mat'],'accuracy_comparison')
    save(['.\result\' classifier_names{classifier_id} '_' save_name num2str(n_rep) '_all_iter.mat'],'all_accuracy_comparison')
    y_min = mean(ymin(2:M_cnt));
    axis([0 max(x) 0.2 1]);
    axis normal;
    xlabel('Number of Features');
    ylabel([save_name ' by ', classifier_names{classifier_id}]);
    grid on;
    h = legend(char(method_names), 'Location', 'southeast');
end