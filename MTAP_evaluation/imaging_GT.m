function imaging_GT(all_Labels)
    result_map = label2color(all_Labels','mtap');
    figure,imshow(result_map);
    title('Ground truch')
    name = sprintf('classif_%s.tif','Ground truth');
    imwrite( result_map,['.\result\' name]);
end