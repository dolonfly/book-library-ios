//
//  DLLSearchResultTableViewController.m
//  book-library-ios
//
//  Created by dll on 15/11/15.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLSearchResultTableViewController.h"
#import "DLLSearchResultTableViewCell.h"
#import "DLLBookDetailViewController.h"
#import "TTHttpTool.h"
#import "DLLBook.h"
#import <MJExtension.h>

@interface DLLSearchResultTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *books;
@property (nonatomic,weak) UISearchBar *searchBar;



@end

@implementation DLLSearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    UIBarButtonItem *rightCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(didClickRightButton)];
    self.navigationItem.rightBarButtonItem = rightCancel;
    [self initSearchController];

    
    [self.tableView registerClass:[DLLSearchResultTableViewCell class] forCellReuseIdentifier:@"searchResultCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)books
{
    if (!_books) {
        _books = [NSArray array];
    }
    return _books;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLLSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    cell.dllBook = self.books[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLLBook *book = self.books[indexPath.item];
    DLLBookDetailViewController *detailVc = [[DLLBookDetailViewController alloc] init];
    detailVc.book = book;
    [self.navigationController pushViewController:detailVc animated:YES];

}

- (void)setFilterString:(NSString *)filterString
{
    if (filterString!=NULL&&[filterString length]>0) {
        [self loadNewData:filterString];
    }

}

- (void)loadNewData:(NSString *)keyword
{

    NSString *url = [@"http://bl.itfengzi.com/api/v1/book/find?title=" stringByAppendingString:keyword];
     url =  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8));
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            NSArray *datas = responseData[@"data"];
            NSArray *books = [DLLBook objectArrayWithKeyValuesArray:datas];
            _books = books;
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"http request err :%@",error);
    }];
    
}

- (void)initSearchController {
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.searchBar = searchBar;
    searchBar.placeholder = @"";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [searchBar becomeFirstResponder];
    
}

-(void)didClickRightButton
{
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - searbar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self setFilterString:searchBar.text];
}

@end
