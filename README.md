海康微视 ios sdk armv7 arm64 i386 

移植demo代码到你的项目中的时候需要注意两个地方.。编译设置：
因为SDK采用的是C代码编写，所以需要应用设置混编设置:
1、使用系统默认或选择stdlibc++模式编译。
2、在第一次调用的地方，如demo中，更改AppDelegate.m文件的后缀为.mm如果不设置这两项，编译时出现std::错误。
3、需要在other link flags 加上-ObjC字段，这样可以保证视频通话可以看到头像。
