//
//  NSUserDefaults+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extensions)
+ (NSString *)wh_stringForKey:(NSString *)defaultName;

+ (NSArray *)wh_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)wh_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)wh_dataForKey:(NSString *)defaultName;

+ (NSArray *)wh_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)wh_integerForKey:(NSString *)defaultName;

+ (float)wh_floatForKey:(NSString *)defaultName;

+ (double)wh_doubleForKey:(NSString *)defaultName;

+ (BOOL)wh_boolForKey:(NSString *)defaultName;

+ (NSURL *)wh_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)wh_setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)wh_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)wh_setArcObject:(id)value forKey:(NSString *)defaultName;
@end
