//
//  DLLPreOrderUtil.h
//  book-library-ios
//
//  Created by dll on 15/11/29.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLPreOrderUtil : NSObject

+ (void)getPreorderListOnSucess:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

+ (void)addPreorderWithBookIsbn:(NSString *)isbn bookName:(NSString *)bookName success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
