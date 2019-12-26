//
//  UIImage+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)
/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)wh_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)wh_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)wh_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

/**
 *  调整图片size到一半
 */
+ (UIImage*)wh_resizableHalfImage:(NSString *)name;


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage*)imageWithColor:(UIColor*)color;
@end
