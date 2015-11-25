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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width - 22) / 2, 9, 22, 22);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height - 6 - 9, contentRect.size.width, 9);
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
