//
//  DLLBookDetailViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/4.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookDetailViewController.h"
#import "DLLBookDetailView.h"
#import "TTHttpTool.h"
#import <MJExtension.h>
#import <UIScrollView+APParallaxHeader.h>
#import "DLLBookCoverView.h"
#import "DLLCommonTextView.h"
#import "DLLTextViewController.h"

@interface DLLBookDetailViewController ()

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation DLLBookDetailViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"图书详情"];
    self.navigationController.navigationBarHidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1];

//    self.tableView.allowsSelection = NO;
     self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparent.png"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.extendedLayoutIncludesOpaqueBars = NO;

    //self.tableView.layer.borderColor = [[UIColor colorWithHexString:@"#6a2d00"] CGColor];

    
//    DLLBookDetailView *bookDetailView = [[DLLBookDetailView alloc] initWithFrame:self.view.frame];
//    bookDetailView.frame = self.view.bounds;
//    [self.view addSubview:bookDetailView];
//    self.bookDetailView = bookDetailView;
    
    [self.tableView registerClass:[DLLBookCoverView class] forCellReuseIdentifier:@"bookCover"];
   
////
//    DLLBookCoverView *bookCover = [[DLLBookCoverView alloc] initWithFrame:self.view.frame];
//    self.bookCover = bookCover;
//    [self.tableView addParallaxWithView:bookCover andHeight:500];

    // 初始化tableView的数据
    NSArray *list = [NSArray arrayWithObjects:@"1武汉",@"2上海",@"3北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    self.dataList = list;
    
    [self requestBookById:self.book];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestBookById:(DLLBook *)book{
    //请求网络，获取对应图书Id的图书信息，并转换为Book对象
    NSLog(@"bookId:%@",book.isbn);
    
    NSString *baseUrl = @"http://bl.itfengzi.com/api/v1/book?isbn=";
    
    NSString *url = [baseUrl stringByAppendingString:book.isbn];
    NSLog(@"%@", url);
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            DLLBook *book = [DLLBook objectWithKeyValues:responseData[@"data"]];
            self.book = book;
            [self.tableView reloadData];
        }
        

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *CellWithIdentifier = @"bookCover";
        DLLBookCoverView *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        
        cell.book = self.book;
        return cell;
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        static NSString *CellWithIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        }
        cell.textLabel.text = @"图书目录";
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        static NSString *CellWithIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        }
        cell.textLabel.text = @"作者简介";
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 2){
        static NSString *CellWithIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        }
        cell.textLabel.text = @"内容简介";

        return cell;
    }
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    }
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"";
    }else if (section == 1){
        return @"";
    }
    return @"内容简介";
}

#pragma mark didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *desText = [[NSString alloc] init];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            desText = self.book.catalog;
        }else if (indexPath.row == 1){
            desText = self.book.authorIntro;
        }else if (indexPath.row ==2 ){
            desText = self.book.summary;
        }
        [self push2TextView:desText];
    }
    
    
}

#pragma mark - textViewController
- (void)push2TextView:(NSString *)des
{
    DLLTextViewController *textViewController = [[DLLTextViewController alloc] init];
    textViewController.des = des;
    [self.navigationController pushViewController:textViewController animated:YES];
}


@end
