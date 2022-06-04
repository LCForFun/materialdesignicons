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


/**
Type: library

Title: Material Design Icons library

Author: LiveCode

Version: 1.0.1

SVGIcon: M12.87 15.07l-2.54-2.51.03-.03c1.74-1.94 2.98-4.17 3.71-6.53H17V4h-7V2H8v2H1v1.99h11.17C11.5 7.92 10.44 9.75 9 11.35 8.07 10.32 7.3 9.19 6.69 8h-2c.73 1.63 1.73 3.17 2.98 4.56l-5.09 5.02L4 19l5-5 3.11 3.11.76-2.04zM18.5 10h-2L12 22h2l1.12-3h4.75L21 22h2l-4.5-12zm-2.62 7l1.62-4.33L19.12 17h-3.24z

OS: mac, windows, linux, ios, android

Platforms: desktop, mobile, web

Summary:  Material Design Icons' growing icon collection allows designers and developers targeting various platforms to download icons in the format, color and size they need for any project. 

Description:
This library has over 6700 material design icons from the community. All information regarding the license of the icons and their authors can be found at https://materialdesignicons.com/.
*/
local sResourcesFolder
//TODO
--function SVGPicker pView, pIconFamily
--   -- pView: List, Grid
--   -- pIconFamily: De las familias de LC o MD
--end SVGPicker



private command _startlibraryIcons
   set the itemdel to slash
   
   put item 1 to - 2 of (the filename of me) & "/resources" into sResourcesFolder
   
   get addIconFamily("MaterialDesignIcons",_materialDesignIconsArray())
   	
end _startlibraryIcons


private function _materialDesignIconsArray
   local tStack, tResutl
   
   put the short name of stack(sResourcesFolder & "/svg.livecodescript") into tStack
   set the destroyStack of stack tStack to true
   put the cMaterialDesignSVGs of stack tStack into tResutl
   close stack tStack
   if there is stack tStack then delete stack tStack
   return tResutl
end _materialDesignIconsArray
