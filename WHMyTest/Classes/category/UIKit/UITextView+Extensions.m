//
//  UITextView+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//
#import <objc/runtime.h>
#import "UITextView+Extensions.h"
static const char * wh_placeHolderTextView = "wh_placeHolderTextView";
@implementation UITextView (Extensions)
- (UITextView *)wh_placeHolderTextView {
    return objc_getAssociatedObject(self, wh_placeHolderTextView);
}
- (void)setWh_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, wh_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)wh_addPlaceHolder:(NSString *)placeHolder {
    if (![self wh_placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setWh_placeHolderTextView:textView];
    }
}
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.wh_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.wh_placeHolderTextView.hidden = NO;
    }
}




@end
