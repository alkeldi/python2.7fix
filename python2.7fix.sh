#!/bin/bash

#Downloaded python2.7 (the latest version before deprecation is 2.7.16)
if [ -f "python-2.7.16-macosx10.9.pkg" ]; then
    echo "✅ Using python2.7.16 from a previoud run."
else
    curl -O https://raw.githubusercontent.com/alkeldi/python2.7fix/master/python-2.7.16-macosx10.9.pkg
    if [ $? != 0 ]; then 
        echo "Failed to download python2.7.16"
        exit 1
    fi
    echo "✅ Downloaded python2.7.16"
fi

#Verify python2.7.16 checksum
real_checksum=a3af70c13c654276d66c3c1cb1772dc7
current_checksum=$(md5 python-2.7.16-macosx10.9.pkg | awk '{print $4}' )
if [ $real_checksum != $current_checksum ]; then
    echo "Failed to verify python2.7.16 checksum"
    echo "expected:   $real_checksum"
    echo "calculated: $current_checksum"
    exit 1
fi
echo "✅ Verified python2.7.16 checksum"

#Install python2.7.16
sudo installer -pkg python-2.7.16-macosx10.9.pkg -target /Applications
if [ $? != 0 ]; then 
    echo "Failed to install python2.7.16"
    exit 1
fi
exho "✅ Installed python2.7.16"

#Add python to PATH
bash /Applications/Python\ 2.7/Update\ Shell\ Profile.command 
if [ $? != 0 ]; then 
    echo "Failed to add python2.7.16 to the PATH"
fi
echo "✅ Added python2.7.16 to PATH"

#Cleanup
rm python-2.7.16-macosx10.9.pkg

#Done
echo "✅ Completed fixing python2.7.16"
echo "❗️Note: you might need to reboot the system so the currently running apps can use the new version of python."
