#!/bin/bash

#(전제 조건)
#가. 자신의 작업계정으로 로그인함
#나. 작업은 자신의 홈 경로(/home/ljb/....)에서만 이루어짐
#다. 작업 디렉토리 생성시 존재하거나 장애 발생하면 강제 종료함
#라. 결과은 아래와 같이 출력되어야 함.
#마. 입력은 임의의 값으로 입력됨.

src_dir=""		#(1)이동경로
dst_dir=""		#(2)최종경로
result_file=""	#(3)결과파일명
tar_file=""		#압축파일

echo "---- 작업 시작 ----"
# 출발지 전체 경로명(1)을 입력받는다.
echo "[출발지 전체 경로명]을 입력하세요."		# (1)
read src_dir

if [ -d "$src_dir" ]; then
    echo
else
    echo "[경고]'${src_dir}'는 존재하지 않는 작업경로입니다"
	exit 0
fi
# 도착지 전체 경로명(2)을 입력받는다.
	echo "[도착지 전체 경로명]을 입력하세요."	# (2)
	read dst_dir

if [ -d "$dst_dir" ]; then
    echo
else
    echo "[경고]'${dst_dir}'는 존재하지 않는 이동경로입니다"
	exit 0
fi

# 결과파일명(3)을 입력받는다.
	echo "[결과 파일명]을 입력하세요."			# (3) 
	read result_file
	echo

# 임의 생성 파일갯수 n(4)개를 입력받는다.
echo "[생성파일 갯수]를 입력하세요."			# (4)
read count_file

# 파일갯수 n(4)만큼 출발지 경로(1)에 
# work1.log, work2.log..... workn.log 파일 형태로 생성한다.
for (( i = 1; i <= count_file; i++))
do
	touch ${src_dir}/work${i}.log
	echo
	echo "${src_dir}/work${i}.log 이 생성되었습니다."
	echo
done

# 출발지 전체 경로(1)를 압축하여
echo "압축을 진행합니다."
tar_file=src_dir.tar.gz
tar -zcvf ${tar_file} ${src_dir}
echo "${tar_file} 이 생성되었습니다."
echo

# 도착지 전체 경로명(2)에 이동 후 압축해제한다.
mv ${tar_file} ${dst_dir}
echo "파일을 이동하였습니다."
echo

tar -xzvf ${dst_dir}/${tar_file} -C ${dst_dir}
untar_file=${dst_dir}/${tar_file}
echo "${tar_file} 파일이 압축 해제되었습니다." 
echo

# 도착지 전체 경로명(2)에서 압축 파일을 삭제한다.
rm -rf ${untar_file}
echo "${tar_file} 파일을 삭제하였습니다."
echo

# 도착지 전체 경로(2)의 파일 목록을 출력하여 결과파일(3)을 작성한다.
final_dir=${dst_dir}/${result_file}
for list in `ls -R $dst_dir`
do
	echo -R ${dst_dir}/* "/$list" >> ${final_dir}
done
	echo "복사한 파일 목록 파일을 생성하였습니다."
	echo ${final_dir}

echo "---- 작업 종료 ----"

