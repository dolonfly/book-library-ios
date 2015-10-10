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

@interface DLLBookDetailViewController ()

- (void)requestBookById:(NSString *)bookId;

@end

@implementation DLLBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestBookById:self.bookId];
    self.view.backgroundColor = [UIColor whiteColor];
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestBookById:(NSString *)bookId{
    //请求网络，获取对应图书Id的图书信息，并转换为Book对象
    NSLog(@"bookId:%@",bookId);
    
    NSString *baseUrl = @"https://api.douban.com/v2/book/isbn/";
    
    NSString *url = [baseUrl stringByAppendingString:bookId];
    
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        [DLLBook setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"bookId":@"id",
                     @"bookName":@"title",
                     @"bookImage":@"images.large",
                     @"price":@"price",
                     @"authors":@"author",
                     @"publisher":@"publisher"
                     
                     };
        }];
        DLLBook *book = [DLLBook objectWithKeyValues:responseData];
        DLLBookDetailView *bookDetailView = [[DLLBookDetailView alloc] init];
        bookDetailView.frame = self.view.bounds;
        [self.view addSubview:bookDetailView];
        bookDetailView.dllBook = book;

        
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

@end
