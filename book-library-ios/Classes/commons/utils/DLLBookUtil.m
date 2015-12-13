//
//  DLLBookUtil.m
//  book-library-ios
//
//  Created by dll on 15/12/13.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLBookUtil.h"
#import "TTHttpTool.h"
#import "DLLBook.h"
#import <MJExtension.h>

@implementation DLLBookUtil

+(void)getWithIsbn:(NSString *)isbn success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [@"http://bl.itfengzi.com/api/v1/book?isbn=" stringByAppendingString:isbn];
    [TTHttpTool getWithoutStorageWithURL:url parameters:nil success:^(id responseData) {
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            DLLBook *book = [DLLBook objectWithKeyValues:responseData[@"data"]];
            return success(book);
        }
        return failure([[NSError init] initWithString:@"err"]);
    } failure:^(NSError *error) {
        return failure(error);
    }];
}

+(void)listBooksWithCursor:(NSString *)cursor success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (cursor==nil || cursor == NULL || [cursor isEqualToString:@"0"]) {
        cursor = @"";
    }
    NSString *url = [@"http://bl.itfengzi.com/api/v1/books?cursor=" stringByAppendingString:cursor];
    [TTHttpTool getWithURL:url parameters:nil success:^(id responseData) {
        return success(responseData);
    } failure:^(NSError *error) {
        return failure(error);
    }];
}

@end
