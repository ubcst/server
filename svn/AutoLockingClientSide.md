# SVN: Automatic Needs-Lock Property (Client Side)
This is a brief tutorial that explains how to set up an SVN client to automatically apply the "**needs-lock**" property to all new files.

## Requirements
This tutorial assumes you have **TortoiseSVN** installed on your computer. If you don't have **TortoiseSVN**, you can download it here: https://tortoisesvn.net/downloads.html

This tutorial also assumes that when you right-click in a folder, you can view the TortoiseSVN context menu (see image below).

![alt text](https://raw.githubusercontent.com/ubcst/server/master/svn/images/ContextMenu.png "TortoiseSVN Context Menu")

If you are unable to view the Context Menu, the best way to get it is to uninstall and reinstall TortoiseSVN.

## Steps
1. Right click anywhere in a directory. The Context Menu should appear.
2. Click on the "**TortoiseSVN**" option.
3. Go down and click on the "**Settings**" option. The "**Settings**" menu should appear (see image below).
![alt text]( https://raw.githubusercontent.com/ubcst/server/master/svn/images/SettingsMenu.png "Settings Menu")
4. Click on the "**Edit**" button. A file should open.
5. Look for the line that says ```# enable-auto-props = yes``` and change it to ```enable-auto-props = yes```
6. Look for the line that reads ```[auto-props]```
7. Directly below the ```[auto-props]``` line, add the following: ```* = svn:needs-lock=*```
8. Save and close the file.
9. Click the "**OK**" button in the "**Settings Menu**".

And that's it. All new files you add to a repository will automatically have the "**needs-lock**" property set.

_**NOTE:** The automatic setting of this property gets applied to only new files. It does not apply to files that were already added or existing in the repostitory._
