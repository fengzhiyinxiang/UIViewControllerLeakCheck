//
//  AppDelegate.h
//  UIViewControllerLeakCheck
//
//  Created by QF on 2018/10/16.
//  Copyright © 2018年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

