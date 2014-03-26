#!/bin/bash

##########################################################################
#
#    hivedump: Safely dump credentials in Linux from remote Windows servers 
#    Copyright (C) 2014 Jonathan Roach
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Contact: jonnyhightower [at] funkygeek.com
#
##########################################################################

# This is the application installer

# Prefix where the application will be installed
PREFIX=/usr/local
# Prefix where the binaries will be linked from
BINPREFIX=/usr

# I use this installer for different applications
APPNAME=hivedump

# Check dependencies
DEPENDENCIES="winexe"

# And do the installation
DEPERR=0
for criticalDepends in $DEPENDENCIES; do
	if ! type $criticalDepends >/dev/null 2>&1; then
		echo "Critical dependency $criticalDepends not found in \$PATH".
		DEPERR=1
	else
		_PATH=`type $criticalDepends | grep -v alias | awk {print'$3'}`
		if [ ! -x "$_PATH" ]; then
			echo "Critical dependency $criticalDepends not found in \$PATH".
			DEPERR=1
		fi
	fi
done

if [ $DEPERR -gt 0 ]; then
	echo "Not installing - critical dependencies missing."
	exit $DEPERR
fi

if [ ! -d "${PREFIX}/share/$APPNAME" ]; then
	mkdir -p "${PREFIX}/share/${APPNAME}/"
	if [ -d upload ]; then
		cp -a upload "${PREFIX}/share/${APPNAME}/"
		if [ -d "${PREFIX}/share/${APPNAME}/" ]; then
			cat $APPNAME | sed -e "s?APPLICATIONBASEDIRECTORY?${PREFIX}/share/$APPNAME?" > ${PREFIX}/share/$APPNAME/$APPNAME
			chmod -R 555 ${PREFIX}/share/$APPNAME/
			ln -s "${PREFIX}/share/$APPNAME/$APPNAME" "${BINPREFIX}/bin/$APPNAME"

			echo "Installation of $APPNAME is complete, and $APPNAME should now be in your path."
			exit 0
		else
			echo "Couldn't create directory ${PREFIX}/share/$APPNAME"
			exit 1
		fi
	else
		echo "Installation package is broken. Quitting."
		exit 1
	fi
else
	echo "${PREFIX}/share/$APPNAME already exists. Use uninstall.sh to remove it first before installing this version"
	exit 1
fi


