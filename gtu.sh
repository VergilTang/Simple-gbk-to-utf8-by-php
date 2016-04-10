#! /bin/bash

from='gbk'
to='utf-8'
while getopts f:t:
do
    case "$opt" in
        f)
            from=$OPTARG;;
        t)
            to=$OPTARG;;
        h)
            echo "参数:"
            echo "-h        show this help"
            echo "-f        from charset default gbk"
            echo "-t        to charset default utf-8"
    esac        
done
IFSbak=$IFS
IFS="~"	#这里用一个不常用的符号就好
while read svnResult
do
	svnResult=${svnResult//\"/\\\"}
	svnResult=${svnResult//\{/\\\{}
	svnResult=${svnResult//\}/\\\}}
	svnResult=${svnResult//\$/\\\$}
	svnResult=${svnResult//\*/\\\*}
	paramString="echo mb_convert_encoding(\"""${svnResult}""\",\"${to}\",\"${from}\")"";"
	result=`php -r "$paramString"`
	result=${result//\\\"/\"}
	result=${result//\\\{/\{}
	result=${result//\\\}/\}}
	# svnResult=${svnResult//\\\$/\$}
	echo $result
done
IFS=$IFSbak
