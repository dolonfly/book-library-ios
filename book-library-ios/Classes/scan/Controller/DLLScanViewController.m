//
//  DLLScanViewController.m
//  book-library-ios
//
//  Created by dll on 15/11/1.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLScanViewController.h"
#import <MTBBarcodeScanner.h>
#import "DLLBook.h"
#import "TTHttpTool.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "DLLBookDetailViewController.h"

@interface DLLScanViewController ()

@property (nonatomic, weak) UIView *previewView;

@property (nonatomic, strong) MTBBarcodeScanner *scanner;

@property (nonatomic, weak) UIView *viewOfInterest;

@property (nonatomic, strong)DLLBook *book;


@end

@implementation DLLScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *previewView = [[UIView alloc] initWithFrame:self.view.frame];
    self.previewView = previewView;
    [self.view addSubview:previewView];

    
    UIView *viewOfInterest = [[UIView alloc] init];
    self.viewOfInterest = viewOfInterest;
    [self.view addSubview:viewOfInterest];
    self.viewOfInterest.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    self.viewOfInterest.layer.borderWidth = 1;
    self.viewOfInterest.layer.borderColor = [[UIColor blackColor] CGColor];

    UIView *temp = [[UIView alloc] init];
    temp.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    temp.alpha = 0.5;
    temp.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:temp];
    
    UIView *temp2 = [[UIView alloc] init];
    temp2.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.height-400);
    temp2.backgroundColor = [UIColor redColor];
    temp2.alpha = 0.5;
    temp2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:temp2];
    
    UILabel *tips = [[UILabel alloc] init];
    tips.frame = CGRectMake(0, 410, self.view.frame.size.width, 40);
    [self.view addSubview:tips];
    tips.text = @"将条码放入上面框内进行扫描";
    tips.textAlignment = NSTextAlignmentCenter;
    
    self.scanner.scanRect = self.viewOfInterest.frame;
    
    
//    [self startScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"view did appear");
    [self startScanning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"view did disappear");
    [self stopScanning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
                    DLLBook *book = [[DLLBook alloc] init];
                    book.isbn = code.stringValue;
                    DLLBookDetailViewController *detailVc = [[DLLBookDetailViewController alloc] init];
                    detailVc.book = book;
                    [self.navigationController pushViewController:detailVc animated:YES];

                    [self.scanner unfreezeCapture];
                    
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
            [self showText:@"请打开相机权限"];
        }
    }];
}

- (void)stopScanning {
    [self.scanner stopScanning];
    
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


@end
