//
//  UIScreen+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIScreen+Extensions.h"

@implementation UIScreen (Extensions)
+ (CGSize)wh_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)wh_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)wh_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}




+ (CGSize)wh_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}



@end
