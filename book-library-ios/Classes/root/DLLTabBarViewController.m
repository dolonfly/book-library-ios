//
//  DLLTabBarViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/16.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLTabBarViewController.h"

@interface DLLTabBarViewController ()

@end

@implementation DLLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBar.hidden = NO;
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.tabBar.hidden = YES;
    [super viewDidDisappear:animated];
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
