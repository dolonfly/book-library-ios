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
@property (nonatomic, weak) DLLBookCoverView *bookCover;

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



    DLLBookCoverView *bookCover = [[DLLBookCoverView alloc] init];
    bookCover.frame = CGRectMake(0, 0, self.view.frame.size.width,200);
    [self.tableView setTableHeaderView:bookCover];
    self.bookCover = bookCover;
    
    // 初始化tableView的数据
    NSArray *list = [NSArray arrayWithObjects:@"图书目录",@"作者简介",@"内容简介",nil];
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
            self.bookCover.book = book;
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


#pragma mark didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *desText = [[NSString alloc] init];
    
    if (indexPath.row == 0) {
        desText = self.book.catalog;
    }else if (indexPath.row == 1){
        desText = self.book.authorIntro;
    }else if (indexPath.row ==2 ){
        desText = self.book.summary;
    }
    [self push2TextView:desText];
   
}

#pragma mark - textViewController
- (void)push2TextView:(NSString *)des
{
    DLLTextViewController *textViewController = [[DLLTextViewController alloc] init];
    textViewController.des = des;
    [self.navigationController pushViewController:textViewController animated:YES];
}


@end
