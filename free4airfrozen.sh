#!/bin/bash

#此脚本可以公用 :)，只要把此处的Receiver换成自己的即可
RECEIVER="me.yourbay.airfrozen/.main.core.mgmt.MDeviceAdminReceiver"

function check_device()
{
	[ "$(./adb devices | sed '1d' | grep device)" ] && echo "yes"
	echo
}

function do_grant()
{
	./adb shell dpm set-device-owner "${RECEIVER}"
}

function print_err()
{
	echo -e "\n\n\n【操作失败】如果你操作成功过，则不必理会此错误\n\n\n"
}

# Success: Device owner set to package ComponentInfo{me.yourbay.airfrozen/me.yourbay.airfrozen.main.core.mgmt.MDeviceAdminReceiver}
# Active admin set to component {me.yourbay.airfrozen/me.yourbay.airfrozen.main.core.mgmt.MDeviceAdminReceiver}
function grant()
{
	[ ! "$(check_device)" ] && echo "请将手机【开发者模式】开启并连接到电脑(可使用各种助手比如:360连接)" && return
	result=`do_grant` || print_err && return
	[ "$( echo "${result}" | grep 'Device owner set to package')" ] && echo "恭喜你操作【成功】" && echo "Congrats!!! It\'s [WORKED]" && return
}

cd "$(cd "$(dirname "$0")"; pwd)"
grant