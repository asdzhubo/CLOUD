需要将ecp.sh和eip.sh提前放入到后端盘中
# mv /root/ecp.sh  /root/.ecp.sh     //将文件更改为隐藏文件
# mv /root/eip.sh  /root/.eip.sh
将ecp.sh写入/etc/rc.local文件中
#vim /etc/rc.local
  .....
  /root/ecp.sh
:wq
# chmod +x /etc/rc.d/rc.local

注意：提前给脚本执行权限
