//
//  UIViewController+Statistical.m
//  Parent
//
//  Created by 吴海瑞 on 2017/7/24.
//  Copyright © 2017年 Reschool. All rights reserved.
//

#import "UIViewController+Statistical.h"
#import <objc/runtime.h>

@implementation UIViewController (Statistical)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(logViewWillAppear:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        SEL originalSelectorDis = @selector(viewWillDisappear:);
        SEL swizzledSelectorDis = @selector(logviewWillDisappear:);
        Method originalMethodDis = class_getInstanceMethod(class, originalSelectorDis);
        Method swizzledMethodDis = class_getInstanceMethod(class, swizzledSelectorDis);
        
        BOOL successDis = class_addMethod(class, originalSelectorDis, method_getImplementation(swizzledMethodDis), method_getTypeEncoding(swizzledMethodDis));
        if (successDis) {
            class_replaceMethod(class, swizzledSelectorDis, method_getImplementation(originalMethodDis), method_getTypeEncoding(originalMethodDis));
        } else {
            method_exchangeImplementations(originalMethodDis, swizzledMethodDis);
        }
    });
}

-(void)logViewWillAppear:(BOOL)animated
{
    [self logViewWillAppear:animated];
    NSString *selfClass = NSStringFromClass([self class]);
//    
    NSLog(@"进入:%@",selfClass);
}

-(void)logviewWillDisappear:(BOOL)animated
{
    [self logviewWillDisappear:animated];
    NSString *selfClass = NSStringFromClass([self class]);
    NSLog(@"退出:%@",selfClass);
}

@end
