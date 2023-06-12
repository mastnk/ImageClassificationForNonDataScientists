function onehot =categorical2onehot( c, unknown )
  if(  ~exist('unknown','var') )
    unknown = [];
  end

  classnames = sort(categories(c));
  if( ~isempty( unknown ) )
    classnames( find( strcmpi(classnames, 'unknown')) )=[];
  end
  onehot = onehotencode(c, 2, 'Classnames', classnames );

  onehot(isnan(onehot)) = 1.0/numel(classnames);

end
