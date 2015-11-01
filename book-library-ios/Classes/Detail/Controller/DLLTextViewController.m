//
//  DLLTextViewController.m
//  book-library-ios
//
//  Created by dll on 15/11/1.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLTextViewController.h"

@interface DLLTextViewController ()

@property (nonatomic, retain) UITextView *textView;

@end

@implementation DLLTextViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view frame];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
    
    self.textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    
    self.textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    
//    self.textView.delegate = self;//设置它的委托方法
    
    self.textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    
    self.textView.text = @"Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.";//设置它显示的内容
    
    self.textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    self.textView.scrollEnabled = YES;//是否可以拖动
    
    self.textView.editable = NO;//禁止编辑
    
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self.view addSubview: self.textView];//加入到整个页面中
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setDes:(NSString *)des
{
    _des = des;
//    [self.view frame];
    
    self.textView.text = des;
    self.textView.text = @"Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.";//设置它显示的内容
}

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    
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
