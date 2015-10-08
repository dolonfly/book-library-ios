//
//  DLLBookInfoCollectionViewCell.m
//  book-library-ios
//
//  Created by dll on 15/9/18.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookInfoCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface DLLBookInfoCollectionViewCell ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *label;

@end

@implementation DLLBookInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        self.imgView = imageView;
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20);
    self.label.frame = CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 10);
    self.label.textColor = [UIColor grayColor];
}

-(void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dllBook.bookImage] placeholderImage:nil];
    
    self.label.text = dllBook.bookName;
    
}


@end
