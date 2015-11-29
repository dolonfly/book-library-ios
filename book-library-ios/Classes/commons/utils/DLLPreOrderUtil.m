//
//  DLLPreOrderUtil.m
//  book-library-ios
//
//  Created by dll on 15/11/29.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLPreOrderUtil.h"
#import "TTHttpTool.h"
#import <AFNetworking.h>

@implementation DLLPreOrderUtil

+ (void)getPreorderListOnSucess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [TTHttpTool getWithURL:@"http://172.16.1.13:3000/api/v1/preOrder" parameters:nil success:success failure:failure];
}

+ (void)addPreorderWithBookIsbn:(NSString *)isbn bookName:(NSString *)bookName success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"book":@{@"isbn":isbn,@"bookName":bookName}};
    [manager POST:@"http://172.16.1.13:3000/api/v1/preOrder" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            return success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            return failure(error);
        }
    }];
}

@end
