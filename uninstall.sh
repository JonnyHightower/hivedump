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

# Prefix where application should be installed
PREFIX=/usr/local
# Prefix where the binaries are linked from
BINPREFIX=/usr

# I use this uninstaller for different applications
APPNAME=hivedump

if [ -d "${PREFIX}/share/${APPNAME}/upload" ]; then
	echo "Removing ${APPNAME}"
	rm -r "${PREFIX}/share/${APPNAME}/"
	if [ -L "${BINPREFIX}/bin/${APPNAME}" ]; then
		rm "${BINPREFIX}/bin/${APPNAME}"
	fi
	exit 0
else
	echo "${APPNAME} doesn't appear to be installed!"
	exit 1
fi


