//
//  DefineType.h
//  FeverBleManager
//
//  Created by vivalnk on 2017/7/3.
//  Copyright © 2017年 Zhu, Yi. All rights reserved.
//

#ifndef DefineType_h
#define DefineType_h

typedef NS_ENUM(NSInteger,ABNORMAL_TEMPERATURE_STATUS) {
    STATUS_NORMAL,
    ABNORMAL_LOW_TEMPERATURE_UNDER_90F_FIVE_MINUTE,
    ABNORMAL_LOW_TEMPERATURE_UNDER_94F_THIRTY_MINUTE,
    ABNORMAL_LOW_TEMPERATURE //Normal low temperature status, notify when temperature lower than 34.5 only after temperature higher than 35.5 before
  
};
typedef NS_ENUM(NSInteger,TEMPERATURE_STATUS) {
    TEMPERATURE_UNKNOWN_STATUS,
    TEMPERATURE_UNSTABLE_STATUS,
    TEMPERATURE_STABLE_STATUS
};


typedef NS_ENUM(NSInteger,CHARGER_BATTERY_STATUS) {
    LOW,
    NORMAL
};

#endif /* DefineType_h */
