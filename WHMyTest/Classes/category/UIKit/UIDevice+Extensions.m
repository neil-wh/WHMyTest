//
//  UIDevice+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIDevice+Extensions.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AdSupport/AdSupport.h>
#import <AdSupport/AdSupport.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>
#import "WHKeychain.h"




#define ServiceName @"cn.com.csyy"
#define Account @"csyy.serial"


@implementation UIDevice (Extensions)

static NSString *systemBootTime(){
    struct timeval boottime;
    size_t len = sizeof(boottime);
    int mib[2] = { CTL_KERN, KERN_BOOTTIME };
    
    if( sysctl(mib, 2, &boottime, &len, NULL, 0) < 0 )
    {
        return @"";
    }
    time_t bsec = boottime.tv_sec / 10000;
    
    NSString *bootTime = [NSString stringWithFormat:@"%ld",bsec];
    
    return bootTime;
}

static NSString *countryCode() {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    return countryCode;
}

static NSString *language() {
    NSString *language;
    NSLocale *locale = [NSLocale currentLocale];
    if ([[NSLocale preferredLanguages] count] > 0) {
        language = [[NSLocale preferredLanguages]objectAtIndex:0];
    } else {
        language = [locale objectForKey:NSLocaleLanguageCode];
    }
    
    return language;
}

static NSString *systemVersion() {
    return [[UIDevice currentDevice] systemVersion];
}

static NSString *deviceName(){
    return [[UIDevice currentDevice] name];
}
static NSUInteger getSysInfo(uint typeSpecifier) {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

static NSString *carrierInfo() {
    NSMutableString* cInfo = [NSMutableString string];
    
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    NSString *carrierName = [carrier carrierName];
    if (carrierName != nil){
        [cInfo appendString:carrierName];
    }
    
    NSString *mcc = [carrier mobileCountryCode];
    if (mcc != nil){
        [cInfo appendString:mcc];
    }
    
    NSString *mnc = [carrier mobileNetworkCode];
    if (mnc != nil){
        [cInfo appendString:mnc];
    }
    
    return cInfo;
}
static const char *SIDFAModel =       "hw.model";
static const char *SIDFAMachine =     "hw.machine";
static NSString *getSystemHardwareByName(const char *typeSpecifier) {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithUTF8String:answer];
    free(answer);
    return results;
}
static NSString *systemHardwareInfo(){
    NSString *model = getSystemHardwareByName(SIDFAModel);
    NSString *machine = getSystemHardwareByName(SIDFAMachine);
    NSString *carInfo = carrierInfo();
    NSUInteger totalMemory = getSysInfo(HW_PHYSMEM);
    
    return [NSString stringWithFormat:@"%@,%@,%@,%td",model,machine,carInfo,totalMemory];
}



static NSString *systemFileTime(){
    NSFileManager *file = [NSFileManager defaultManager];
    NSDictionary *dic= [file attributesOfItemAtPath:@"System/Library/CoreServices" error:nil];
    return [NSString stringWithFormat:@"%@,%@",[dic objectForKey:NSFileCreationDate],[dic objectForKey:NSFileModificationDate]];
}

static NSString *disk(){
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSString *diskSize = [[fattributes objectForKey:NSFileSystemSize] stringValue];
    return diskSize;
}

static void MD5_16(NSString *source, unsigned char *ret){
    const char* str = [source UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    for(int i = 4; i < CC_MD5_DIGEST_LENGTH - 4; i++) {
        ret[i-4] = result[i];
    }
}

static NSString *combineTwoFingerPrint(unsigned char *fp1,unsigned char *fp2){
    NSMutableString *hash = [NSMutableString stringWithCapacity:36];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i+=1)
    {
        if (i==4 || i== 6 || i==8 || i==10)
            [hash appendString:@"-"];
        
        if (i < 8) {
            [hash appendFormat:@"%02X",fp1[i]];
        }else{
            [hash appendFormat:@"%02X",fp2[i-8]];
        }
    }
    
    return hash;
}




+ (NSString *)wh_platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString*)wh_getDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone_4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone_4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone_4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone_5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone_5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone_5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone_5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone_5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone_5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone_6_Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone_6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone_6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone_6s_Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone_7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone_7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone_7_Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone_7_Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone_8";
    if ([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone_8_Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhone_X";
    if ([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone_X";
    if([deviceString isEqualToString:@"iPhone10,8"]) return @"iPhone_XR";
    if([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone_XS";
    if([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone_XS_Max";
    if([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone_XS_Max";
    
    return deviceString;
}


+ (NSString *)wh_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)wh_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (NSString *)wh_getTheClientVersionNumber
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"%@", appCurVersion];
    return str;
}

#pragma mark - sysctl utils

+ (NSUInteger)wh_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)wh_cpuFrequency {
    return [self wh_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)wh_busFrequency {
    return [self wh_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)wh_ramSize {
    return [self wh_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)wh_cpuNumber {
    return [self wh_getSysInfo:HW_NCPU];
}


+ (NSUInteger)wh_totalMemoryBytes
{
    return [self wh_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)wh_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)wh_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)wh_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}


+ (NSString *)wh_getSerialNo {
    NSString *s = [self wh_getSaveSerialNo];
    if (s) return s;
    s = [self wh_saveSerialNo];
    return s;
}

+ (NSString *)wh_saveSerialNo {
    // 产生一个序列号
    NSString *uuid = [[NSUUID UUID] UUIDString];
    [WHKeychain setPassword:uuid forService:ServiceName account:Account];
    return uuid;
}

+ (NSString *)wh_getSaveSerialNo {
    NSString *s = [WHKeychain passwordForService:ServiceName account:Account];
    return s;
}
+ (NSString *)wh_getNetType {
      // 状态栏是由当前app控制的，首先获取当前app
        NSString *stateString = @"wifi";

        if (@available(iOS 13.0, *)) {
            id statusBar = nil;
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
                    if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
                        UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
                        if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                            statusBar = [localStatusBar performSelector:@selector(statusBar)];
                        }
                    }
            if (statusBar) {
                        // _UIStatusBarDataCellularEntry
                        id currentData = [[statusBar valueForKeyPath:@"_statusBar"] valueForKeyPath:@"currentData"];
                        id wifiEntry = [currentData valueForKeyPath:@"wifiEntry"];
                        id cellularEntry = [currentData valueForKeyPath:@"cellularEntry"];
                        if (wifiEntry && [[wifiEntry valueForKeyPath:@"isEnabled"] boolValue]) {
                            // If wifiEntry is enabled, is WiFi.
                            stateString = @"wifi";
                        } else if (cellularEntry && [[cellularEntry valueForKeyPath:@"isEnabled"] boolValue]) {
                            NSNumber *type = [cellularEntry valueForKeyPath:@"type"];
                            if (type) {
                                switch (type.integerValue) {
                                    case 5:
                                        stateString = @"4G";
                                        break;
                                    case 4:
                                        stateString = @"3G";
                                        break;
                                    case 3:
                                        stateString = @"2G";
                                    break;
                                    case 1:
                                        stateString = @"1G";
                                        break;
                                        
                                    case 0:
                                        // Return 0 when no sim card.
                                        stateString = @"notReachable";
                                    default:
                                        stateString = @"未知";
                                        break;
                                }
                            }
                        }
                    }
           
        }else{
            UIApplication *app = [UIApplication sharedApplication];
            id statusBar = [app valueForKeyPath:@"statusBar"];
    //        NSString *stateString = @"wifi";
            if (IPHONE_X) {
                id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
                UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
                
                NSArray *subviews = [[foregroundView subviews][2] subviews];
                
                for (id subview in subviews) {
                    if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                        stateString = @"WIFI";
                    }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                        stateString = [subview valueForKeyPath:@"originalText"];
                    }
                }
            }else{
                NSArray *children = [[statusBar valueForKeyPath:@"foregroundView"] subviews];
                int type = 0;
                for (id child in children) {
                    if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                        type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
                    }
                }
                
                switch (type) {
                    case 0:
                        stateString = @"notReachable";
                        break;
                    case 1:
                        stateString = @"2G";
                        break;
                    case 2:
                        stateString = @"3G";
                        break;
                    case 3:
                        stateString = @"4G";
                        break;
                    case 4:
                        stateString = @"LTE";
                        break;
                    case 5:
                        stateString = @"wifi";
                        break;
                    default:
                        stateString = @"未知";
                        break;
                }
            }
            return stateString;
        }
     return stateString;
    
}
+ (NSString *)wh_getTheResolutionOfThe
{
    
    NSString  * device = [self wh_getDeviceModel];
    if ([device isEqualToString:@"iPhone_4S"] || [device isEqualToString:@"iPhone_4"]) {
        return @"640×960";
    }else if ([device isEqualToString:@"iPhone_5"]||[device isEqualToString:@"iPhone_5C"]||[device isEqualToString:@"iPhone_5S"]){
        return @"640×1136";
    }else if ([device isEqualToString:@"iPhone_6"]||[device isEqualToString:@"iPhone_6s"]||[device isEqualToString:@"iPhone_7"]||[device isEqualToString:@"iPhone_8"]){
        return @"750×1334";
    }else if ([device isEqualToString:@"iPhone_6_Plus"]||[device isEqualToString:@"iPhone_6s_Plus"]||[device isEqualToString:@"iPhone_7_Plus"]||[device isEqualToString:@"iPhone_8_Plus"]){
        return @"1080×1920";
    }else if ([device isEqualToString:@"iPhone_X"]||[device isEqualToString:@"iPhone_XS"]){
        return @"1125×2436";
    }else if ([device isEqualToString:@"iPhone_XR"]){
        return @"828×1792";
    }else if ([device isEqualToString:@"iPhone_XS_Max"]){
        return @"1242×2688";
    }else{
        return @"1000×1000";
    }
    return nil;
}

/**
 *  获取运营商
 */
+ (NSString *)wh_getOperator {
    CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = info.subscriberCellularProvider;
    if (carrier.carrierName == nil) {
        return @"0";
    }else if ([carrier.carrierName isEqualToString:@"中国移动"]){
        return @"1";
    }else if ([carrier.carrierName isEqualToString:@"中国联通"]){
        return @"2";
    }else if ([carrier.carrierName isEqualToString:@"中国电信"]){
        return @"3";
    }else{
        return @"0";
    }
    
    return carrier.carrierName;
}
+ (NSString *)wh_getMacAddress
{
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray  array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0)
    {
        for (ptr = buffer; ptr < buffer + ifc.ifc_len;)
        {
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len)
            {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count >0)
        {
            deviceIP = [NSString  stringWithFormat:@"%@",ips.lastObject];
        }
    }
    
    return deviceIP;
}


+ (NSString *)wh_getIdfa {
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return [self mzSimulateIDFA];
}

+ (NSString *)wh_getIp {
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict[@"cip"] ? dict[@"cip"] :@"0:0:0:0";
    }
    return @"0:0:0:0";
}

+ (NSString *)mzSimulateIDFA{
    NSString *sysBootTime = systemBootTime();
    NSString *countryC= countryCode();
    NSString *languge = language();
    NSString *deviceN = deviceName();
    
    NSString *sysVer = systemVersion();
    NSString *systemHardware = systemHardwareInfo();
    NSString *systemFT = systemFileTime();
    NSString *diskS = disk();
    
    NSString *fingerPrintUnstablePart = [NSString stringWithFormat:@"%@,%@,%@,%@", sysBootTime, countryC, languge, deviceN];
    NSString *fingerPrintStablePart = [NSString stringWithFormat:@"%@,%@,%@,%@", sysVer, systemHardware, systemFT, diskS];
    
    unsigned char fingerPrintUnstablePartMD5[CC_MD5_DIGEST_LENGTH/2];
    MD5_16(fingerPrintUnstablePart,fingerPrintUnstablePartMD5);
    
    unsigned char fingerPrintStablePartMD5[CC_MD5_DIGEST_LENGTH/2];
    MD5_16(fingerPrintStablePart,fingerPrintStablePartMD5);
    
    NSString *simulateIDFA = combineTwoFingerPrint(fingerPrintStablePartMD5,fingerPrintUnstablePartMD5);
    return simulateIDFA;
}

@end
