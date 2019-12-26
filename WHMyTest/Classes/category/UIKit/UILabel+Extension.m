//
//  UILabel+Extension.m
//  NewCaiShen
//
//  Created by liyuchen on 2019/9/4.
//  Copyright © 2019 王华. All rights reserved.
//

#import "UILabel+Extension.h"


static const char * seperateNumberKey = "seperateNumberKey";



@implementation UILabel (Extension)

- (id )seperateNumber {
    
    return objc_getAssociatedObject(self, seperateNumberKey);
}
- (void)setSeperateNumber:(id)seperateNumber {

    NSString *seprateText = [[NSString alloc] countNumAndChangeformat:seperateNumber];
    self.text = seprateText;
    objc_setAssociatedObject(self, seperateNumberKey, seprateText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
