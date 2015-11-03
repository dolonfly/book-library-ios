//
//  DLLBookCoverView.m
//  book-library-ios
//
//  Created by dll on 15/10/21.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookCoverView.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+LBBlurredImage.h>

@interface DLLBookCoverView ()

@property(nonatomic,weak) UIImageView *backImage;
@property(nonatomic,weak) UIImageView *bookImageView;
@property(nonatomic,weak) UILabel *bookTitleLabel;
@property(nonatomic,weak) UILabel *bookAuthorLabel;
@property(nonatomic,weak) UILabel *isbnLabel;
@property(nonatomic,weak) UILabel *pagesLabel;
@property(nonatomic,weak) UILabel *stockLabel;


@end

@implementation DLLBookCoverView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        

        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backImage = [[UIImageView alloc] init];
        [self addSubview:backImage];
        self.backImage = backImage;
        [backImage setImageToBlur:[UIImage imageNamed:@"miao.jpg"] completionBlock:^{
            
        }];
        
        UIImageView *bookImageView = [[UIImageView alloc] init];
        [self addSubview:bookImageView];
        self.bookImageView = bookImageView;
        
        UILabel *bookTitleLabel = [[UILabel alloc] init];
        [self addSubview:bookTitleLabel];
        self.bookTitleLabel = bookTitleLabel;
        
        UILabel *bookAuthorLabel = [[UILabel alloc] init];
        [self addSubview:bookAuthorLabel];
        self.bookAuthorLabel = bookAuthorLabel;
        
        UILabel *isbnLabel = [[UILabel alloc] init];
        [self addSubview:isbnLabel];
        self.isbnLabel = isbnLabel;
        
        UILabel *pagesLabel = [[UILabel alloc] init];
        [self addSubview:pagesLabel];
        self.pagesLabel = pagesLabel;
        
        UILabel *stockLabel = [[UILabel alloc] init];
        [self addSubview:stockLabel];
        self.stockLabel = stockLabel;

    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat border = 10;
    CGFloat frameWidth = [self frame].size.width;
    CGFloat imageHeigth = 200 - border *2 ;
    CGFloat imageWidth = imageHeigth * 0.725;
    
    self.backImage.frame = CGRectMake(0, 0, frameWidth, 200);
    self.bookImageView.frame = CGRectMake(border, border, imageWidth, imageHeigth);
    self.bookTitleLabel.frame = CGRectMake(imageWidth + border * 2, border, frameWidth - imageWidth - border * 2, 20);
    self.bookAuthorLabel.frame = CGRectMake(imageWidth + border * 2, border + 10 + 20, frameWidth - imageWidth - border * 2, 20);
    
    self.isbnLabel.frame = CGRectMake(imageWidth + border * 2, border + 30 *2 , frameWidth - imageWidth - border * 2, 20);
    self.pagesLabel.frame = CGRectMake(imageWidth + border * 2, border + 30 *3 , frameWidth - imageWidth - border * 2, 20);
    self.stockLabel.frame = CGRectMake(imageWidth + border * 2, border + 30 *4 , frameWidth - imageWidth - border * 2, 20);
    
}

- (void)setBook:(DLLBook *)book
{
    _book = book;
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:book.image]];
    self.bookTitleLabel.text = book.title;
    self.bookAuthorLabel.text = [NSString stringWithFormat:@"作者：%@",[book.author componentsJoinedByString:@","]];
    self.isbnLabel.text = [NSString stringWithFormat:@"ISBN：%@",book.isbn];
    self.pagesLabel.text = [NSString stringWithFormat:@"页码：%d",book.pages];
    self.stockLabel.text = [NSString stringWithFormat:@"库存：%d",book.stock];

    NSLog(@"book stock:%d",book.stock);

}

@end
