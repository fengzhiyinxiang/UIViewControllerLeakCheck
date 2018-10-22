//
//  BadVC.m
//  UIViewControllerLeakCheck
//
//  Created by QF on 2018/10/16.
//  Copyright © 2018年 QF. All rights reserved.
//

#import "BadVC.h"

typedef void(^TestBlock)(BOOL success);

@interface BadVC ()

@property (nonatomic,copy) TestBlock testBlock;

@end

@implementation BadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BadVC";
    
    self.testBlock = ^(BOOL success) {
        self.title = @"leak";
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
