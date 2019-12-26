//
//  NSDictionary+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extensions)


/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)wh_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)wh_dictionaryByMergingWith:(NSDictionary *)dict;


+ (NSDictionary *)wh_removeNullFromDictionary:(NSDictionary *)dic;

#pragma mark - Manipulation
- (NSDictionary *)wh_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)wh_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

- (BOOL)wh_hasKey:(NSString *)key;

- (NSString*)wh_stringForKey:(id)key;

- (NSNumber*)wh_numberForKey:(id)key;

- (NSDecimalNumber *)wh_decimalNumberForKey:(id)key;

- (NSArray*)wh_arrayForKey:(id)key;

- (NSDictionary*)wh_dictionaryForKey:(id)key;

- (NSInteger)wh_integerForKey:(id)key;

- (NSUInteger)wh_unsignedIntegerForKey:(id)key;

- (BOOL)wh_boolForKey:(id)key;

- (int16_t)wh_int16ForKey:(id)key;

- (int32_t)wh_int32ForKey:(id)key;

- (int64_t)wh_int64ForKey:(id)key;

- (char)wh_charForKey:(id)key;

- (short)wh_shortForKey:(id)key;

- (float)wh_floatForKey:(id)key;

- (double)wh_doubleForKey:(id)key;

- (long long)wh_longLongForKey:(id)key;

- (unsigned long long)wh_unsignedLongLongForKey:(id)key;

- (NSDate *)wh_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)wh_CGFloatForKey:(id)key;

- (CGPoint)wh_pointForKey:(id)key;

- (CGSize)wh_sizeForKey:(id)key;

- (CGRect)wh_rectForKey:(id)key;



@end


#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(Extensions)

-(void)wh_setObj:(id)i forKey:(NSString*)key;

-(void)wh_setString:(NSString*)i forKey:(NSString*)key;

-(void)wh_setBool:(BOOL)i forKey:(NSString*)key;

-(void)wh_setInt:(int)i forKey:(NSString*)key;

-(void)wh_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)wh_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)wh_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)wh_setChar:(char)c forKey:(NSString*)key;

-(void)wh_setFloat:(float)i forKey:(NSString*)key;

-(void)wh_setDouble:(double)i forKey:(NSString*)key;

-(void)wh_setLongLong:(long long)i forKey:(NSString*)key;

-(void)wh_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)wh_setSize:(CGSize)o forKey:(NSString*)key;

-(void)wh_setRect:(CGRect)o forKey:(NSString*)key;
@end
