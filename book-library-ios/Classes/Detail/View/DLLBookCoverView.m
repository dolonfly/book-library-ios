//
//  DLLBookCoverView.m
//  book-library-ios
//
//  Created by dll on 15/10/21.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookCoverView.h"
#import <UIImageView+WebCache.h>

@interface DLLBookCoverView ()


@end

@implementation DLLBookCoverView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    
}

- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    [self sd_setImageWithURL:[NSURL URLWithString:dllBook.image]];
}

@end
