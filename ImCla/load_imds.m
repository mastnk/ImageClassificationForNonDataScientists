function imds = load_imds( folder, subfolders )
    if( ~exist( 'subfolders', 'var' ) || isempty( subfolders) )
        subfolders=true;
    end
	imds=imageDatastore(fullfile(folder), "IncludeSubfolders",subfolders,"LabelSource","foldernames");
end
