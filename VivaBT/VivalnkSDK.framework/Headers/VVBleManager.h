//
//  VVBleManager.h
//  VivalnkSDK
//
//  Created by vivalnk on 2016/11/9.
//  Copyright © 2016年 vivalnk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "VVToolUseClass.h"

typedef NS_ENUM(NSInteger, ScanDeviceType){
    FeverDevice,
    VitalDevice,
    CardiacDevice,
};


@protocol vlBLEDelegates <NSObject>

@optional
/**
  数据集合,Data为key/value格式数据
 */
- (void)onReceiveData:(id)Data;

/**
 获取心率
 get heart rate value.
 @param result heart rate.
*/
- (void)onHeartRateUpdated:(id)result;

/**
 电池状态实时描述
 battery data update
 */
- (void)onReceivedBatteryStatus:(id)result;

/**
 房颤事件
 afib event
 */
- (void)onReceiveEvent:(AfibClass *)afib;

/**
  所有发送到patch的命令执行下三个回调
 */
/**
  start command
 */
- (void)onStart:(id)type;

/**
  complete command
 */
- (void)onComplete:(id)result;

/**
  command error
 */
- (void)onError:(id)error;

@end

@protocol BluetoothConnectListenerDelegate <NSObject>

@optional
/**
 断开连接后回调，分手动断开和非手动断开
 device lost or user operation
 */
- (void)onDisconnected:(VVToolUseClass *)device isForce:(BOOL)isForce;
/**
 设备连接成功回调
 device connect success
 */
- (void)onConnected:(VVToolUseClass *)device;
/**
 设备连接失败回调
 connect falied
 @param code 错误码
 @param msg  详情
 */
- (void)connectOnError:(int)code msg:(NSString *)msg;

/**
 开始连接BLE回调
 start connect
 */
- (void)connectOnStart;

/**
 get Characteristics Service
 */
- (void)onServiceReady;

@end
//监听扫描回调
@protocol BluetoothScanListenerDelegate <NSObject>

@optional
/**
 Scanning is beginning
 */
- (void)onScanStart;
/**
 Returns information scanned to the device
 @param device Equipment Information Object
 */
- (void)onDeviceFound:(VVToolUseClass *)device;
/**
 Scanning is over
 */
- (void)onScanStop;
/**
 Error scanning
 */
- (void)onScanError:(int)code :(NSString *)msg;

@end
//监听蓝牙状态
@protocol BluetoothStateListenerDelegate <NSObject>

@optional
/**
 Bluetooth is on
 */
- (void)onBluetoothOpen;
/**
 Bluetooth is off
 */
- (void)onBluetoothClose;
/**
 Bluetooth status switching
 */
- (void)onBluetoothSwitchToOnStatus;

@end

@interface VVBleManager : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>

/**
 自动重连是否激活，YES为是，NO为否，默认为NO
 enable BLE reconnect , YES = enable, NO = disable
 */
@property(nonatomic,assign)BOOL bleReconnectEnabled;

/**
 BLE connect status
 */
@property(nonatomic,assign)BOOL isConnected;

@property(nonatomic,assign)id<vlBLEDelegates>delegate;
@property(nonatomic,assign)id<BluetoothConnectListenerDelegate>connectDelegate;
@property(nonatomic,assign)id<BluetoothScanListenerDelegate>scanDelegate;
@property(nonatomic,assign)id<BluetoothStateListenerDelegate>bleStateDelegate;

/**
 * get Vivalnk(sdk) instance object
 */
+ (instancetype)shareInstance;

/**
 开始扫描BLE设备
 start scan BLE device
*/
- (void)startScan:(VVToolUseClass *)options withDeviceType:(ScanDeviceType)deviceType;
/**
 停止扫描BLE设备
 stop scan BLE device
*/
- (void)stopScan;

/**
 开始连接BLE设备
 start connect with BLE device
 @param options peripheral name
 */
- (void)connect:(VVToolUseClass *)options;

/**
 断开与BLE设备的连接，并且停止扫描
 dissconnect with BLE device,stop scan too
*/
- (void)disconnect;
/**
 发送Cardiac产品命令的入口
 send CardiacScout command
 if you used patch is CardiacScout,use this function
 */
- (void)sendCardiacCommand:(CardiacCommand *)request;

/**
 发送Vital产品命令的入口
 send VitalScout command
 if you used patch is VitalScout,use this function
 */
- (void)sendVitalCommand:(VitalCommand *)request;

/**
 断开连接后，需要清空BLE数组
 Pruge peripheral array
*/
- (void)prugeArray;

/**
 中心设备的状态
 check status
 */
- (int)checkBle;

/**
 获取SDK版本
 get SDK Version
 */
- (NSString *)getVersion;

/**
 * show sdk running log
 * param show:BOOL value, YES to print log; NO not to print log. Default is NO.
 */
- (void)printLog:(BOOL)show;

/**
 连接vital的设备可以调用这个方法一次性完成数据采集及上传命令
 The device connected to vital can call this method to complete data acquisition and upload commands at one time.
 */
- (void)enableAutoDataSampling;

/**
 when no data return,You can call this method
 */
- (BOOL)callbackACKCommand;

/*
 设置产生afib所需要的buffer长度和达到的的生成条件
 */
- (void)setAfibBuffer:(NSInteger )bufferCount andExpect:(NSInteger )expectValue;


@end
