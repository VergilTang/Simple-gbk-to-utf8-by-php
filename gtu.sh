#! /bin/bash

#gbk转utf-8
IFSbak=$IFS
IFS="~"	#这里用一个不常用的符号就好
while read svnResult
do
	svnResult=${svnResult//\"/\\\"}
	svnResult=${svnResult//\{/\\\{}
	svnResult=${svnResult//\}/\\\}}
	svnResult=${svnResult//\$/\\\$}
	svnResult=${svnResult//\*/\\\*}
	paramString="echo mb_convert_encoding(\"""${svnResult}""\",\"utf-8\",\"gbk\")"";"
	result=`php -r "$paramString"`
	result=${result//\\\"/\"}
	result=${result//\\\{/\{}
	result=${result//\\\}/\}}
	# svnResult=${svnResult//\\\$/\$}
	echo $result
done
IFS=$IFSbak