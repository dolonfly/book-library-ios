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
#import <UIScrollView+APParallaxHeader.h>
#import "DLLBookCoverView.h"


@interface DLLBookDetailView () <SDWebImageManagerDelegate>

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *authorLabel;
@property (nonatomic, weak) UILabel *publisherLabel;
@property (nonatomic, weak) UIButton *putInStorageBtn;
@property (nonatomic, weak) UIButton *likeBtn;

@property (nonatomic, weak) DLLBookCoverView *bookCover;

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
    
//        [self addParallaxWithImage:[UIImage imageNamed:@"miao.jpg"] andHeight:300];
        
        DLLBookCoverView *bookCover = [[DLLBookCoverView alloc] initWithFrame:frame];
        self.bookCover = bookCover;
        [self addParallaxWithView:bookCover andHeight:500];
        
        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.backgroundColor = [UIColor grayColor];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self addSubview:imageView];
//        self.imgView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *authorLabel =[[UILabel alloc] init];
        [self addSubview:authorLabel];
        self.authorLabel = authorLabel;
        
        UILabel *publisherLabel = [[UILabel alloc] init];
        [self addSubview:publisherLabel];
        self.publisherLabel = publisherLabel;
        
        UIButton *putInStoreageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        putInStoreageBtn.tag = 0;
        [putInStoreageBtn setTitle:@"入库" forState:UIControlStateNormal];
        [self addSubview:putInStoreageBtn];
        self.putInStorageBtn = putInStoreageBtn;
        
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        likeBtn.tag = 1;
        [likeBtn setTitle:@"推荐" forState:UIControlStateNormal];
        [self addSubview:likeBtn];
        self.likeBtn = likeBtn;
        

    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:50];
   
    
    
    
    float y = 200;
    float divsion = 10;
    float fatherFrameWidth = self.frame.size.width;
    // set frame
    
    y = divsion + self.imgView.frame.origin.y + self.imgView.frame.size.height;
    
    self.nameLabel.frame = CGRectMake(0, y, fatherFrameWidth, 20);
    self.nameLabel.contentMode = UIViewContentModeCenter;
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    
    y = divsion + self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height;
    self.authorLabel.frame = CGRectMake(0, y, fatherFrameWidth, 20);
    self.authorLabel.contentMode = UIViewContentModeCenter;
    [self.authorLabel setTextAlignment:NSTextAlignmentCenter];
    self.authorLabel.textColor = [UIColor grayColor];

    
    y =  self.authorLabel.frame.origin.y + self.authorLabel.frame.size.height;
    self.publisherLabel.frame = CGRectMake(0, y, fatherFrameWidth, 20);
    self.publisherLabel.contentMode = UIViewContentModeCenter;
    [self.publisherLabel setTextAlignment:NSTextAlignmentCenter];
    self.publisherLabel.textColor = [UIColor grayColor];
    
    self.nameLabel.font = [UIFont systemFontOfSize:18 weight:18];
    
    
    //button
    y = divsion + self.publisherLabel.frame.origin.y + self.publisherLabel.frame.size.height;
    self.putInStorageBtn.frame = CGRectMake(fatherFrameWidth / 2 - 60 - 10, y, 60, 40);
//    self.putInStorageBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:10];
    [self.putInStorageBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.putInStorageBtn.layer.cornerRadius = 5.0f;
    self.putInStorageBtn.layer.masksToBounds = YES;
    self.putInStorageBtn.layer.borderWidth = 0.5f;
    self.putInStorageBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
    // 推荐按钮
    self.likeBtn.frame = CGRectMake(fatherFrameWidth/2+10, y, 60, 40);
    [self.likeBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.likeBtn.layer.cornerRadius = 5.0f;
    self.likeBtn.layer.masksToBounds = YES;
    self.likeBtn.layer.borderWidth = 0.5f;
    self.likeBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
}


- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    self.bookCover.dllBook = dllBook;
    
    
    SDWebImageManager* imageManager = [SDWebImageManager sharedManager];
    NSLog(@"bookImageUrl:%@",dllBook.image);
    imageManager.delegate = self;
    [imageManager downloadImageWithURL:[NSURL URLWithString:dllBook.image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //this is progress ,only special options can support
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            self.imgView.image = image;
            /*
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
            
            self.imgView.layer.borderWidth = 1;
            self.imgView.layer.borderColor = [UIColor colorWithRed:218 green:218 blue:218 alpha:0.2].CGColor;
            self.imgView.contentMode = UIViewContentModeScaleAspectFill;
*/
            
            
        }else{
            NSLog(@"download image err");
        }
    }];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dllBook.bookImage] placeholderImage:nil];
    
    self.nameLabel.text = dllBook.title;
    self.authorLabel.text = [NSString stringWithFormat:@"作者：%@",dllBook.author];
    self.publisherLabel.text = [NSString stringWithFormat:@"出版社：%@",dllBook.publisher];
    NSLog(@"出版社：%@",dllBook.publisher);
    
}








@end
