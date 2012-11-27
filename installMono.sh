#!/bin/sh
MONO=mono-3.0.1
XPS=xsp-2.10.2
SRCFOLDER=/usr/local/src/

echo Installing ${MONO}

#Install dependencies
echo Installing ${MONO} dependencies
yum install bison gettext glib2 freetype fontconfig libpng libpng-devel libX11 libX11-devel glib2-devel libgdi* libexif glibc-devel urw-fonts java unzip gcc gcc-c++ automake autoconf libtool make bzip2 wget git -y

#Change to standard source folder
cd ${SRCFOLDER}

#Get sources from mono-project site
echo Getting ${MONO} source
wget -q -S "http://download.mono-project.com/sources/mono/${MONO}.tar.bz2"

#Uncompress file
echo Uncompressing ${MONO}
tar jxf ${MONO}.tar.bz2

#Move to folder
cd ${MONO}

#Compile
echo Compiling ${MONO}
./autogen.sh --prefix=/usr/local
make
make install

# FastCGI
cd ${SRCFOLDER}
echo Getting ${XPS} source
wget -q -S "http://download.mono-project.com/sources/xsp/${XPS}.tar.bz2"

echo Uncompressing ${XPS}
tar jxf ${XPS}.tar.bz2

#Move to folder
cd ${XPS}

#Compile FastCGI
echo Compiling ${XPS}
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
echo $PKG_CONFIG_PATH
pwd
./configure --prefix=/usr/local
make
make install