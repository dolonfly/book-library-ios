//
//  DLLBookDetailView.m
//  book-library-ios
//
//  Created by dll on 15/10/4.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookDetailView.h"
#import <UIImageView+WebCache.h>


@interface DLLBookDetailView ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *authorLabel;
@property (nonatomic, weak) UILabel *publisherLabel;

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

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setDllBook:(DLLBook *)dllBook
{
    _dllBook = dllBook;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dllBook.bookImage] placeholderImage:nil];
    
    self.nameLabel.text = dllBook.bookName;
    self.authorLabel.text = dllBook.author;
    self.publisherLabel.text = dllBook.publisher;
    
}





@end
