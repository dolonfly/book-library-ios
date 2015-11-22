//
//  DLLLibraryInfo.h
//  book-library-ios
//
//  Created by dll on 15/11/22.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLLibraryInfo : NSObject

/** count */
@property (nonatomic,assign) int count;

- (int) bookCount;
- (void) requestInfoAndStore;


@end
