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

@interface DLLBookDetailViewController ()

- (void)requestBookById:(NSString *)bookId;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, weak) DLLBookDetailView *bookDetailView;
@property (nonatomic, weak) DLLBookCoverView *bookCover;
@end

@implementation DLLBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestBookById:self.bookId];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    DLLBookDetailView *bookDetailView = [[DLLBookDetailView alloc] initWithFrame:self.view.frame];
//    bookDetailView.frame = self.view.bounds;
//    [self.view addSubview:bookDetailView];
//    self.bookDetailView = bookDetailView;
    
    DLLBookCoverView *bookCover = [[DLLBookCoverView alloc] initWithFrame:self.view.frame];
    self.bookCover = bookCover;
    [self.tableView addParallaxWithView:bookCover andHeight:500];

    // 初始化tableView的数据
    NSArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    self.dataList = list;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestBookById:(NSString *)bookId{
    //请求网络，获取对应图书Id的图书信息，并转换为Book对象
    NSLog(@"bookId:%@",bookId);
    
    NSString *baseUrl = @"http://121.40.253.109:3002/api/v1/book/get?id=";
    
    NSString *url = [baseUrl stringByAppendingString:bookId];
    NSLog(@"%@", url);
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            DLLBook *book = [DLLBook objectWithKeyValues:responseData[@"data"]];
            NSLog(@"bookImage:%@",book.ID);
             self.bookDetailView.dllBook = book;
            
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
    return 30;
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
    cell.imageView.image = [UIImage imageNamed:@"green.png"];
    cell.detailTextLabel.text = @"详细信息";
    return cell;
}

@end
