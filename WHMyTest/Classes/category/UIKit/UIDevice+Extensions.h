//
//  UIDevice+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extensions)

+ (NSString *)wh_platform;
/**
 *  手机型号
 */
- (NSString*)wh_GetDeviceModel;
/**
 *  CPU 主频
 */
+ (NSUInteger)wh_cpuFrequency;
/**
 *  设备总线频率
 *
 *  @return <#return value description#>
 */
+ (NSUInteger)wh_busFrequency;
/**
 *  设备内存大小
 */
+ (NSUInteger)wh_ramSize;
/**
 *  设备CPU数量
 */
+ (NSUInteger)wh_cpuNumber;

/**
 *  获取iOS系统的版本号
 */
+ (NSString *)wh_systemVersion;
/**
 *  判断当前系统是否有摄像头
 */
+ (BOOL)wh_hasCamera;
/**
 *  获取手机内存总量, 返回的是字节数
 */
+ (NSUInteger)wh_totalMemoryBytes;
/**
 *  获取手机可用内存, 返回的是字节数
 */
+ (NSUInteger)wh_freeMemoryBytes;
/**
 *  获取手机硬盘空闲空间, 返回的是字节数
 */
+ (long long)wh_freeDiskSpaceBytes;
/**
 *  获取手机硬盘总空间, 返回的是字节数
 */
+ (long long)wh_totalDiskSpaceBytes;
/**
 *  客户端版本号
 */
+ (NSString *)wh_getTheClientVersionNumber;
/**
 *  获取设备序列号
 */
+ (NSString *)wh_getSerialNo;

/**
 *  获取当前网络类型
 */
+ (NSString *)wh_getNetType;
/**
 *  获取设备型号
 */
+ (NSString *)wh_getDeviceModel;
/**
 *  获取运营商
 */
+ (NSString *)wh_getOperator;
/**
 *  获取设备分辨率
 */
+ (NSString *)wh_getTheResolutionOfThe;
/**
 *  获取idfa
 */
+ (NSString *)wh_getIdfa;
/**
 *  获取ip
 */
+ (NSString *)wh_getIp;
/**
 *  获取MacAddress
 */
+ (NSString *)wh_getMacAddress;

@end
