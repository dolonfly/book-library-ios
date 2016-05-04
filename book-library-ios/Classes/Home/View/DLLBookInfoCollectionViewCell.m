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
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
//        imageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:imageView];
        self.imgView = imageView;
        self.imgView.contentMode = UIViewContentModeScaleToFill;
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelH = 30;
    self.imgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - labelH);
    self.label.frame = CGRectMake(0, self.bounds.size.height - labelH, self.bounds.size.width, labelH);
}

-(void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dllBook.image] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    
    
//    SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
//    imageManager.delegate = self;
//    [imageManager downloadImageWithURL:[NSURL URLWithString:dllBook.image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if (finished) {
//            self.imgView.image = image;
//        }
//    }];
    
    self.label.text = dllBook.title;
    
}


@end
