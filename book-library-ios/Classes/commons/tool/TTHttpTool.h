//
//  TTHttpTool.h
//
//
//  Created by yuri on 14-10-23.
//  Copyright (c) 2014年 yuri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTHttpTool : NSObject

/**
 *  post请求
 *
 *  @param urlStr  请求URL
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求
 *
 *  @param urlStr  请求URL
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求不带缓存
 *
 *  @param urlStr  请求URL
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithoutStorageWithURL:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

/**
 *  post请求 上传文件
 *
 *  @param urlStr     请求URL
 *  @param params     请求参数
 *  @param dataArray  请求发送文件的参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)postWithURL:(NSString *)urlStr parameters:(NSDictionary *)params formDataArray:(NSArray *)dataArray success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end

#pragma mark - 请求发送文件的模型
@interface TTFormDataModel : NSObject

/** 文件数据*/
@property (nonatomic, strong) NSData *data;

/** 参数名*/
@property (nonatomic, copy) NSString *name;

/** 文件名*/
@property (nonatomic, copy) NSString *filename;

/** 文件类型*/
@property (nonatomic, copy) NSString *mimeType;

@end