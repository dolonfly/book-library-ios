//
//  DLLUserCenterViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/20.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLUserCenterViewController.h"
#import <UIScrollView+APParallaxHeader.h>

@interface DLLUserCenterViewController ()
@property (nonatomic, weak)UITableView *tableView;
@end

@implementation DLLUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView  = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"miao.jpg"] andHeight:220];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
