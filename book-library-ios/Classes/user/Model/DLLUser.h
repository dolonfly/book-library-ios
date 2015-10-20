//
//  DLLUser.h
//  book-library-ios
//
//  Created by dll on 15/10/20.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLUser : NSObject

/** user ID*/
@property (nonatomic, copy) NSString *ID;
/** 图片*/
@property (nonatomic, copy) NSString *image;
/** 名称*/
@property (nonatomic, copy) NSString *userName;
/** email*/
@property (nonatomic, copy) NSString *email;
/** 昵称*/
@property (nonatomic, copy) NSString *nickName;

@end
