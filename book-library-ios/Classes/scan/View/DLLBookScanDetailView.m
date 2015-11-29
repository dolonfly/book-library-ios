//
//  DLLBookScanDetailView.m
//  book-library-ios
//
//  Created by dll on 15/10/27.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookScanDetailView.h"
#import <UIImageView+WebCache.h>

@interface DLLBookScanDetailView ()

@property (nonatomic, weak) UILabel *bookNameLabel;
@property (nonatomic, weak) UIImageView *bookImageView;
@property (nonatomic, weak) UILabel *bookAuthorLabel;
@property (nonatomic, weak) UILabel *bookPublisherLabel;

@end

@implementation DLLBookScanDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *bookImageView = [[UIImageView alloc] init];
        self.bookImageView = bookImageView;
        [self addSubview:bookImageView];
        
        UILabel *bookNameLabel = [[UILabel alloc] init];
        self.bookNameLabel = bookNameLabel;
        [self addSubview:bookNameLabel];
        
        UILabel *bookAuthorLabel = [[UILabel alloc] init];
        self.bookAuthorLabel = bookAuthorLabel;
        [self addSubview:bookAuthorLabel];
        self.bookAuthorLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *bookPublisherLabel = [[UILabel alloc]init];
        self.bookPublisherLabel = bookPublisherLabel;
        [self addSubview:bookPublisherLabel];
        self.bookPublisherLabel.font = [UIFont systemFontOfSize:12];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bookImageView.frame = CGRectMake(10, 0, self.frame.size.width/3 - 20, self.frame.size.width / 3 / 0.625);
    self.bookNameLabel.frame = CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3*2, 20);
    self.bookAuthorLabel.frame = CGRectMake(self.frame.size.width/3, 30, self.frame.size.width/3*2, 20);
    self.bookPublisherLabel.frame = CGRectMake(self.frame.size.width/3, 60, self.frame.size.width/3*2, 20);
}

- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:dllBook.image]];
    self.bookNameLabel.text = dllBook.title;
    self.bookAuthorLabel.text = [dllBook.author componentsJoinedByString:@","];
    self.bookPublisherLabel.text = dllBook.publisher;
}


@end
