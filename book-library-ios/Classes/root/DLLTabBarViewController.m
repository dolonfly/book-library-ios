//
//  DLLTabBarViewController.m
//  book-library-ios
//
//  Created by dll on 15/10/16.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLTabBarViewController.h"
#import "DLLTabBar.h"
#import "DLLNavigationController.h"
#import "DLLScanViewController.h"
#import "DLLHomeViewController.h"
#import "DLLUserCenterViewController.h"
#import <FAKIonIcons.h>

@interface DLLTabBarViewController () <DLLTabBarDelegate>

@property (nonatomic, weak) DLLTabBar *dllTabBar;

@end

@implementation DLLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self setupTabBar];
    [self setupAllChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**初始化tabbar */
- (void)setupTabBar
{
    DLLTabBar *dllTabBar = [[DLLTabBar alloc] init];
    dllTabBar.frame = self.tabBar.bounds;
    dllTabBar.delegate = self;
    [self.tabBar addSubview:dllTabBar];
    self.dllTabBar = dllTabBar;
}

- (void)setupAllChildViewController
{
    //1.首页控制器
    FAKIonIcons *homeIcon = [FAKIonIcons ios7HomeOutlineIconWithSize:30];
    [homeIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1]];
    UIImage *homeIconImage = [homeIcon imageWithSize:CGSizeMake(45, 45)];
    FAKIonIcons *homeIcon_select = [FAKIonIcons ios7PlayOutlineIconWithSize:30];
    [homeIcon_select addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1]];
    UIImage *homeIconImage_select = [homeIcon_select imageWithSize:CGSizeMake(45, 45)];
    
    DLLHomeViewController *homeVc = [[DLLHomeViewController alloc] init];
    [self setupChildViewController:homeVc withTitle:@"" withImage:homeIconImage withSelectedImage:homeIconImage_select];
    
    //2.我控制器
    FAKIonIcons *userIcon = [FAKIonIcons ios7PersonOutlineIconWithSize:30];
    [userIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1]];
    UIImage *userIconImage = [userIcon imageWithSize:CGSizeMake(45, 45)];
    
    DLLUserCenterViewController *userCenterVc = [[DLLUserCenterViewController alloc] init];
    [self setupChildViewController:userCenterVc withTitle:@"" withImage:userIconImage withSelectedImage:userIconImage];
}

- (void)setupChildViewController:(UIViewController *)childVc withTitle:(NSString *)title withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectImageName
{
    //设置tabBar的图片
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //设置tabBar选中时的图片
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    //设置Nav控制器并添加root控制器
    DLLNavigationController *nav = [[DLLNavigationController alloc] initWithRootViewController:childVc];
    //设置子控制器的标题
    childVc.title = title;
    
    [self addChildViewController:nav];
    [self.dllTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
}

- (void)setupChildViewController:(UIViewController *)childVc withTitle:(NSString *)title withImage:(UIImage *)image withSelectedImage:(UIImage *)selectImage
{
    //设置tabBar的图片
    childVc.tabBarItem.image = image;
    
    //设置tabBar选中时的图片
    childVc.tabBarItem.selectedImage = selectImage;
    
    //设置Nav控制器并添加root控制器
    DLLNavigationController *nav = [[DLLNavigationController alloc] initWithRootViewController:childVc];
    //设置子控制器的标题
    childVc.title = title;
    
    [self addChildViewController:nav];
    [self.dllTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
}

#pragma mark - tabBar代理事件
- (void)tabBar:(DLLTabBar *)tabBar didSelectForm:(NSInteger)form to:(NSInteger)to
{
    self.selectedIndex = to;
}

- (void)tabBarDidClickCameraButton:(DLLTabBar *)tabBar
{
    DLLScanViewController *scanVc = [[DLLScanViewController alloc] init];
    DLLNavigationController *nav = [[DLLNavigationController alloc] initWithRootViewController:scanVc];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}


@end
