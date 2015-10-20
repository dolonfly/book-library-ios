//
//  DLLUserInfoView.m
//  book-library-ios
//
//  Created by dll on 15/10/20.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLUserInfoView.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+LBBlurredImage.h>

@interface DLLUserInfoView ()

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation DLLUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(0, 0, 100, 100);
        self.imgView = imageView;
        [self addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://blog.gamecd.com.cn/content/images/2015/09/IMG_0184.JPG"]];
//        [self setImage:[UIImage imageNamed:@"miao.jpg"]];
        [self setImageToBlur:[UIImage imageNamed:@"miao.jpg"] blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:^{
            
            
        }];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat imageRadius = 50;
    CGFloat spaceHeigth = 50;
    NSLog(@"view size:%f",self.frame.size.width);
    NSLog(@"view size:%f",self.frame.size.height);
    self.imgView.frame = CGRectMake(width / 2 - imageRadius, height - imageRadius*2 - spaceHeigth, imageRadius * 2, imageRadius * 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
