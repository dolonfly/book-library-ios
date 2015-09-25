//
//  TTHttpTool.m
//
//
//  Created by yuri on 14-10-23.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import "TTHttpTool.h"
#import <AFNetworking.h>

@implementation TTHttpTool

+ (void)postWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithoutStorageWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.shouldUseCredentialStorage = YES;    // 禁止缓存
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        TTLog(@"%@", operation.response.URL);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)urlStr parameters:(NSDictionary *)params formDataArray:(NSArray *)dataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接data数据
        for (TTFormDataModel *formDataModel in dataArray) {
            [formData appendPartWithFileData:formDataModel.data name:formDataModel.name fileName:formDataModel.filename mimeType:formDataModel.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

@implementation TTFormDataModel

@end
