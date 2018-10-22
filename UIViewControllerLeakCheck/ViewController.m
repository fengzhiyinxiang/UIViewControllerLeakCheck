//
//  ViewController.m
//  UIViewControllerLeakCheck
//
//  Created by QF on 2018/10/16.
//  Copyright © 2018年 QF. All rights reserved.
//

#import "ViewController.h"
#import "BadVC.h"
#import "GoodVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    NSArray *buttonTitleArray = @[@"未泄露Push",@"未泄露Present",@"泄露Push",@"泄露Present"];
    for (NSInteger i=0; i<buttonTitleArray.count; i++) {
        UIButton *operationBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [operationBT setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [operationBT setBackgroundColor:[UIColor greenColor]];
        [operationBT addTarget:self action:@selector(operationBTAction:) forControlEvents:UIControlEventTouchUpInside];
        [operationBT setTag:i];
        [self.view addSubview:operationBT];
        [operationBT setFrame:CGRectMake(0,100+88*i, self.view.frame.size.width, 44)];
    }
   
}

- (void)operationBTAction:(id)sender{
    UIButton *operationBT = (UIButton*)sender;
    switch (operationBT.tag) {
        case 0:
        {
            GoodVC *goodVC = [[GoodVC alloc] init];
            [self.navigationController pushViewController:goodVC animated:YES];
        }
            break;
            
        case 1:
        {
            GoodVC *goodVC = [[GoodVC alloc] init];
            [self presentViewController:goodVC animated:YES completion:nil];
        }
            break;
            
        case 2:
        {
            BadVC *badVC = [[BadVC alloc] init];
            [self.navigationController pushViewController:badVC animated:YES];
        }
            break;
            
        default:
        {
            BadVC *badVC = [[BadVC alloc] init];
            [self presentViewController:badVC animated:YES completion:nil];
        }
            break;
    }
}

@end
