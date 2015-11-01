//
//  DLLBook.m
//  book-library-ios
//
//  Created by dll on 15/9/18.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBook.h"
#import <MJExtension.h>

@implementation DLLBook

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"_id",
             @"isbn" : @"isbn13",
             @"stock" : @"stock"
             };
}

@end
