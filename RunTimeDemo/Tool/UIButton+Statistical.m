//
//  UIButton+Statistical.m
//  Parent
//
//  Created by 吴海瑞 on 2017/7/24.
//  Copyright © 2017年 Reschool. All rights reserved.
//

#import "UIButton+Statistical.h"
#import <objc/runtime.h>

@implementation UIButton (Statistical)

+ (void)load
{
    Method sendAction = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method whr_SendAction = class_getInstanceMethod([self class], @selector(whr_SendAction:to:forEvent:));
    
    method_exchangeImplementations(sendAction, whr_SendAction);
    
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [super sendAction:action to:target forEvent:event];
}

- (void)whr_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self whr_SendAction:action to:target forEvent:event];
    
    NSString *str = [NSString stringWithFormat:@"%@_%@",NSStringFromClass([[self viewController] class]),NSStringFromSelector (action)];
    NSLog(@"%@",str);
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
