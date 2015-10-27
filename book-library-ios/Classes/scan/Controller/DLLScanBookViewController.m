//
//  DLLScanBookViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/25.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLScanBookViewController.h"
#import <MTBBarcodeScanner.h>
#import "TTHttpTool.h"
#import "DLLBook.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "DLLBookScanDetailView.h"

@interface DLLScanBookViewController ()

@property (nonatomic, weak) UIView *previewView;

@property (nonatomic, strong) MTBBarcodeScanner *scanner;

@property (nonatomic, strong)DLLBook *book;

@property (nonatomic, weak) DLLBookScanDetailView  *scanBookDetailView;


- (void)requestBookByIsbn:(NSString *)bookIsbn;

@end

@implementation DLLScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *previewView = [[UIView alloc] init];
    self.previewView = previewView;
    previewView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    [self.view addSubview:previewView];
    self.previewView.backgroundColor = [UIColor grayColor];
    
    DLLBookScanDetailView *scanBookDetailView = [[DLLBookScanDetailView alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, self.view.frame.size.width - 250 - 50)];
    self.scanBookDetailView = scanBookDetailView;
    [self.view addSubview:scanBookDetailView];
  
    [self startScanning];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Scanner

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_previewView];
    }
    return _scanner;
}

#pragma mark - Scanning

- (void)startScanning {
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSLog(@"Found code: %@", code.stringValue);
                if (code.stringValue) {
                    [self.scanner freezeCapture];
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        [self requestBookByIsbn:code.stringValue];
                        
                    });
                    
                }
                
            }];
            
        } else {
            // The user denied access to the camera
        }
    }];
}

- (void)stopScanning {
    [self.scanner stopScanning];
   
}

- (void)requestBookByIsbn:(NSString *)bookIsbn{
    //请求网络，获取对应图书Id的图书信息，并转换为Book对象
    NSLog(@"bookIsbn:%@",bookIsbn);
    
    NSString *baseUrl = @"http://isbn.itfengzi.com/api/v1/isbn/search?isbn=";
    
    NSString *url = [baseUrl stringByAppendingString:bookIsbn];
    NSLog(@"%@", url);
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        
            DLLBook *book = [DLLBook objectWithKeyValues:responseData[@"data"]];
            NSLog(@"bookName:%@",book.title);
        NSLog(@"bookAuthor:%@",[book.author componentsJoinedByString:@","]);

        self.scanBookDetailView.dllBook = book;
        
        [self.scanner unfreezeCapture];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
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
