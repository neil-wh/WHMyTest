//
//  UITextView+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extensions)<UITextViewDelegate>

@property (nonatomic, strong) UITextView * wh_placeHolderTextView;

- (void)wh_addPlaceHolder:(NSString *)placeHolder;

@end
