# Terraform for Bare Metal Cloud - 指南 #

## 配置步骤 ##

+ [阅读FAQ，了解什么是Terraform，和Bare Metal Cloud有什么关系？](https://github.com/oracle/terraform-provider-baremetal/blob/master/docs/FAQ.md)

+ [阅读并根据README指导配置Bare Metal账号、下载Terraform程序、下载Terraform Provider、配置Terrform初始环境](https://github.com/oracle/terraform-provider-baremetal/blob/master/README.md)

+ 将整个Bare Metal Terraform Provider的项目克隆下来，并不是必须的，因为blob/master/docs/examples/目录下有不少很好的例子，方便玩耍。

	`git clone https://github.com/oracle/terraform-provider-baremetal.git`

+ 什么是Refined BMC Terraform Example?

	- single-instane: 官方的例子中计划创建完成后登录Linux Instance, 在Guest OS级别看不到Attach的Block Deivce, 还得执行iSCSI命令。这里解决了这个最后一公里。

	- single-instance-windows: 官方没有提供Windows的例子。弥补这个遗憾。在计划执行后，登录Windows VM, 查看Server Manager\File and Storage Services\Volumes\Disks，可以观察到与VM一起创建并Attach的256GB的卷。如果看不到, 即便是refresh后还是看不到, 请仔细阅读single-instance-windows/README.MD文件。坑比较很多, 请注意。
