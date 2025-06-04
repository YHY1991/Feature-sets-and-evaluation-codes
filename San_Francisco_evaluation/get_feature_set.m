function [best_set] = get_feature_set(FS_id,length_x)
switch(FS_id)
    case 2
        temp_set=load('.\feature_subset\feature_set_FNGBS.mat');
        best_set=temp_set.feature_set_FNGBS;

    case 3
        temp_set=load('.\feature_subset\feature_set_SOPSRL.mat');
        best_set=temp_set.feature_set_SOPSRL;

    case 4
        temp_set=load('.\feature_subset\feature_set_CNAFS.mat');
        best_set=temp_set.feature_set_CNAFS;

    case 5
        temp_set=load('.\feature_subset\feature_set_MGSR.mat');
        best_set=temp_set.feature_set_MGSR;

    case 6
        temp_set=load('.\feature_subset\feature_set_NC_OC_IE.mat');
        best_set=temp_set.feature_set_NC_OC_IE;

    case 7
        temp_set=load('.\feature_subset\feature_set_TLR_MFS.mat');
        best_set=temp_set.feature_set_TLR_MFS;

    case 8
        temp_set=load('.\feature_subset\feature_set_ASPS_MN.mat');
        best_set=temp_set.feature_set_ASPS_MN;

    case 9
        temp_set=load('.\feature_subset\feature_set_AEFS.mat');
        best_set=temp_set.feature_set_AEFS;

    case 10
        temp_set=load('.\feature_subset\feature_set_NMFW.mat');
        best_set=temp_set.feature_set_NMFW;  

    case 11
        temp_set=load('.\feature_subset\feature_set_BS_Nets.mat');
        best_set=temp_set.feature_set_BS_Nets;

    case 12
        temp_set=load('.\feature_subset\feature_set_RSR.mat');
        best_set=temp_set.feature_set_RSR;

    case 13
        temp_set=load('.\feature_subset\feature_set_CDSP_MinV.mat');
        best_set=temp_set.feature_set_CDSP_MinV; 

    case 14
        temp_set=load('.\feature_subset\feature_set_DISR.mat');
        best_set=temp_set.feature_set_DISR;

    case 15
        temp_set=load('.\feature_subset\feature_set_EUAIR.mat');
        best_set=temp_set.feature_set_EUAIR;

    case 16
        temp_set=load('.\feature_subset\feature_set_GPCBS.mat');
        best_set=temp_set.feature_set_GPCBS; 

    case 17
        temp_set=load('.\feature_subset\feature_set_InfiniteFS.mat');
        best_set=temp_set.feature_set_InfiniteFS;

    case 18
        temp_set=load('.\feature_subset\proposed_method.mat');
        best_set=temp_set.proposed_method;


end
end