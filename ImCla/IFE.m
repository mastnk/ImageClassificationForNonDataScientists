% Image Feature Extractor
classdef IFE
  properties (SetAccess = private)
    net
    layer
    ndims
  end
  
  methods
    function obj = IFE(name)

      if( strcmpi( name, 'googlenet' ) )
      	obj.net = googlenet;
      	obj.layer = 'pool5-7x7_s1';
      	obj.ndims = 1024;

      elseif( strcmpi( name, 'inceptionv3' ) )
        obj.net = inceptionv3;
	    obj.layer = 'avg_pool';
	    obj.ndims = 2048;

      elseif( strcmpi( name, 'densenet201' ) )
        obj.net = densenet201;
	    obj.layer = 'avg_pool';
	    obj.ndims = 1920;

      elseif( strcmpi( name, 'mobilenetv2' ) )
        obj.net = mobilenetv2;
	    obj.layer = 'global_average_pooling2d_1';
	    obj.ndims = 1280;

      elseif( strcmpi( name, 'mobilenetv2' ) )
        obj.net = mobilenetv2;
	    obj.layer = 'global_average_pooling2d_1';
	    obj.ndims = 1280;

      elseif( strcmpi( name, 'resnet18' ) )
        obj.net = resnet18;
	    obj.layer = 'pool5';
	    obj.ndims = 512;

      elseif( strcmpi( name, 'resnet50' ) )
        obj.net = resnet50;
	    obj.layer = 'avg_pool';
	    obj.ndims = 2048;

      elseif( strcmpi( name, 'resnet101' ) )
        obj.net = resnet101;
	    obj.layer = 'pool5';
	    obj.ndims = 2048;

      elseif( strcmpi( name, 'xception' ) )
        obj.net = xception;
	    obj.layer = 'avg_pool';
	    obj.ndims = 2048;

      elseif( strcmpi( name, 'inceptionresnetv2' ) )
        obj.net = inceptionresnetv2;
	    obj.layer = 'avg_pool';
	    obj.ndims = 1536;

      elseif( strcmpi( name, 'shufflenet' ) )
        obj.net = shufflenet;
	    obj.layer = 'node_200';
	    obj.ndims = 544;

      elseif( strcmpi( name, 'nasnetmobile' ) )
        obj.net = nasnetmobile;
	    obj.layer = 'global_average_pooling2d_1';
	    obj.ndims = 1056;

      elseif( strcmpi( name, 'nasnetlarge' ) )
        obj.net = nasnetlarge;
	    obj.layer = 'global_average_pooling2d_2';
	    obj.ndims = 4032;

      elseif( strcmpi( name, 'efficientnetb0' ) )
        obj.net = efficientnetb0;
	    obj.layer = 'efficientnet-b0|model|head|global_average_pooling2d|GlobAvgPool';
	    obj.ndims = 1280;

      elseif( strcmpi( name, 'alexnet' ) )
        obj.net = alexnet;
	    obj.layer = 'relu7';
	    obj.ndims = 4096;

      elseif( strcmpi( name, 'vgg16' ) )
        obj.net = vgg16;
	    obj.layer = 'relu7';
	    obj.ndims = 4096;

      elseif( strcmpi( name, 'vgg19' ) )
        obj.net = vgg19;
	    obj.layer = 'relu7';
	    obj.ndims = 4096;
	  else
	    nets = {'googlenet', 'inceptionv3', 'densenet201','mobilenetv2','resnet18','resnet50','resnet101','xception','inceptionresnetv2','shufflenet','nasnetmobile','nasnetlarge','efficientnetb0','alexnet','vgg16','vgg19'};
	    nets = sort(nets);
		msg = sprintf( 'Please specify the net from:\n' );
		for i=1:numel(nets)
		 msg = [msg,sprintf( '%s\n', nets{i} )];
		end
		error(msg);
	  end

	end
  
    function F = imds2features( obj, imds )
      inputSize = obj.net.Layers(1).InputSize;
      aimds = augmentedImageDatastore(inputSize(1:2),imds);
      features = activations(obj.net,aimds,obj.layer,'OutputAs','rows');
      F = features;
    end
	  
	function [F,L] = imds2features_labels( obj, imds )
      F = obj.imds2features( imds );
      L = categorical(imds.Labels);
	end
  
  end
end
