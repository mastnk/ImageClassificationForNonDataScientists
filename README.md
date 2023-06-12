# MATLAB Image Classification for Non-Data Scientists

It provides an image classification sample-based pre-trained deep neural network for non-data scientists.
You can test the image classification by just copying images to a folder.

## Requirement

It requires **Deep Learning Toolbox**. 
Pleae check Deep Learning Toolbox

It also requires to install app of pre-trained network when you use a new network.

## Usage

Run *demo_image_classification*.

```
img_dir = 'images'; % specify the image folder

imds_train = load_imds( [img_dir,'/train/'] );
imds_test = load_imds( [img_dir,'/test/'] );

imcl = ImageClassifier('resnet18'); % specify the name of pre-trained netowrk.
imcl = imcl.fit( imds_train, 'num_iter', 10000, 'rho', 0.001, 'reg',1E-8, 'smooth', [0.50, 0.75] ); % parameters
[pred, proba] = imcl.pred( imds_test ); % test with test images
[results, acc] = result_table( pred, proba, imds_test ); % generate result table
```


## Available Pre-trained feature extractor
googlenet, 
inceptionv3, 
densenet201,
mobilenetv2,
resnet18,
resnet50,
resnet101,
xception,
inceptionresnetv2,
shufflenet,
nasnetmobile,
nasnetlarge,
efficientnetb0,
alexnet,
vgg16,
vgg19

## Dataset

It includes four models images.

- 0: [Dzee Shah](https://pixabay.com/users/dzeeshah-481870/) That may be name of photographer. If you know the name of model, please let me know.

- 1: [Robin Higgins](https://pixabay.com/users/robinhiggins-1321953/)

- 2: [Saya Akane](https://www.pakutaso.com/person/woman/akanesaya/)

- 3: [Yuka Kawamura](https://www.pakutaso.com/person/woman/kawamurayuka/)
