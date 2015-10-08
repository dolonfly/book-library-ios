//
//  DLLBookDetailView.m
//  book-library-ios
//
//  Created by dll on 15/10/4.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookDetailView.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>


@interface DLLBookDetailView () <SDWebImageManagerDelegate>

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *authorLabel;
@property (nonatomic, weak) UILabel *publisherLabel;
@property (nonatomic, weak) UILabel *borrowLabel;
@property (nonatomic, weak) UILabel *putInStorageLabel;

@end

@implementation DLLBookDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imgView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *authorLabel =[[UILabel alloc] init];
        [self addSubview:authorLabel];
        self.authorLabel = authorLabel;
        
        UILabel *publisherLabel = [[UILabel alloc] init];
        [self addSubview:publisherLabel];
        self.publisherLabel = publisherLabel;
        
        UILabel *borrowLabel = [[UILabel alloc] init];
        [self addSubview:borrowLabel];
        self.borrowLabel = borrowLabel;
        
        UILabel *putInStorageLabel = [[UILabel alloc] init];
        [self addSubview:putInStorageLabel];
        self.putInStorageLabel = putInStorageLabel;

    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor yellowColor];
   
    
    float y = 200;
    float divsion = 10;
    float fatherFrameWidth = self.frame.size.width;
    // set frame
    
    
    
    
    y = divsion + self.imgView.frame.origin.y + self.imgView.frame.size.height;
    
    self.nameLabel.frame = CGRectMake(0, y, fatherFrameWidth, 20);
    self.nameLabel.contentMode = UIViewContentModeCenter;
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    NSLog(@"image frame yyyy:%f",self.imgView.image.size.height);
    NSLog(@"image view h:%f",y);
    
}


- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    SDWebImageManager* imageManager = [SDWebImageManager sharedManager];
    imageManager.delegate = self;
    [imageManager downloadImageWithURL:[NSURL URLWithString:dllBook.bookImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //this is progress ,only special options can support
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            self.imgView.image = image;
            
            float imageHeigth = self.imgView.image.size.height;
            float imageWidth = self.imgView.image.size.width;
            float needWidth = self.frame.size.width/2;
            float needHeight = needWidth * imageHeigth / imageWidth;
            float needX = (self.frame.size.width - needWidth) / 2;
            // 1. 用一个临时变量保存返回值。
            CGRect temp = self.imgView.frame;
            // 2. 给这个变量赋值。因为变量都是L-Value，可以被赋值
            temp.size.height = needHeight;
            temp.size.width = needWidth;
            temp.origin.x = needX;
            //    temp.origin.y = y;
            // 3. 修改frame的值
            self.imgView.frame = temp;
        }else{
            NSLog(@"download image err");
        }
    }];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dllBook.bookImage] placeholderImage:nil];
    
    self.nameLabel.text = dllBook.bookName;
    self.authorLabel.text = [dllBook.authors componentsJoinedByString:@","];
    self.publisherLabel.text = dllBook.publisher;
    
}








@end
