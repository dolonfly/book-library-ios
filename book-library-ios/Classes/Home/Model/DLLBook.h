//
//  DLLBook.h
//  book-library-ios
//
//  Created by dll on 15/9/18.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLBook : NSObject

/** book ID*/
@property (nonatomic, copy) NSString *bookId;
/** 图片*/
@property (nonatomic, copy) NSString *bookImage;
/** 图书名称*/
@property (nonatomic, copy) NSString *bookName;
/** 价格*/
@property (nonatomic, assign) float price;
/** 作者*/
@property (nonatomic,copy) NSString *author;
/** 出版社*/
@property (nonatomic,copy) NSString *publisher;

@end
