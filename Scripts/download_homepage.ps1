#!/bin/sh

backup()
{
	URL=$1
	wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
}

backup $1
