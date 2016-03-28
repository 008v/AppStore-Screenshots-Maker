#!/bin/bash
#
#    AppStore Screenshots maker
#
#            written by QinWei
#
#                   2016-03-28
#
##########################################################
#
# 用于AppStore图片的快速生成
# 桌面上的png文件一旦数量到了5张，则自动更改出4种iPhone尺寸的图片
#
# 使用方法：
# 1.打开终端，运行sh AppStore_Screenshots_Maker.sh
# 2.模拟器截图，会在你的桌面上生成图片，截图5张即可
# 3.桌面上会划分出来包含4种尺寸图片的目录
#
# 注意：
# 1.结束脚本，用control + z
# 2.screenShotDir这个目录可以更改
# 3.screenShotDir下面请不要放其他png文件


screenShotDir=~/Desktop

while 1>0
do
    count=`find ${screenShotDir} -type f -depth 1 -iname "*.PNG" -o -iname "JPG"|wc -l|sed "s/       //"`

    if [ $count == "5" ];then
        rm -rf /5.5
        rm -rf ${screenShotDir}/4
        rm -rf ${screenShotDir}/3.5
        rm -rf ${screenShotDir}/4.7
        mkdir -p ${screenShotDir}/5.5
        mkdir -p ${screenShotDir}/4
        mkdir -p ${screenShotDir}/3.5
        mkdir -p ${screenShotDir}/4.7

        num=1

        for image in `find ${screenShotDir} -type f -depth 1 -iname "*.PNG" -o -iname "JPG"|tr " " "\?"`
        do
            ext=${image:0-3}

            cp -f "${image}" ${screenShotDir}/5.5/${num}.${ext}
            sips -z 2208 1242 ${screenShotDir}/5.5/${num}.${ext}

            cp -f "${image}" ${screenShotDir}/4.7/${num}.${ext}
            sips -z 1334 750 ${screenShotDir}/4.7/${num}.${ext}

            cp -f "${image}" ${screenShotDir}/4/${num}.${ext}
            sips -z 1136 640 ${screenShotDir}/4/${num}.${ext}

            cp -f "${image}" ${screenShotDir}/3.5/${num}.${ext}
            sips -z 960 640 ${screenShotDir}/3.5/${num}.${ext}

            rm -rf "${image}"

            let num++
        done
    fi
    sleep 1
done

