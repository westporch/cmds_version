#!/bin/bash

#HyunGwan Seo

OLD_CMDS_TXT_INCLUDE_Lbracket=old-OS_cmds-Lbracket.txt
NEW_CMDS_TXT_INCLUDE_Lbracket=new-OS_cmds-Lbracket.txt

OLD_CMDS_TXT=old-OS_cmds.txt
NEW_CMDS_TXT=new-OS_cmds.txt

RESULT_TXT=result.txt

#new OS의 디렉토리에 있는 명령어들을 하나의 텍스트 파일에 저장함.
function create_cmds_txt()
{
        newOS_dir_arr=("/bin" "/sbin" "/usr/local/bin" "/usr/local/sbin")

        for ((idx=0; idx < ${#newOS_dir_arr[@]}; idx++))
        do
       		 ls --color=no ${newOS_dir_arr[$idx]} | sort >> $NEW_CMDS_TXT_INCLUDE_Lbracket

        done
	
	#Left bracket([)을 제거함
	sed -e "/\[/d" $NEW_CMDS_TXT_INCLUDE_Lbracket | sort > $NEW_CMDS_TXT

	rm -rf $NEW_CMDS_TXT_INCLUDE_Lbracket
}

function print_cmds_version()
{
	readarray -t cmds_arr < $NEW_CMDS_TXT
	
	for ((idx=0; idx < ${#cmds_arr[@]}; idx++ ))
	do	

		${cmds_arr[$idx]} --version >& /dev/null
		status=$?

		echo -e "${cmds_arr[$idx]} 명령어 버전 확인 중..."

		if [ $status = 0 ]; then # 버전 정보를 확인할 수 있는 경우

			echo -e "${cmds_arr[$idx]}\t \
				`${cmds_arr[$idx]} --version | head -1 | \
	 			egrep -o '[0-9]+(\.[0-9]+)+(-[0-9]+.[a-z0-9]+_[0-9]*(\.[0-9]*)*)*' | \
		 		sed -e '2,$d'`" >> $RESULT_TXT
		else	 # 버전 정보를 확인할 수 없는 경우
			echo -e "${cmds_arr[$idx]}\t 버전 정보 없음" >> $RESULT_TXT
		fi
	done
}


create_cmds_txt
print_cmds_version
