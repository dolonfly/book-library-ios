//
//  DLLTabBar.h
//  book-library-ios
//
//  Created by dll on 15/11/3.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLLTabBar;

@protocol DLLTabBarDelegate <NSObject>
@optional

/** 控制器切换*/
- (void)tabBar:(DLLTabBar *)tabBar didSelectForm:(NSInteger)form to:(NSInteger)to;

/** 拍照按钮*/
- (void)tabBarDidClickCameraButton:(DLLTabBar *)tabBar;


@end

@interface DLLTabBar : UIView

@property (nonatomic, weak) id<DLLTabBarDelegate> delegate;

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)item;

@end
