﻿script "com.livecode.library.materialdesignicons"
/* Copyright (C) 2022 LiveCode Ltd.
* All rights reserved.
*
* LiveCode Ltd. grants you a non-exclusive limited license to use this file,
* with or without modification, with the LiveCode product and in standalones
* built using the LiveCode product.
*
* Redistribution in source form, with or without modification, is permitted
* to other licensees of the LiveCode product provided that the following
* conditions are met:
*
* * Redistributions of source code must retain the above copyright notice,
*   this list of conditions and the following disclaimer.
*
* * The name LiveCode Ltd. may not be used to endorse or promote products
*   derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY LIVECODE LTD. ''AS IS'' AND ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
* IN NO EVENT SHALL LIVECODE LTD. BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
* NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
* THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

on extensionInitialize
   if the target is not me then
      pass extensionInitialize
   end if


   if the environment contains "development" then
      set the _ideoverride of me to true
      local tName
      put the short name of me into tName
      revSBAddDependencyForInclusion "extensions", tName, "extensions", "com.livecode.widget.svgpath"
      revSBAddDependencyForInclusion "extensions", tName, "extensions", "com.livecode.library.iconsvg"
      send  script  "_startlibraryIcons" to me in 1 sec
   else
      send  script  "_startlibraryIcons" to me in 0 sec
   end if

   insert the script of me into back
end extensionInitialize


on extensionFinalize
   if the target is not me then pass extensionFinalize
   get deleteIconFamily("Material Design Icons" )
   remove the script of me from back
end extensionFinalize

/**
Type: library

Title: Material Design Icons

Version: 1.0.0

Author: LiveCode

SVGIcon: M2,2H8V4H16V2H22V8H20V16H22V22H16V20H8V22H2V16H4V8H2V2M16,8V6H8V8H6V16H8V18H16V16H18V8H16M4,4V6H6V4H4M18,4V6H20V4H18M4,18V20H6V18H4M18,18V20H20V18H18Z

OS: mac, windows, linux, ios, android

Platforms: desktop, mobile, web

Summary: 6700+ Material Design Icons from the Community 

Description:
This library has over 6700 material design icons from the community. All information regarding the license of the icons and their authors can be found at [materialdesignicons.com](https://materialdesignicons.com).

**/

local sResourcesFolder

/**
Select an SVG icon from one of the loaded icon families.

OS: mac, windows, linux

Platforms: desktop

Syntax: iconPicker([<pIconFamilyName>])

Example:
on mouseUp pButtonNumber
   local tIconName
   put iconPicker() into tIconName
   
   if tIconName["name"] is not empty then
      set the iconPresetName of widget "SVG Icon" to tIconName["name"]
   end if
end mouseUp


Example:
on mouseUp pButtonNumber
   local tIconPath
   put iconPicker() into tIconPath
   
   if tIconPath["path"] is not empty then
      set the iconPath of widget "SVG Icon" to tIconPath["path"]
   end if
end mouseUp

Description:
Use the <iconPicker> function to display an svg icon picker.

Parameters:
pIconFamilyName: This parameter defines which icon family will be selected when opening the picker.

Returns:
This function returns an array with three keys. One with the name of the selected icon, another with its SVG path and one with the codepint of the icon.
**/
function iconPicker pIconFamilyName
   local tStack, tResutl
   
   if pIconFamilyName is among the lines of iconFamilies() then
      setCurrentIconFamily(pIconFamilyName)
   end if
   
   try
      lock messages
      _destroyStack "TemplateIconPicker"
      put the short name of stack (sResourcesFolder & "/TemplateIconPicker.livecode") into tStack
      set the loc of stack tStack to the screenLoc
      
      if the environment contains "development" then
         set the _ideoverride of  stack tStack to true
      end if
      
      modal stack tStack
      _destroyStack tStack
      _destroyStack "TemplateIconPicker"
      
      unlock messages
   end try
   
   return  the dialogData 
end iconPicker
   
   
   
private command _startlibraryIcons
   local tIconsArray

   set the itemdel to slash

   put item 1 to - 2 of (the filename of me) & "/resources" into sResourcesFolder
   put _materialDesignIconsArray() into tIconsArray

   if tIconsArray is an array and "Material Design Icons" is not among the lines of iconFamilies()
   then get addIconFamily("Material Design Icons", tIconsArray)
   _destroyStack "MaterialDesignSVGs"

end _startlibraryIcons


private function _materialDesignIconsArray
   local tStack, tResutl

   try
      _destroyStack "MaterialDesignSVGs"
      put the short name of stack( sResourcesFolder & "/MaterialDesignSVGs.livecode") into tStack
      put the cMaterialDesignSVGs of stack tStack into tResutl
      _destroyStack tStack
      _destroyStack "MaterialDesignSVGs"
   end try

   return tResutl
end _materialDesignIconsArray


private command _destroyStack pStackName
   if there is not a stack pStackName then exit _destroyStack
   close  stack pStackName
   set the destroyStack of stack pStackName to true

   if there is not a stack pStackName
   then delete stack pStackName
end _destroyStack

-----------------------------------------
