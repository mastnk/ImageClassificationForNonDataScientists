function c =onehot2categorical( onehot, classnames )
  if( strcmpi( class(classnames), 'categorical' ) )
    classnames = sort(categories(classnames));
  end
  c = onehotdecode(onehot, classnames, 2);
end
