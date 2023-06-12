% Multi Class Logistic Regression
% reference:
%  https://github.com/arnejad/multiclass-classification/blob/master/multinomialLogisticRegression.m

classdef MCLR
   properties (SetAccess = private)
		W
		b
		ce
		acc
   end
   methods
     function obj = MCLR()
     end
     
     function obj = clearWb( obj )
       obj.W = [];
       obj.b = [];
       obj.ce = [];
       obj.acc = [];      
     end

     function obj = fit( obj, X, Y, varargin )
       [rho, num_iter, reg, smooth_th1, smooth_th2, unknown] = obj.parse_args( varargin );
       
       if( strcmpi( class(Y), 'categorical' ) )
         Y = categorical2onehot(Y, unknown);
       end
       
   	    [N,D] = size(X);
		[N,K] = size(Y);
       	if( isempty(obj.W) )
		 obj.W = zeros(D, K);
		end
        if( isempty(obj.b) )
		 obj.b = zeros(1, K);
		end
		
		for i=1:num_iter
		    P = softmax((X * obj.W + obj.b)')';
		    diff = (P - Y); % calculating gradient
		    if( smooth_th1<1 && smooth_th2<1 )
		      diff = obj.smooth(diff, 1-smooth_th1, 1-smooth_th2);
            end
            diff = diff/N;
		    grad = X' * diff;
		    obj.W = obj.W - (rho * grad + (rho * reg * obj.W)); % Updating W
		    obj.b = obj.b - (rho * sum(diff)); % Updating b

			%{
			P = softmax((X * obj.W + obj.b)')';
			P = max(P, 1E-12);
		    ce = -mean(sum(log(P) .* Y, 2));
			fprintf( '%d, %f\n', i, ce );
			%}
		end
		
		P = softmax((X * obj.W + obj.b)')';
		P = max(P, 1E-12);
	    obj.ce = -mean(sum(log(P) .* Y, 2));
	    
	    [m,ind_pred] = max( P, [], 2 );
	    [m,ind_true] = max( Y, [], 2 );
	    m = double(m==1);
	    
	    obj.acc = sum( double( ind_pred == ind_true ) .* m ) / sum(m);
     end
     
     function [pred,proba] = pred_proba( obj, X, classnames )
       proba = softmax((X * obj.W + obj.b)')';
       [m,pred] = max( proba, [], 2 );
       
       if( exist( 'classnames', 'var' ) && ~isempty(classnames) )
		   if( strcmpi( class(classnames), 'categorical' ) )
		    classnames = sort(categories(classnames));
		   end
	       pred = categorical( classnames( pred ) );
       end
     end
   end
   methods(Static)
		function d = smooth( d, th1, th2 )
			s = sign(d);
			d = abs(d);
			th1 = th1-th2;
			d = max( d-th2, 0 );
			m = double(d<th1);
			d = m .* (0.5/th1*(d.*d)) + (1-m) .* (d-0.5*th1);
			d = s .* d;
        end
        
		function [rho, num_iter, reg, smooth_th1, smooth_th2, unknown] = parse_args( args )
		  rho = 0.001;
		  num_iter = 1000;
		  reg = 0.0001;
		  smooth_th1 = 0.80;
		  smooth_th2 = 0.95;
		  unknown = 'unknown';
		  
		  i=1;
		  while( i < numel(args) )
		    if( strcmpi( args{i}, 'rho' ) )
		      i = i + 1;
		      rho = args{i}(1);
		    elseif( strcmpi( args{i}, 'num_iter' ) )
		      i = i + 1;
		      num_iter = args{i}(1);
		    elseif( strcmpi( args{i}, 'reg' ) )
		      i = i + 1;
		      reg = args{i}(1);
		    elseif( strcmpi( args{i}, 'smooth' ) )
		      i = i + 1;
		      smooth_th1 = args{i}(1);
		      smooth_th2 = args{i}(2);
		    elseif( strcmpi( args{i}, 'unknown' ) )
		      i = i + 1;
		      unknown = args{i};
		    else
		      msg = sprintf( 'Unknown option for MCLR.fit: %s\n', string( args{i} ) );
		      warning( msg );
		    end
		    
		    i = i + 1;
          end
	  end
    end
end

