This repository provides a Matlab evaluation of the paper "GAN-guided Unsupervised Feature Selector for SAR Image Classification".

We will publish our code if the paper is finally accepted.

The folders 'MTAP_evaluation', 'S1AFS_evaluation', 'San_Francisco_evaluation' and 'Flevoland_evaluation' shows the evaluation codes on MTAP, S1AFS, FPSanF and FPFle feature sets, respectively. Run 'Evaluation_Different_Algorithms.m' to compare the proposed method with other unsupervised feature selection methods based on various feature sets and to obtain the accuracy curves. The uploaded codes only use KNN to evaluate the methods. Note that in order to successfully run 'Evaluation_Different_Algorithms.m', Libsvm for Matlab should be installed at first (https://www.csie.ntu.edu.tw/~cjlin/libsvm/), and feature sets should also be downloaded in advance. In addition, you should amend the 'update_classifier_ids' and 'plot_classfier_num' of 'Evaluation_Different_Algorithms.m' from '{[2]}' and '[2]' to '{[1 2]}' and '[1 2]', respectively. 

The link for labeled SAr feature sets: https://drive.google.com/drive/folders/1bHOQCGkQ1bB7fN6SlEys4RzUS0uKE1U1?usp=sharing.

The raw MTAP and MTS1A data sets are downloaded from the NASA’s Alaska Satellite Facility (ASF) (https://search.asf.alaska.edu/#/). They are preprocessed by ENVI SARscape 5.2 in the first place. Then, 90-dimensional MTAP features and 126-dimensional MTS1A features are obtained by MATLAB.
File 'Feature order for MTAP feature set.txt' shows the sequence of features in MTAP feature set.
File 'Feature order for MTS1A feature set.txt' shows the sequence of features in MTS1A feature set.

The backscattering matrices acquired by L-band AIRSAR over San Francisco and Flevoland areas are downloaded from https://github.com/liuxuvip/PolSF and https://github.com/mqalkhatib/CV-ASDF2Net/tree/main/Datasets/Flevoland, respectively. They are processed by PolSARpro 5.1 and 108 decomposed features are used to constitute the feature set.

The file 'Feature order for PolSAR feature set.txt' shows the sequence of features in FPSanF and FPFle feature sets.

The links for competitive algorithms: 

FNGBS: https://github.com/qianngli/FNGBS;

SOPSRL: https://github.com/xhweei/hyperspectral-band-selection;

CNAFS: https://github.com/misteru/CNAFS;

MGSR: https://github.com/ZhangYongshan/MGSR;

OCF: https://github.com/tanmlh/Optimal-Clustering-Framework-for-Hyperspectral-Band-Selection/tree/master;

TLR-MFS: https://github.com/tonyshangyang/TLR;

ASPS-MN: https://github.com/qianngli/ASPS_MN/tree/master;

AEFS: https://github.com/panda1949/AEFS;

NGNMF: https://github.com/Hang-Fu/NGNMF-E2DSSA;

BS-net: https://github.com/AngryCai/BS-Nets;

RSR: https://github.com/AISKYEYE-TJU/RSR-PR2015;

CDSP: https://github.com/sxdDlmu/CTSPBS-band-selection-for-hyperspectral-target-detection;

DISR: https://search.r-project.org/CRAN/refmans/Rdimtools/html/feature_DISR.html;

EUIAR: https://github.com/BELLoney/Feature-selection/tree/main/EUIAR_code;

GPC: https://github.com/AuthorNg/GPCBS;

Inf-FS: https://github.com/giorgioroffo/Infinite-Feature-Selection.

