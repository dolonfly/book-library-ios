//
//  DLLHomeViewController.m
//  book-library-ios
//
//  Created by dll on 15/9/16.
//  Copyright (c) 2015年 dll. All rights reserved.
//

#import "DLLHomeViewController.h"
#import "BLKFlexibleHeightBar.h"
#import "SquareCashStyleBehaviorDefiner.h"
#import "DLLBookInfoTableViewCell.h"
#import "DLLBookDetailViewController.h"
#import "TTHttpTool.h"
#import <MJExtension.h>
#import <MJRefresh.h>


@interface DLLHomeViewController ()

@property (nonatomic, strong) NSArray *books;

//搜索
@property (nonatomic, strong) UISearchBar       *searchBar;
@property (strong, nonatomic)  UISearchController *searchController;

@end

@implementation DLLHomeViewController

- (NSArray *)books
{
    if (!_books) {
        _books = [NSArray array];
    }
    return _books;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页"];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(selectSearchItem:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    [self.tableView registerClass:[DLLBookInfoTableViewCell class] forCellReuseIdentifier:@"bookInfoCell"];
   
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];



}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLLBookInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookInfoCell"];
    cell.dllBook = self.books[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLLBook *book = self.books[indexPath.item];
    DLLBookDetailViewController *detailVc = [[DLLBookDetailViewController alloc] init];
    detailVc.book = book;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133;
}


- (void)loadNewData
{
    [TTHttpTool getWithURL:@"http://121.40.253.109:3002/api/v1/book/news" parameters:NULL success:^(id responseData) {
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            NSArray *datas = responseData[@"data"];
            NSArray *books = [DLLBook objectArrayWithKeyValuesArray:datas];
            _books = books;
        }
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark search
- (void)selectSearchItem:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    UIButton *leftItemView = (UIButton *)self.parentViewController.navigationItem.leftBarButtonItem.customView;
    [leftItemView removeFromSuperview];
    
}

@end