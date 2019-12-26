//
//  UIBarButtonItem+Extensions.m
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIBarButtonItem+Extensions.h"
#import <objc/runtime.h>


char * const UIBarButtonItemActionBlock = "UIBarButtonItemActionBlock";
@implementation UIBarButtonItem (Extensions)
- (void)wh_performActionBlock {
    
    dispatch_block_t block = self.wh_actionBlock;
    
    if (block)
        block();
    
}

- (BarButtonActionBlock)wh_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemActionBlock);
}

- (void)wh_setActionBlock:(BarButtonActionBlock)actionBlock
{
    
    if (actionBlock != self.wh_actionBlock) {
        [self willChangeValueForKey:@"wh_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemActionBlock,
                                 actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        [self setTarget:self];
        [self setAction:@selector(wh_performActionBlock)];
        
        [self didChangeValueForKey:@"wh_actionBlock"];
    }
}

@end
