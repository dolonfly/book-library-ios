//
//  DLLPreOrderTableViewController.m
//  book-library-ios
//
//  Created by dll on 15/11/29.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLPreOrderTableViewController.h"
#import <MJRefresh.h>
#import "DLLPreOrderUtil.h"

@interface DLLPreOrderTableViewController ()

@property(nonatomic,strong) NSArray *preOrders;

@end

@implementation DLLPreOrderTableViewController

- (NSArray *)preOrders
{
    if (!_preOrders) {
        _preOrders = [NSArray array];
    }
    return _preOrders;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预购清单";
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.preOrders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    NSDictionary *order = self.preOrders[indexPath.row];
    cell.textLabel.text = order[@"book"][@"isbn"];
    return cell;
    
}

-(void)loadNewData
{
    [DLLPreOrderUtil getPreorderListOnSucess:^(id responseData) {
        NSArray *datas = responseData;
        NSLog(@"%@",datas);
        NSLog(@"%lu",(unsigned long)datas.count);
        self.preOrders = datas;
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];        
    }];
}

@end
