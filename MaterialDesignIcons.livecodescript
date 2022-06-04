script "MaterialDesignIcons"


on extensionInitialize
   if the target is not me then pass extensionInitialize
   set the _ideoverride of me to true
   insert the script of me into back
   _startlibraryIcons
end extensionInitialize


on extensionFinalize
   if the target is not me then pass extensionFinalize
   remove the script of me from back
end extensionFinalize





function iconMetadata pValue

end iconMetadata



function SVGPicker pView, pIconFamily
   -- pView: List, Grid
   -- pIconFamily: De las familias de LC o MD
end SVGPicker



private command _startlibraryIcons
	get addIconFamily("MaterialDesignIcons",_MaterialDesignIconsArray())
	
	// download metadata of all icons to folder / temp/ 
	_downloadFileWithMetadata
	
end _startlibraryIcons


private command _downloadFileWithMetadata
   local tFilePath

   put _metadataFilePath() into tFilePath
   
   if there is not a file tFilePath then
      libURLDownloadToFile "https://github.com/Templarian/MaterialDesign/blob/master/meta.json", tFilePath
   end if
end _downloadFileWithMetadata


private function _tempFolderPath
	local tFolder
   
	put specialFolderPath("temporary") & "/mdi/" into tFolder
	create folder tFolder
	return tFolder
end _tempFolderPath


private function _metadataFilePath
	return _tempFolderPath() & "meta.json"
end _metadataFilePath




private function _materialDesignIconsArray
   local t
   
   	
   return t
end _materialDesignIconsArray
