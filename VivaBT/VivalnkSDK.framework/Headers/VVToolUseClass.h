//
//  VVToolUseClass.h
//  VitalSDK
//
//  Created by kevin on 2018/5/29.
//  Copyright © 2018年 com.vivalnk.iOS.cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDIType.h"
#import "VitalType.h"

typedef NS_ENUM(NSInteger, AfibEventType) {
    unkonw_event,
    afib_event,
    activity_event,
    unclassfield_event,
    normal_event,
    pause_event
};
typedef NS_ENUM(NSInteger, EventDataType) {
    realtime,
    flash
};
@interface VVToolUseClass : NSObject
//设备
@property (nonatomic,assign) int rssi;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *deviceId;

//扫描超时时间
@property (nonatomic,assign)NSInteger scanTimeout;

//连接
@property (nonatomic,assign)NSInteger connectRetry;
@property (nonatomic,assign)NSInteger connectTimeout;

@end

@interface CardiacCommand : NSObject
//Cardiac Scout patch use
@property(nonatomic,assign)NSInteger timeOut;
@property(nonatomic,assign)Cardiac_CommandType cardiacType;
@property(nonatomic,copy)NSString *info;
@end

@interface VitalCommand : NSObject
//Vital Scout patch use
@property(nonatomic,assign)NSInteger timeOut;
@property(nonatomic,assign)Vital_CommandType vitalType;
@property(nonatomic,copy)NSString *info;
@end

@interface AfibClass : NSObject

@property(nonatomic,assign)NSTimeInterval startTime;
@property(nonatomic,assign)NSTimeInterval endTime;
@property(nonatomic,assign)AfibEventType event;
@property(nonatomic,assign)NSInteger avgHeartRate;
@property(nonatomic,strong)NSArray *dataBuffer;
@property(nonatomic,assign)EventDataType dataType;
@end

