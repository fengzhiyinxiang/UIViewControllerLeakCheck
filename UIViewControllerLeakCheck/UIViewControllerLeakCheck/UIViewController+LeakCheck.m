//
//  UIViewController+LeakCheck.m
//  yimei
//
//  Created by QF on 2017/6/16.
//  Copyright © 2017年 yixin. All rights reserved.
//

#import "UIViewController+LeakCheck.h"
#import <objc/runtime.h>

@implementation UIViewController (Load)

+(void)load{
#ifdef DEBUG
    [self exchangeMethod];
#endif
}

+(NSMutableSet*)shareMutSet
{
    static NSMutableSet* shareMutSet = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        shareMutSet = [[NSMutableSet alloc] init];
    }) ;
    return shareMutSet;
}

+(void)exchangeMethod{
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(viewDidAppear:)),
                                   class_getInstanceMethod([self class], @selector(my_viewDidAppear:)));
    
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(viewDidDisappear:)),
                                   class_getInstanceMethod([self class], @selector(my_viewDidDisappear:)));
    
    method_exchangeImplementations(class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod([self class], @selector(my_dealloc)));
}

- (void)my_viewDidAppear:(BOOL)animated{
    [self my_viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIViewController shareMutSet].count) {
            NSLog(@"\nUIViewControllerLeaked\n%@\n",[UIViewController shareMutSet]);
        }
    });
}

- (void)my_viewDidDisappear:(BOOL)animated{
    [self my_viewDidDisappear:animated];
    
    if (![NSStringFromClass([self class]) hasPrefix:@"UI"]) {
        if (self.presentingViewController) {
            if (self.presentingViewController.presentedViewController) {
                [[UIViewController shareMutSet] addObject:NSStringFromClass([self class])];
            }
        } else {
            if (![self.navigationController.viewControllers containsObject:self]) {
                [[UIViewController shareMutSet] addObject:NSStringFromClass([self class])];
            }
        }
    }
}

-(void)my_dealloc{
    [[UIViewController shareMutSet] removeObject:NSStringFromClass([self class])];
    [self my_dealloc];
}


@end
