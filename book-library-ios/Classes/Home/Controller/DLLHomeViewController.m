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

@interface DLLHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *books;
- (void)requestNewsBooks;

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
    [self requestNewsBooks];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    CGFloat width = self.view.bounds.size.width / 3 - 10;
    CGFloat height = width / 0.625 ;//为什么是0.625倍？仿照kindle 的尺寸
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.frame = self.view.bounds;
    [collectionView registerClass:[DLLBookInfoCollectionViewCell class] forCellWithReuseIdentifier:@"bookInfoCell"];
//    collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
        
    /*
    BLKFlexibleHeightBar *myBar = [[BLKFlexibleHeightBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 100.0)];
    myBar.minimumBarHeight = 50.0;
    
    myBar.backgroundColor = [UIColor colorWithRed:0.86 green:0.25 blue:0.23 alpha:1];
    [self.view addSubview:myBar];
    
    myBar.behaviorDefiner = [SquareCashStyleBehaviorDefiner new];
    
    [myBar.behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:0.5];
    [myBar.behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:0.5 end:1.0];
    
//    ((UIScrollView *)collectionView).delegate = (id<UITableViewDelegate>)myBar.behaviorDefiner;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    [searchBar sizeToFit];
    [myBar addSubview:searchBar];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialLayoutAttributes = [BLKFlexibleHeightBarSubviewLayoutAttributes new];
    initialLayoutAttributes.size = searchBar.frame.size;
    initialLayoutAttributes.center = CGPointMake(CGRectGetMidX(myBar.bounds), CGRectGetMidY(myBar.bounds)+10.0);
    // This is what we want the bar to look like at its maximum height (progress == 0.0)
    [searchBar addLayoutAttributes:initialLayoutAttributes forProgress:0.0];
    
    // Create a final set of layout attributes based on the same values as the initial layout attributes
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialLayoutAttributes];
    finalLayoutAttributes.alpha = 0.0;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0.0, -30.0);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.2, 0.2);
    finalLayoutAttributes.transform = CGAffineTransformConcat(scale, translation);
    
    // This is what we want the bar to look like at its minimum height (progress == 1.0)
    [searchBar addLayoutAttributes:finalLayoutAttributes forProgress:1.0];
    */
    
    
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

- (void)requestNewsBooks
{
    [TTHttpTool getWithURL:@"http://121.40.253.109:3002/api/v1/book/news" parameters:NULL success:^(id responseData) {
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            NSArray *datas = responseData[@"data"];
            NSArray *books = [DLLBook objectArrayWithKeyValuesArray:datas];
            _books = books;
            
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end