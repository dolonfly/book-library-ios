//
//  DLLTabBarButton.m
//  book-library-ios
//
//  Created by dll on 15/11/3.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLTabBarButton.h"

@implementation DLLTabBarButton

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];

    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
