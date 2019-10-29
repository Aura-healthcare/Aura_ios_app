//
//  FeverBleManager.h
//  FeverBleManager
//
//  Copyright (c) 2016 VivaLnk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineType.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#define INTERNAL_API        1
#define EXTERNAL_API        0

#if INTERNAL_API
#define VLBLE_VERSION       @"1.3.7"
#endif  // INTERNAL_API
#pragma clang diagnostic ignored "-Wmissing-selector-name"


@class FeverBleManager;

@protocol FerverBLEDelegates <NSObject>

@required
#if INTERNAL_API
-(void)newDeviceDiscovered:(FeverBleManager *)fbManager :(NSString *)deviceId :(NSInteger)rssi :(NSInteger)firmwareVersion;

-(void)temperatureUpdate:(FeverBleManager *)fbManager :(NSString *)deviceId  :(float)rawTemperature :(float)finalTemperature :(int)batteryPercent :(NSInteger)rssi :(NSInteger)tempStatus;
#endif  // INTERNAL_API

- (void)onChargerInfoUpdate:(NSString *)deviceId chargerFw:(NSString *)chargerFw status:(CHARGER_BATTERY_STATUS)chargerStatus offset:(float )offset;

@optional
-(void)deviceLost:(FeverBleManager *)fbManager :(NSString *)deviceId;
-(void)temperatureMissed:(FeverBleManager *)fbManager :(NSString *)deviceId;
/**
 * The SDK triggers below function every time user turn off the phone's bluetooth
 */
-(void)phoneBluetoothOff;

/**
 * The SDK triggers below function every time user turn off the phone's location(GPS)
 */
-(void)phoneLocationOff;

-(void)onTemperatureAbnormalStatusUpdate :(NSString *)deviceId :(ABNORMAL_TEMPERATURE_STATUS)status;

-(void)onTemperatureStatusStable;
-(void)onTemperatureStatusNotStable;
@end
@interface FeverBleManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, assign) id <FerverBLEDelegates> delegate;


-(int)PDListAdd:(NSString *)deviceId;
-(int)PDListRemove:(NSString *)deviceId;
-(void)PDListPurge;
-(NSUInteger)PDListLength;
-(NSEnumerator *)PDListEnumerator;

-(int)startDeviceDiscovery;
-(int)stopDeviceDiscovery;

-(NSInteger)getPairingRSSI;
-(int)setPairingRSSI:(NSInteger)RSSI;

-(NSInteger)getLostThreshold;
-(void)setLostThreshold:(NSInteger)count;

-(int)startTemperatureUpdate;
-(int)stopTemperatureUpdate;

-(void)switchToBackground;
-(void)switchToForeground;

-(NSString *)getVersion;

-(void)finishAll;

-(BOOL)setCompensationTemperature :(NSString *)deviceId :(float)compTemp;

- (void)testDemo;
@end
