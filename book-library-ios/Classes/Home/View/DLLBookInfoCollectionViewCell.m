//
//  DLLBookInfoCollectionViewCell.m
//  book-library-ios
//
//  Created by dll on 15/9/18.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookInfoCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>

@interface DLLBookInfoCollectionViewCell () <SDWebImageManagerDelegate>

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *label;

@end

@implementation DLLBookInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:imageView];
        self.imgView = imageView;
        self.imgView.contentMode = UIViewContentModeScaleToFill;
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20);
    self.label.frame = CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 10);
    self.label.font = [UIFont systemFontOfSize:12 weight:0.5];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    self.label.textColor = [UIColor grayColor];
}

-(void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    
    SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
    imageManager.delegate = self;
    [imageManager downloadImageWithURL:[NSURL URLWithString:dllBook.image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            self.imgView.image = image;
        }
    }];
        
    self.label.text = dllBook.title;
    
}


@end
