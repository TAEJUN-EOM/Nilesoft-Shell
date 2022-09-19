#!/bin/bash

echo "---- 작업 시작 ---"
echo "작업 결로를 입력하세요"
read wkpath

echo
echo "신규 디렉터리명을 입력하세요"
read newdir
mkdir ${newdir}

echo
echo "이동경로를 입력하세요"
read mvpath
echo

newfile=""
newdir=""

while true
do
	echo "생성 파일을 입력하세요. 완료시 e를 입력하세요."
	read newfile
	echo

	if [ "${newfile}" = "e" ];then
		echo "파일 생성 종료 : ${newfile}"
		break;
	else
		if [ test -f ${newfile} ];then
			echo "파일이 이미 존재합니다. : ${newfile}"
			break;
		else
			touch ${wkpath}/${newdir}/${newfile}
			echo "파일을 생성하였습니다. ${wkpath}/${newdir}/${newfile}"
			echo
		fi
	fi
done

new_tar_file=${newdir}.tar.gz
    
tar -zcvf ${new_tar_file} ${wkpath}/${newdir} 
echo "압축 파일  : ${new_tar_file}"
 
mv -f ${new_tar_file} ${mvpath}
if [ $? -gt 0 ]
then
        tput bold
	echo "ERROR : 이동 경로[${mvpath}]의 권한이 없습니다.. LINE NUMBER: $LINENO"
        tput sgr0
	echo
	exit 400
fi
        
echo "이동 결과  : ${wkpath}/${newdir}/${new_tar_file}"
echo "---- 작업 종료 ----"
