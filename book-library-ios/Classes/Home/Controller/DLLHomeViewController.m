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
#import "DLLBookInfoCollectionViewCell.h"
#import "DLLBookDetailViewController.h"
#import "TTHttpTool.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DLLSearchResultTableViewController.h"
#import "DLLBookUtil.h"


@interface DLLHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchControllerDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *books;

//搜索
@property (strong, nonatomic)  UISearchController *searchController;

@property(nonatomic,assign) long cursor;

@end

@implementation DLLHomeViewController

- (NSArray *)books
{
    if (!_books) {
        _books = [NSMutableArray array];
    }
    return _books;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页"];
    
    
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(selectSearchItem:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.minimumLineSpacing = 15;
    CGFloat padding = 20;
    CGFloat width = (self.view.bounds.size.width - padding * 2) / 2 - 10;
    CGFloat height = width / 0.625 ;//为什么是0.625倍？仿照kindle 的尺寸
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, padding, 10, padding);
   
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.frame = self.view.bounds;
    [collectionView registerClass:[DLLBookInfoCollectionViewCell class] forCellWithReuseIdentifier:@"bookInfoCell"];
//    collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    collectionView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];


}


#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.books.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLLBookInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookInfoCell" forIndexPath:indexPath];

    cell.dllBook = self.books[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLLBook *book = self.books[indexPath.item];
    DLLBookDetailViewController *detailVc = [[DLLBookDetailViewController alloc] init];
    detailVc.book = book;
    [self.navigationController pushViewController:detailVc animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)loadNewData
{
    [DLLBookUtil listBooksWithCursor:nil success:^(id responseData) {
        NSArray *books = [DLLBook objectArrayWithKeyValuesArray:responseData[@"data"]];
        self.cursor = [((NSString *)responseData[@"cursor"]) longLongValue];
        if (books.count>0) {
            [self.books addObjectsFromArray:books];
            [self.collectionView.header endRefreshing];
            [self.collectionView reloadData];
        }else{
            [self.collectionView.header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionView.footer endRefreshing];
    }];

}

- (void)loadMoreData
{
    long cursor = self.cursor;
    [DLLBookUtil listBooksWithCursor:[NSString stringWithFormat:@"%ld",cursor] success:^(id responseData) {
        NSArray *books = [DLLBook objectArrayWithKeyValuesArray:responseData[@"data"]];
        self.cursor = [((NSString *)responseData[@"cursor"]) longLongValue];
        if (books.count>0) {
            [self.books addObjectsFromArray:books];
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];
        }else{
            [self.collectionView.footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.collectionView.footer endRefreshing];
    }];
}

#pragma mark search
- (void)selectSearchItem:(id)sender
{
    
    DLLSearchResultTableViewController *searchPageVC = [[DLLSearchResultTableViewController alloc] init];
//    [self.navigationController pushViewController:searchPageVC animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchPageVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    
    /*
     DLLSearchResultTableViewController *resultTableViewController = [[DLLSearchResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
    resultTableViewController.controller = self;
     
     self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultTableViewController];
     
     // Use the current view controller to update the search results.
     self.searchController.searchResultsUpdater = self;
     self.searchController.searchBar.placeholder = @"10000";
     
     //    self.searchController.searchBar.scopeButtonTitles = @[@"All", @"111"];
    
     
     self.searchController.searchBar.delegate = self;
     self.searchController.hidesNavigationBarDuringPresentation = NO;
     [self presentViewController:self.searchController animated:YES completion:nil];*/
     
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!searchController.active) {
        return;
    }
    NSString *text = searchController.searchBar.text;
    DLLSearchResultTableViewController *searchResultController = (DLLSearchResultTableViewController *)searchController.searchResultsController;
    searchResultController.filterString = text;
}
@end
