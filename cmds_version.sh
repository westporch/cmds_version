#!/bin/bash

#HyunGwan Seo

# 개선할 점
# 1. 예를들어 ping 명령어의 버전을 가져올 수 있도록 수정해야 함 -> iputils-s20121221
#    (정규 표현식 부분 수정해야 함)
# 2. 명령어 버전 옵션은 자동으로 --version, -v, -V로 전환되게 수정하기

NEW_CMDS_TXT_INCLUDE_Lbracket=new-OS_cmds-Lbracket.txt
NEW_CMDS_TXT=new-OS_cmds.txt
RESULT_TXT=result.txt

#new OS의 디렉토리에 있는 명령어들을 하나의 텍스트 파일에 저장함.
function create_cmds_txt()
{
        newOS_dir_arr=("/bin" "/sbin" "/usr/local/bin" "/usr/local/sbin") #검사할 디렉토리를 이 곳에 추가!

        for ((idx=0; idx < ${#newOS_dir_arr[@]}; idx++))
        do
       		 ls --color=no ${newOS_dir_arr[$idx]} | sort >> $NEW_CMDS_TXT_INCLUDE_Lbracket

        done
	
	#Left bracket([)을 제거함
	sed -e "/\[/d" $NEW_CMDS_TXT_INCLUDE_Lbracket | sort > $NEW_CMDS_TXT

	rm -rf $NEW_CMDS_TXT_INCLUDE_Lbracket
}

#리눅스 명령어들의 버전을 구하는 함수
function print_cmds_version()
{
	readarray -t cmds_arr < $NEW_CMDS_TXT
	
	for ((idx=0; idx < ${#cmds_arr[@]}; idx++ ))
	do	

		echo -e "${cmds_arr[$idx]} 명령어 버전 확인 중..."
		
		# 옵션은 -v, -V를 줄 수도 있다.
		${cmds_arr[$idx]} --version >& cmds_run_output.txt  # 예) debugfs -V는 파일로 저장해서 버전을 얻어야 함

			echo -e "${cmds_arr[$idx]}\t \
				`cat cmds_run_output.txt | head -1 | \
	 			egrep -o '[0-9]+(\.[0-9]+)+(-[0-9]+.[a-z0-9]+_[0-9]*(\.[0-9]*)*)*' | \
		 		sed -e '2,$d'`" >> $RESULT_TXT

	done
}

create_cmds_txt
print_cmds_version
