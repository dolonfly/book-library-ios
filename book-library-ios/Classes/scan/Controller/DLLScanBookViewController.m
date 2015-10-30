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
#import <SWFrameButton.h>

@interface DLLScanBookViewController ()

@property (nonatomic, weak) UIView *previewView;

@property (nonatomic, strong) MTBBarcodeScanner *scanner;

@property (nonatomic, strong)DLLBook *book;

@property (nonatomic, weak) DLLBookScanDetailView  *scanBookDetailView;


@property (nonatomic, weak) SWFrameButton *saveBookBtn;
@property (nonatomic, weak) SWFrameButton *cancelBtn;

@property (nonatomic, assign) bool canClickSaveBtn;

- (void)requestBookByIsbn:(NSString *)bookIsbn;

@end

@implementation DLLScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *previewView = [[UIView alloc] init];
    self.previewView = previewView;
    previewView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    [self.view addSubview:previewView];
    self.previewView.backgroundColor = [UIColor grayColor];
    
    DLLBookScanDetailView *scanBookDetailView = [[DLLBookScanDetailView alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, self.view.frame.size.width - 250 - 50)];
    self.scanBookDetailView = scanBookDetailView;
    [self.view addSubview:scanBookDetailView];
    
    CGFloat btnWidth = self.view.frame.size.width / 2 - 50;
    
    SWFrameButton *saveBookBtn = [[SWFrameButton alloc] init];
    saveBookBtn.frame = CGRectMake(25, self.view.frame.size.height - 120, btnWidth, 40);
    [saveBookBtn setTitle:@"入库" forState:UIControlStateNormal];
    [saveBookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:saveBookBtn];
    self.saveBookBtn = saveBookBtn;
    saveBookBtn.tag = 0;
    [saveBookBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    saveBookBtn.backgroundColor = [UIColor blueColor];
    [saveBookBtn.layer setMasksToBounds:YES];
    [saveBookBtn.layer setCornerRadius:10.0];

    
    SWFrameButton *cancelBtn = [[SWFrameButton alloc] init];
    self.cancelBtn = cancelBtn;
    [self.view addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(self.view.frame.size.width/2 + 25, self.view.frame.size.height - 120, btnWidth, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.tag = 1;
    [cancelBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor redColor];
    [cancelBtn.layer setMasksToBounds:YES];
    [cancelBtn.layer setCornerRadius:10.0];
    
    self.canClickSaveBtn = false;
    [self startScanning];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self stopScanning];
}

- (void)setCanClickSaveBtn:(bool)canClickSaveBtn
{
    _canClickSaveBtn = canClickSaveBtn;
    if (_canClickSaveBtn) {
        [self.saveBookBtn setUserInteractionEnabled:YES];
    }else{
        [self.saveBookBtn setUserInteractionEnabled:NO];
        self.saveBookBtn.backgroundColor = [UIColor grayColor];
    }
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
                if (code.stringValue && (([code.stringValue length]==10) || ([code.stringValue length] ==13 && [code.stringValue hasPrefix:@"978"]))) {
                    [self.scanner freezeCapture];
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        [self requestBookByIsbn:code.stringValue];
                        
                    });
                    
                }else{
                    [self.scanner freezeCapture];
                    [self showText:[NSString stringWithFormat:@"条形码不合法：%@",code.stringValue]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.scanner unfreezeCapture];
                        
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
    
    NSString *baseUrl = @"http://bl.itfengzi.com/api/v1/book?isbn=";
    
    NSString *url = [baseUrl stringByAppendingString:bookIsbn];
    NSLog(@"%@", url);
    [TTHttpTool getWithURL:url parameters:NULL success:^(id responseData) {
        
            DLLBook *book = [DLLBook objectWithKeyValues:responseData[@"data"]];
        self.book = book;
            NSLog(@"bookName:%@",book.title);
        NSLog(@"bookAuthor:%@",[book.author componentsJoinedByString:@","]);

        self.scanBookDetailView.dllBook = book;
        self.canClickSaveBtn = true;
        
        [self.scanner unfreezeCapture];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - tast

- (void)showText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3];

}

#pragma mark - onClick
-(void)btnPressed:(id)sender{
    UIButton* btn = (UIButton*)sender;
    if (btn.tag == 0) {
        NSString *baseUrl = @"http://bl.itfengzi.com/api/v1/book/add?isbn=";
        NSString *url = [baseUrl stringByAppendingString:_book.isbn];
        [TTHttpTool getWithoutStorageWithURL:url parameters:NULL success:^(id responseData) {
            if ([responseData[@"code"] intValue] == 200) {
                [self showText:[NSString stringWithFormat:@"保存图书成功，库存为:%d",[responseData[@"data"][@"stock"] intValue]]];
                self.canClickSaveBtn = false;
            }else{
                [self showText:@"保存图书失败"];
            }
        } failure:^(NSError *error) {
            [self showText:@"服务器故障，请稍后重试"];
        }];
    }else if(btn.tag == 1){
        [self.navigationController popViewControllerAnimated:TRUE];
    }
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
