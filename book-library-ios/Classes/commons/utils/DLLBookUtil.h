//
//  DLLBookUtil.h
//  book-library-ios
//
//  Created by dll on 15/12/13.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLBookUtil : NSObject

+(void)getWithIsbn:(NSString *)isbn success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

+(void)listBooksWithCursor:(NSString *)cursor success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
