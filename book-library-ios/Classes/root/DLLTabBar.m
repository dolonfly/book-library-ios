//
//  DLLTabBar.m
//  book-library-ios
//
//  Created by dll on 15/11/3.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLTabBar.h"
#import "DLLTabBarButton.h"
#import <FontAwesomeKit/FAKIonIcons.h>

@interface DLLTabBar ()

@property (nonatomic, strong) UIButton *selectedBtn;
/* cameraButton 按钮*/
@property (nonatomic, weak) UIButton *cameraButton;
/* tabbar按钮数组*/
@property (nonatomic, strong) NSMutableArray *tabbarBtnArray;

@end

@implementation DLLTabBar

- (NSMutableArray *)tabbarBtnArray
{
    if (_tabbarBtnArray == nil) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return _tabbarBtnArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        self.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1];
        
        UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraButton.frame = CGRectMake(0, 0, 60, 60);
//        [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_takepicture"] forState:UIControlStateNormal];
        
        
        FAKIonIcons *mailIcon = [FAKIonIcons ios7CameraOutlineIconWithSize:60];
        [mailIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1]];
        UIImage *iconImage = [mailIcon imageWithSize:CGSizeMake(60, 60)];
        [cameraButton setBackgroundImage:iconImage forState:UIControlStateNormal];
        
//        cameraButton.backgroundColor = [UIColor yellowColor];
//        [cameraButton.imageView setImage:[UIImage imageNamed:@"camera_takePicture.png"]];
        /** 为cammeraButton添加点击事件*/
        [cameraButton addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cameraButton];
        self.cameraButton = cameraButton;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = (self.frame.size.width - 60) / self.tabbarBtnArray.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    self.cameraButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    for (int i = 0; i < self.tabbarBtnArray.count; i++) {
        //去除按钮
        DLLTabBarButton *button = self.tabbarBtnArray[i];
        button.tag = i;
        //设置按钮的frame
        CGFloat buttonX = 0;
        if (i < self.tabbarBtnArray.count / 2) {
            buttonX = i * buttonW;
        }else{
            buttonX = i * buttonW + self.cameraButton.frame.size.width;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)item
{
    DLLTabBarButton *button = [DLLTabBarButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    
    //监听点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    [self.tabbarBtnArray addObject:button];
    if (self.tabbarBtnArray.count == 1) {
        [self buttonClick:button];
    }
}


#pragma mark - 控件监听事件

- (void)buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectForm:to:)]) {
        [self.delegate tabBar:self didSelectForm:self.selectedBtn.tag to:sender.tag];
    }
}

-(void)cameraBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickCameraButton:)]) {
        [self.delegate tabBarDidClickCameraButton:self];
    }
}



@end
