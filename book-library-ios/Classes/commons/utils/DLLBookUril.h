//
//  DLLBookUril.h
//  book-library-ios
//
//  Created by dll on 15/11/29.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLBookUril : NSObject

+(void)getWithIsbn:(NSString *)isbn success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
