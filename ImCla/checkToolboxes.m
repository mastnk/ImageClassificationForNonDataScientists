% reqToolboxes = {'Deep Learning Toolbox'};
% checkToolboxes(reqToolboxes);
%
% license( 'inuse' ) 
% return the used licensed before this command is invoked.
% Note the name of license is sometime not official name.
function checkToolboxes(req)

if( ~checkReq(req) )
 msg = sprintf( 'It requires the following toolboxes:\n' );
 for i=1:numel(reqToolboxes)
   msg = [msg,sprintf( ' %s\n', reqToolboxes{i} )];
 end
 error( msg );
end

end

function ret = checkReq(req)
info = ver;
s=size(info);

flg = zeros(size(req));
reqSize = size(req,2);

for i=1:s(2)
 for j=1:reqSize
  if( strcmpi(info(1,i).Name,req{1,j}) )
   flg(1,j)=1;
  end
 end
end
ret = prod(flg);

end
