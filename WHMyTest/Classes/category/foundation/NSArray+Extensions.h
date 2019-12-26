//
//  NSArray+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extensions)

-(id)wh_objectWithIndex:(NSUInteger)index;

- (NSString*)wh_stringWithIndex:(NSUInteger)index;

- (NSNumber*)wh_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)wh_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)wh_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)wh_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)wh_integerWithIndex:(NSUInteger)index;

- (NSUInteger)wh_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)wh_boolWithIndex:(NSUInteger)index;

- (int16_t)wh_int16WithIndex:(NSUInteger)index;

- (int32_t)wh_int32WithIndex:(NSUInteger)index;

- (int64_t)wh_int64WithIndex:(NSUInteger)index;

- (char)wh_charWithIndex:(NSUInteger)index;

- (short)wh_shortWithIndex:(NSUInteger)index;

- (float)wh_floatWithIndex:(NSUInteger)index;

- (double)wh_doubleWithIndex:(NSUInteger)index;

- (NSDate *)wh_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

- (CGFloat)wh_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)wh_pointWithIndex:(NSUInteger)index;

- (CGSize)wh_sizeWithIndex:(NSUInteger)index;

- (CGRect)wh_rectWithIndex:(NSUInteger)index;

+ (NSMutableArray *)wh_removeNullFromArray:(NSArray *)arr;

@end



#pragma --mark NSMutableArray setter

@interface NSMutableArray(Extensions)

-(void)wh_addObj:(id)i;

-(void)wh_addString:(NSString*)i;

-(void)wh_addBool:(BOOL)i;

-(void)wh_addInt:(int)i;

-(void)wh_addInteger:(NSInteger)i;

-(void)wh_addUnsignedInteger:(NSUInteger)i;

-(void)wh_addCGFloat:(CGFloat)f;

-(void)wh_addChar:(char)c;

-(void)wh_addFloat:(float)i;

-(void)wh_addPoint:(CGPoint)o;

-(void)wh_addSize:(CGSize)o;

-(void)wh_addRect:(CGRect)o;
@end
