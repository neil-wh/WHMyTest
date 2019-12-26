//
//  UIControl+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Extensions)
- (void)wh_touchDown:(void (^)(void))eventBlock;
- (void)wh_touchDownRepeat:(void (^)(void))eventBlock;
- (void)wh_touchDragInside:(void (^)(void))eventBlock;
- (void)wh_touchDragOutside:(void (^)(void))eventBlock;
- (void)wh_touchDragEnter:(void (^)(void))eventBlock;
- (void)wh_touchDragExit:(void (^)(void))eventBlock;
- (void)wh_touchUpInside:(void (^)(void))eventBlock;
- (void)wh_touchUpOutside:(void (^)(void))eventBlock;
- (void)wh_touchCancel:(void (^)(void))eventBlock;
- (void)wh_valueChanged:(void (^)(void))eventBlock;
- (void)wh_editingDidBegin:(void (^)(void))eventBlock;
- (void)wh_editingChanged:(void (^)(void))eventBlock;
- (void)wh_editingDidEnd:(void (^)(void))eventBlock;
- (void)wh_editingDidEndOnExit:(void (^)(void))eventBlock;
@end
