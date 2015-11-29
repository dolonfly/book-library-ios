//
//  DLLPreOrderUtil.m
//  book-library-ios
//
//  Created by dll on 15/11/29.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLPreOrderUtil.h"
#import "TTHttpTool.h"

@implementation DLLPreOrderUtil

+ (void)getPreorderListOnSucess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [TTHttpTool getWithURL:@"http://172.16.1.13:3000/api/v1/preOrder" parameters:nil success:success failure:failure];
}

@end
