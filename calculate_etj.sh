#!/bin/bash

echo "--- 계산 시작 ----"
echo "인자값을 입력하시오."
read n1 n2 n3

echo "인자1: $n1"
echo "연산자: $n2"
echo "인자2: $n3"

case $n2 in
	'+') cal=`expr $n1 + $n3`;;
	'-') cal=`expr $n1 - $n3`;;
	'/') cal=`expr $n1 / $n3`;;
	'%') cal=`expr $n1 % $n3`;;
	'*') cal=`expr $n1 \* $3`;;
esac

echo "결과 : ${cal} = ${n1} ${n2} ${n3}"
echo "---결과종료---"

