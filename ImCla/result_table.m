function [tbl, acc] = result_table( pred, proba, imds_test )
 true_label = imds_test.Labels;
 [filepath, filename, exts] = fileparts( imds_test.Files );
 for i=1:numel(imds_test.Files)
     filename{i} = [filename{i}, exts{i}];
 end
 
 classnames = sort(categories(true_label));
 classnames( find( strcmpi(classnames, 'test')) )=[];
 pred_label = categorical(classnames(pred));
 [proba,ind] = max( proba, [], 2 );
 tbl = table( filename, true_label, pred_label, proba );
 
 if( sum( true_label ~= 'test' ) > 0 )
   acc = sum( double( true_label == pred_label ) ) / sum( true_label ~= 'test' );
 else
   acc = nan;
 end
end

