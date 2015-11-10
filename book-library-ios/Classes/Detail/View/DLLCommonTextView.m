//
//  DLLCommonTextView.m
//  book-library-ios
//
//  Created by dll on 15/10/31.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLCommonTextView.h"

@interface DLLCommonTextView()

@property(nonatomic,weak) UILabel *titleLabel;
@property(nonatomic,weak) UILabel *publisherLabel;
@property(nonatomic,weak) UILabel *publishDateLabel;
@property(nonatomic,weak) UILabel *isbnLabel;
@property(nonatomic,weak) UILabel *pagesLabel;



@end

@implementation DLLCommonTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        UILabel *publisherLabel = [[UILabel alloc] init];
        self.publisherLabel = publisherLabel;
        [self addSubview:publisherLabel];
        
        UILabel *publishDateLabel = [[UILabel alloc] init];
        self.publishDateLabel = publishDateLabel;
        [self addSubview:publishDateLabel];
        
        UILabel *isbnLabel = [[UILabel alloc] init];
        self.isbnLabel = isbnLabel;
        [self addSubview:isbnLabel];
        
        UILabel *pagesLabel = [[UILabel alloc] init];
        self.pagesLabel = pagesLabel;
        [self addSubview:pagesLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat frameWidth = [self frame].size.width;
    
    self.titleLabel.frame = CGRectMake(0, 0, frameWidth, 20);
    self.publisherLabel.frame = CGRectMake(0, 30, frameWidth, 20);
    self.publishDateLabel.frame = CGRectMake(0, 60, frameWidth, 20);
    self.isbnLabel.frame = CGRectMake(0, 90, frameWidth, 20);
    self.pagesLabel.frame = CGRectMake(0, 120, frameWidth, 20);
    
    
}

- (void)setBook:(DLLBook *)book
{
    _book = book;
    
    self.titleLabel.text = @"更多图书信息";
    self.publisherLabel.text = book.publisher;
    self.publishDateLabel.text = book.publisher;;
    self.isbnLabel.text = book.isbn;
    self.pagesLabel.text = [NSString stringWithFormat:@"%d",book.pages];
}

@end
