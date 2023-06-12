classdef ImageClassifier
   properties (SetAccess = private)
		fe
		cl
   end
   methods
	  
	  function obj = ImageClassifier(name)
	    obj.fe = IFE(name);
	    obj.cl = MCLR();
	  end
	  
	  function clearClassifier( obj )
	    obj.cl.clearWb();
	  end
	  
      function obj = fit( obj, imds, varargin )
        [features, labels] = obj.fe.imds2features_labels( imds );
        
        [rho, num_iter, reg, smooth_th1, smooth_th2, unknown] = obj.cl.parse_args( varargin );
        
        obj.cl = obj.cl.fit( features, labels, ...
          'rho', rho, ...
          'num_iter', num_iter, ...
          'reg', reg, ...
          'smooth', [smooth_th1, smooth_th2], ...
          'unknown', unknown );
      end
      
      function [pred, proba] = pred( obj, imds, classnames )
        if( ~exist( 'classnames', 'var' ) )
            classnames=[];
        end
      	features = obj.fe.imds2features( imds );
        [pred, proba] = obj.cl.pred_proba( features, classnames );
      end
   end
end
