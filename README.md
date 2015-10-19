소개
--------
리눅스의 전체 명령어 버전을 확인하는 쉘 스크립트입니다.

![cmds_version 실행 화면](https://lh3.googleusercontent.com/-9wfVnrpVGUc/VguKQgE1HFI/AAAAAAAAB4s/i5XtVbeRxOY/s512-Ic42/cmds_version-screenshot.png)
<br>
./cmds_version.sh 실행 후 result.txt 파일을 확인한 모습

실행 방법
--------------

```bash
root@localhost:/home/westporch/Git/cmds_version#./cmds_version.sh
```
 문제점
-------

iptable-xml, ip6tables-restore, rmail, rmail-postfix등의 명령어의 버전을 검사할 때 입력 대기 상태에 빠찌게 됩니다. 

해결책
------

1. cmds_version.sh 명령으로 인해 생성된 result.txt 파일을 삭제합니다. <br>
2. cmds_version.sh 명령으로 인해 생성된 new-OS_cmds.txt 파일을 편집기로 실행합니다. (new-OS$_cmds.txt 파일을 삭제하지 않습니다.) <br>
3. 입력 대기 상태에 빠진 명령어를 삭제해야 합니다. <br>
4. cmds_version.sh 파일을 열어서 create_cmds_txt 함수를 주석 처리합니다. (#create_cmds_txt) <br>
5. ./cmds_version.sh을 실행합니다. 
6. 입력 대기 상태에 빠지 되면 1~5의 과정을 반복합니다. <br>
