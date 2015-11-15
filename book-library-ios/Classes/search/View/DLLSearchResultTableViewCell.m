//
//  DLLSearchResultTableViewCell.m
//  book-library-ios
//
//  Created by dll on 15/11/15.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLSearchResultTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface DLLSearchResultTableViewCell ()

@property (nonatomic, weak) UIImageView *bookImgView;
@property (nonatomic, weak) UILabel *bookNameLabel;
@property (nonatomic,weak) UILabel *authorLabel;

@end

@implementation DLLSearchResultTableViewCell

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
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat imageWidth = (height - 8) * 0.625;
    CGFloat rightWidth = width - imageWidth - 4 - 4 - 4;
    self.bookImgView.frame = CGRectMake(4, 4, imageWidth, height - 8);
    self.bookNameLabel.frame = CGRectMake(imageWidth + 12,4, rightWidth, 20);
    self.authorLabel.frame = CGRectMake(imageWidth +12, 4 + 20 +4, rightWidth, 20);

}

- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.bookImgView sd_setImageWithURL:[NSURL URLWithString:dllBook.image]];
    self.bookNameLabel.text = dllBook.title;
    self.authorLabel.text = [dllBook.author componentsJoinedByString:@","];
    
}

@end
