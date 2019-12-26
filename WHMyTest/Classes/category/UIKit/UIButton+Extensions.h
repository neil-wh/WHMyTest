//
//  UIButton+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WHTouchedButtonBlock)(NSInteger tag);

typedef NS_ENUM(NSInteger, WHImagePosition) {
    LXMImagePositionLeft = 0,              //图片在左，文字在右，默认
    LXMImagePositionRight = 1,             //图片在右，文字在左
    LXMImagePositionTop = 2,               //图片在上，文字在下
    LXMImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (Extensions)
/**
*  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
*  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
*
*  @param spacing 图片和文字的间隔
*/
- (void)wh_setImagePosition:(WHImagePosition)postion spacing:(CGFloat)spacing;

/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets wh_touchAreaInsets;

/**
 *  倒计时button
 *
 *  @param timeout    总时间
 *  @param tittle     倒计时结束时显示title
 *  @param waitTittle 倒计时是显示title
 */
-(void)wh_startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
-(void)wh_startTime:(NSInteger )timeout title:(NSString *)tittle waitTitle:(NSString *)waitTitle;
/**
 *  block Buuton
 *
 *  @param touchHandler callback block
 */
-(void)wh_addActionHandler:(WHTouchedButtonBlock)touchHandler;

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)wh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
