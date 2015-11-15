//
//  DLLBookInfoTableViewCell.m
//  book-library-ios
//
//  Created by dll on 15/11/15.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookInfoTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface DLLBookInfoTableViewCell ()

@property (nonatomic, weak) UIImageView *bookImgView;
@property (nonatomic, weak) UILabel *bookNameLabel;
@property (nonatomic,weak) UILabel *authorLabel;
@property (nonatomic,weak) UILabel *isbnLabel;

@end

@implementation DLLBookInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bookImgView = [[UIImageView alloc] init];
        bookImgView.backgroundColor = [UIColor whiteColor];
        bookImgView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:bookImgView];
        self.bookImgView = bookImgView;
        self.bookImgView.contentMode = UIViewContentModeScaleToFill;
        
        UILabel *bookNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:bookNameLabel];
        self.bookNameLabel = bookNameLabel;
        self.bookNameLabel.font = [UIFont systemFontOfSize:16];
        
        UILabel *authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
        self.authorLabel.font = [UIFont systemFontOfSize:12 weight:0.1];
        self.authorLabel.textColor = [UIColor grayColor];
        
        UILabel *isbnLabel = [[UILabel alloc] init];
        [self.contentView addSubview:isbnLabel];
        self.isbnLabel = isbnLabel;
        self.isbnLabel.font = [UIFont systemFontOfSize:12 weight:0.1];;
        self.isbnLabel.textColor = [UIColor grayColor];
        
        
    }
    return self;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat imageWidth = 125 * 0.625;
    CGFloat rightWidth = width - imageWidth - 4 - 4 - 4;
    self.bookImgView.frame = CGRectMake(4, 4, imageWidth, 125);
    self.bookNameLabel.frame = CGRectMake(imageWidth + 12,4, rightWidth, 20);
    self.authorLabel.frame = CGRectMake(imageWidth +12, 4 + 20 +4, rightWidth, 20);
    self.isbnLabel.frame = CGRectMake(imageWidth + 12, 4 + 20 +4 + 20 +4, rightWidth, 20);
}

- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.bookImgView sd_setImageWithURL:[NSURL URLWithString:dllBook.image]];
    self.bookNameLabel.text = dllBook.title;
    self.authorLabel.text = [dllBook.author componentsJoinedByString:@","];
    self.isbnLabel.text = dllBook.isbn;
    
}

@end
