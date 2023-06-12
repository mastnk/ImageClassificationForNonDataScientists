addpath('ImCla');
reqToolboxes = {'Deep Learning Toolbox'};
checkToolboxes(reqToolboxes);

img_dir = 'images'; % specify the image folder

imds_train = load_imds( [img_dir,'/train/'] );
imds_test = load_imds( [img_dir,'/test/'] );

imcl = ImageClassifier('resnet18'); % specify the name of pre-trained netowrk.
imcl = imcl.fit( imds_train, 'num_iter', 10000, 'rho', 0.001, 'reg',1E-8, 'smooth', [0.50, 0.75] ); % parameters
[pred, proba] = imcl.pred( imds_test ); % test with test images
[results, acc] = result_table( pred, proba, imds_test ); % generate result table
results
disp(acc);
disp(imcl.cl.ce);
