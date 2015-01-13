热备自动化控制器的配置流程

##安装

解压安装包beats.zip，在root用户下，执行install命令，进行软件安装。

	$ su - root
	# unzip beats.zip
	# cd beats
	# ./install

重启系统后，控制器已开始工作。

##参数配置

配置文件遵循约定大于配置的思想，提供了默认的启动参数，只需根据实际需求进行部分修改。

	# 热备自动化控制器配置文件
	# 需要注意的是配置文件采用的是 properties 格式，因此等号(=) 两边不能出现空白符
	# 需要时可用转义符转义

	############################################
	#
	#    heartbeat程序控制模块
	#
	############################################

	# 是否开启热播模式
	cfg_beat=true

	# 当机器是否作为热备的主机(primary)
	cfg_major=true

	# heartbeat的虚拟IP
	cfg_vip=12.22.192.101


	#############################################
	#
	#    虚拟IP监视模块
	#
	#############################################

	# 监视周期，单位为秒
	cfg_monitor_interval=10000

	# 监视线程，负责各个模块的状态监视
	cfg_switchguard_jar=/usr/local/beats/SwitchGuard.jar

	# 监视线程的控制单元，控制应用程序模块，数据库同步模块的工作
	cfg_monitor_script=/usr/local/beats/vip_monitor.sh


	#############################################
	#
	#    应用程序部署模块
	#
	##############################################

	# 配置应用的部署位置
	cfg_app1=\ -Das.home=/opt/HJZYWG/as\ /opt/HJZYWG/as/bin/App.jar

	# 控制器的安装目录
	cfg_basepath=/usr/local/beats

	# 应用程序的运行日志
	cfg_runtimelogname=runtime.log

	# 应用程序运行标识
	cfg_runningpid=running.pid

	# tomcat 服务器地址
	cfg_tomcat_bin=/usr/java/apache-tomcat-7.0.37/bin

	# Web服务器运行端口
	cfg_tomcat_port=8080


	#############################################
	#
	#    数据库同步模块
	#
	##############################################

	# 是否启用数据库同步
	cfg_dbsync_mode=true

	# 数据库同步周期，单位为秒。间隔太短，可能引起数据库异常 
	cfg_dbsync_interval=10000

	# 当前机器对应的数据库连接地址
	cfg_dbsync_url=jdbc:oracle:thin:@12.22.192.142:1521:orcl

	# 当前机器的数据的用户名
	cfg_dbsync_username=hqwg

	# 当前机器的数据的密码
	cfg_dbsync_password=hqwg

	# 当前机器的数据的链接名(不建议修改)
	cfg_dbsync_linkname=stby
	generated by haroopad