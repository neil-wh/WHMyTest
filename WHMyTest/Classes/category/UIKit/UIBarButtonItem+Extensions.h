//
//  UIBarButtonItem+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BarButtonActionBlock)();

@interface UIBarButtonItem (Extensions)
- (void)wh_setActionBlock:(BarButtonActionBlock)actionBlock;
@end
