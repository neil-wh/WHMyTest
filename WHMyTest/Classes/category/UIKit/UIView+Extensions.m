//
//  UIView+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIView+Extensions.h"
#import <objc/runtime.h>

static char wh_kActionHandlerTapBlockKey;
static char wh_kActionHandlerTapGestureKey;
static char wh_kActionHandlerLongPressBlockKey;
static char wh_kActionHandlerLongPressGestureKey;


@implementation UIView (Extensions)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)setBottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
-(CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)right {
    
     return self.frame.origin.x + self.frame.size.width;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


/*
 * 当前这个View是否和keyWindow有重叠
 */
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)wh_addTapActionWithBlock:(WHGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &wh_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wh_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &wh_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &wh_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)wh_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        WHGestureActionBlock block = objc_getAssociatedObject(self, &wh_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)wh_addLongPressActionWithBlock:(WHGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &wh_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wh_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &wh_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &wh_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)wh_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        WHGestureActionBlock block = objc_getAssociatedObject(self, &wh_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)wh_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}
/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    一个view
 *  @param limitWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)wh_screenshot:(CGFloat)maxWidth{
    CGAffineTransform oldTransform = self.transform;
    CGAffineTransform scaleTransform = CGAffineTransformIdentity;
    
    //    if (!isnan(scale)) {
    //        CGAffineTransform transformScale = CGAffineTransformMakeScale(scale, scale);
    //        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
    //    }
    if (!isnan(maxWidth) && maxWidth>0) {
        CGFloat maxScale = maxWidth/CGRectGetWidth(self.frame);
        CGAffineTransform transformScale = CGAffineTransformMakeScale(maxScale, maxScale);
        scaleTransform = CGAffineTransformConcat(oldTransform, transformScale);
        
    }
    if(!CGAffineTransformEqualToTransform(scaleTransform, CGAffineTransformIdentity)){
        self.transform = scaleTransform;
    }
    
    CGRect actureFrame = self.frame; //已经变换过后的frame
    CGRect actureBounds= self.bounds;//CGRectApplyAffineTransform();
    
    //begin
    UIGraphicsBeginImageContextWithOptions(actureFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, -1);
    CGContextTranslateCTM(context,actureFrame.size.width/2, actureFrame.size.height/2);
    CGContextConcatCTM(context, self.transform);
    CGPoint anchorPoint = self.layer.anchorPoint;
    CGContextTranslateCTM(context,
                          -actureBounds.size.width * anchorPoint.x,
                          -actureBounds.size.height * anchorPoint.y);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //end
    self.transform = oldTransform;
    
    return screenshot;
}

- (void)shakeWithShakeDirection:(QHLDirection)shakeDirection {
    [self shakeWithTimes:10 speed:0.05 range:5 shakeDirection:shakeDirection];
}

- (void)shakeWithTimes:(NSInteger)times shakeDirection:(QHLDirection)shakeDirection {
   [self shakeWithTimes:times speed:0.05 range:5 shakeDirection:shakeDirection];
}

- (void)shakeWithTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(QHLDirection)shakeDirection {
    [self shakeWithTimes:times speed:speed range:5 shakeDirection:shakeDirection];
 }

- (void)shakeWithTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(QHLDirection)shakeDirection {
    [self viewShakesWithTiems:times speed:speed range:range shakeDirection:shakeDirection currentTimes:0 direction:1];
 }
 /**
    35  *  @param times          震动的次数
    36  *  @param speed          震动的速度
    37  *  @param range          震动的幅度
    38  *  @param shakeDirection 哪个方向上的震动
    39  *  @param currentTimes   当前的震动次数
    40  *  @param direction      向哪边震动
    41  */
- (void)viewShakesWithTiems:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(QHLDirection)shakeDirection currentTimes:(NSInteger)currentTimes direction:(int)direction{

    if (times == 0) {
        [UIView animateWithDuration:speed animations:^{
            self.transform = (shakeDirection == QHLDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
        } completion:^(BOOL finished) {
            [self viewShakesWithTiems:times
                                speed:speed
                                range:range
                       shakeDirection:shakeDirection
                         currentTimes:currentTimes + 1
                            direction:direction * -1];
        }];
    }else{
        [UIView animateWithDuration:speed animations:^{
            self.transform = (shakeDirection == QHLDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
        } completion:^(BOOL finished) {
            if (currentTimes >= times) {
                [UIView animateWithDuration:speed animations:^{
                    self.transform = CGAffineTransformIdentity;
                }];
                return;
            }
#pragma mark - 循环到times == currentTimes时候 会跳出该方法
            [self viewShakesWithTiems:times - 1
                                speed:speed
                                range:range
                       shakeDirection:shakeDirection
                         currentTimes:currentTimes + 1
                            direction:direction * -1];
        }];
    }
 }


@end
