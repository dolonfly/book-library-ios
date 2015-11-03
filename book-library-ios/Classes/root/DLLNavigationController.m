//
//  DLLNavigationController.m
//  book-library-ios
//
//  Created by dll on 15/10/16.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLNavigationController.h"

@interface DLLNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation DLLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    self.delegate = self;
    
    for (UIView *view in self.navigationBar.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
    
    //使自定返回按钮带有nav左划pop手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    backView.backgroundColor = [UIColor colorWithRed:253/255.0 green:208/255.0 blue:48/255.0 alpha:1];
    [self.navigationBar addSubview:backView];
    [self.navigationBar sendSubviewToBack:backView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
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
