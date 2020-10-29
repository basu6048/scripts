#!/bin/bash

#Assign Variables
ACTION=${1}

echo ${ACTION}
version="1.0.1"

function create_file() {

sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
sudo chkconfig nginx on
sudo aws s3 cp s3://nagarjuna-assignment-webserver/index.html /usr/share/nginx/html/index.html
sudo service nginx start
}

function remove_file() {

sudo service nginx stop
rm -f /usr/share/nginx/html/*
yum remove nginx -y
}

function show_version() {

echo "${1}-12345 - Version - ${version}"
}

function display_help() {

cat << EOF
Usage: ${0} {-c|--create|-r|--remove|-v|--version|-h|--help} <filename>

OPTIONS:
	-c | --create   Create a New File
	-r | --remove   Delete a File
	-v | --version	Show Version of a File
	-h | --help	Display the Command help

Examples:
	Create a New File:
		$ ${0} -c foo.txt
	Delete a File:
		$ ${0} -d foo.txt
	Show Version of a File:
		$ ${0} -v foo.txt
	Display help:
		$ ${0} -h

EOF
}
if [ -z "$ACTION" ]
then
	create_file "${2:-server}"
else
case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		remove_file "${2:-server}"
		;;
	-v|--version)
		show_version "${2:-server}"
		;;
	*)
	echo "Usage ${0} {-c|-h}"
	exit 1
esac
fi
