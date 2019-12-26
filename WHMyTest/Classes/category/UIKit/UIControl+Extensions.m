//
//  UIControl+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIControl+Extensions.h"
#import <objc/runtime.h>

#define WH_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(void))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)() = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block();                                                                \
}                                                                           \
}
@implementation UIControl (Extensions)
WH_UICONTROL_EVENT(wh_touchDown, TouchDown)
WH_UICONTROL_EVENT(wh_touchDownRepeat, TouchDownRepeat)
WH_UICONTROL_EVENT(wh_touchDragInside, TouchDragInside)
WH_UICONTROL_EVENT(wh_touchDragOutside, TouchDragOutside)
WH_UICONTROL_EVENT(wh_touchDragEnter, TouchDragEnter)
WH_UICONTROL_EVENT(wh_touchDragExit, TouchDragExit)
WH_UICONTROL_EVENT(wh_touchUpInside, TouchUpInside)
WH_UICONTROL_EVENT(wh_touchUpOutside, TouchUpOutside)
WH_UICONTROL_EVENT(wh_touchCancel, TouchCancel)
WH_UICONTROL_EVENT(wh_valueChanged, ValueChanged)
WH_UICONTROL_EVENT(wh_editingDidBegin, EditingDidBegin)
WH_UICONTROL_EVENT(wh_editingChanged, EditingChanged)
WH_UICONTROL_EVENT(wh_editingDidEnd, EditingDidEnd)
WH_UICONTROL_EVENT(wh_editingDidEndOnExit, EditingDidEndOnExit)
@end
