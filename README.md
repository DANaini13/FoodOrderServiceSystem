# Online Food Order Service
(中文版本请参看[这里](#foodOrder_cn))

## Environment Requirements
### Server
> 1. JDK 1.8+
> 2. Maven

### Client
> 1. Xcode 7.0+
> 2. IOS 8.0+
> 3. CocoaPod

## Setup and Running Instructions
### Server
> 1. Transfer to the ```FoodOrderServer``` directory which includes the ```pom.xml``` file.
> 2. Run ```mvn package``` in the terminal and waiting for package finished.
> 3. Run ```mvn exec:java``` in the terminal.

### Client
> 1. Transfer to the ```foodOrderApp``` directory which includes Podfile
> 2. Run ```pod install``` in the terminal. (first time only)
> 3. Run ```open foodOrderApp.xcworkspace``` in the terminal to open the project in Xcode.
> 4. Select one of the ipad device and click the green play button on the right up corner to run the Client.

## System Architure

### Server

### Client


## <a name="foodOrder_cn"></a>
# 在线点菜系统

## 环境要求
### 服务器程序
> 1. JDK 1.8+
> 2. Maven

### 客户端程序
> 1. Xcode 7.0+
> 2. IOS 8.0+
> 3. CocoaPod

## 环境搭建及运行指令
###服务器程序
> 1. 从 ```终端```中打开 ```FoodOrderServer```文件夹，查看文件夹中是否存在```pom.xml```文件以确保路径正确。
> 2. 运行 ```mvn package```，等待打包完成。
> 3. 运行 ```mvn exec:java``` 指令。

###客户端程序
> 1. 从 ```终端```中打开 ```foodOrderApp``` 文件夹，查看文件夹中是否存在```Podfile```文件以确保路径正确。
> 2. 在 ```终端```中运行 ```pod install``` 指令。 （仅第一次执行）
> 3. 在 ```终端```中运行 ```open foodOrderApp.xcworkspace``` 指令来通过 Xcode 打开项目。
> 4. 选择任意Ipad 设备，点击 Xcode 左上角的绿色播放按钮来运行客户端.