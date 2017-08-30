//
//  UITableView+Statisical.m
//  Parent
//
//  Created by 吴海瑞 on 2017/7/26.
//  Copyright © 2017年 Reschool. All rights reserved.
//

#import "UITableView+Statisical.h"
#import <objc/runtime.h>

@implementation UITableView (Statisical)
+(void)load{
    Method sendAction = class_getInstanceMethod([self class], @selector(touchesEnded:withEvent:));
    Method whr_SendAction = class_getInstanceMethod([self class], @selector(whr_TouchesEnded:withEvent:));
    
    method_exchangeImplementations(sendAction, whr_SendAction);
}

- (void)whr_TouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self whr_TouchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    UIView *v = touch.view.superview;
    if ([NSStringFromClass([v class]) isEqualToString:@"UITableViewCellContentView"]) {
        NSString *str = [NSString stringWithFormat:@"%@_%@",NSStringFromClass([[self viewController] class]),NSStringFromClass([v.superview class])];
        NSLog(@"%@",str);
        
    }
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
