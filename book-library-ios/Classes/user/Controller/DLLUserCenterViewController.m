//
//  DLLUserCenterViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/20.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLUserCenterViewController.h"
#import <UIScrollView+APParallaxHeader.h>
#import "DLLUserInfoView.h"
#import "DLLScanBookViewController.h"
#import <FontAwesomeKit.h>
#import "DLLLoginViewController.h"
#import "DLLUser.h"

typedef void(^SelectedOption)();

@interface DLLUserCenterViewController ()
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, weak)UIView *userInfoView;
@property (nonatomic, strong) NSArray *selectedOptions;

@property (nonatomic,assign) BOOL isLogin;
@end

@implementation DLLUserCenterViewController

- (NSArray *)selectedOptions
{
    if (! _selectedOptions) {
        
        SelectedOption infoOption = ^() {
            NSLog(@"info");
        };
        
        _selectedOptions = @[infoOption];
    }
    return _selectedOptions;
}

- (BOOL)isLogin
{
    _isLogin = [[DLLUser new] isLogin];
    return _isLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的"];
    
    self.navigationItem.rightBarButtonItem =    [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(loginBtnClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor grayColor]];
    
    
    UITableView *tableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //创建userInfo view
    DLLUserInfoView *userInfoView = [[DLLUserInfoView alloc] init];
    userInfoView.frame = CGRectMake(0, 0, self.view.frame.size.width, 220);
    self.userInfoView = userInfoView;
    [tableView addParallaxWithView:userInfoView andHeight:220];
    
    [self freshItem];
    
    
//    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"miao.jpg"] andHeight:220];
    
    // 初始化tableView的数据
    NSArray *list = [NSArray arrayWithObjects:@"添加图书", nil];
    self.dataList = list;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.dataList objectAtIndex:row];
//    cell.imageView.image = [UIImage imageNamed:@"green.png"];
//    cell.detailTextLabel.text = @"详细信息";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [self clickAddBookCell];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self freshItem];
    NSLog(@"isLogin:%d",_isLogin);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - fresh barbuttonitem
-(void)freshItem
{
    if (self.isLogin) {
        self.navigationItem.rightBarButtonItem.title = @"登出";
    }else{
        self.navigationItem.rightBarButtonItem.title = @"登录";
    }
}

#pragma mark - onClick

- (void)clickAddBookCell
{
    DLLScanBookViewController *scanBookController = [[DLLScanBookViewController alloc] init];
    [self.navigationController pushViewController:scanBookController animated:true];
    
}

- (void)loginBtnClick
{
    if (_isLogin) {
        [[DLLUser new] loginout];
        [self freshItem];
    }else{
        DLLLoginViewController *login = [[DLLLoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

@end
