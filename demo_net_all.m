addpath('ImCla');
reqToolboxes = {'Deep Learning Toolbox'};
checkToolboxes(reqToolboxes);

img_dir = 'images';

imds_train = load_imds( [img_dir,'/train/'] );
imds_test = load_imds( [img_dir,'/test/'] );


nets = {'googlenet', 'inceptionv3', 'densenet201','mobilenetv2','resnet18','resnet50','resnet101','xception','inceptionresnetv2','shufflenet','nasnetmobile','nasnetlarge','efficientnetb0','alexnet','vgg16','vgg19'};
nets = sort(nets);

for i=1:numel(nets)
  fprintf( '%s ', nets{i} );
  tic;
  imcl = ImageClassifier(nets{i});
  imcl = imcl.fit( imds_train );
  [pred, proba] = imcl.pred( imds_test );
  [results, acc] = result_table( pred, proba, imds_test );
  t=toc;
  fprintf( '%f %f [sec]\n', acc, t );
end

