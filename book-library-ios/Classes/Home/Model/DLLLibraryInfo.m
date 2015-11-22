//
//  DLLLibraryInfo.m
//  book-library-ios
//
//  Created by dll on 15/11/22.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLLibraryInfo.h"
#import "TTHttpTool.h"
#import <MJExtension.h>

@implementation DLLLibraryInfo

- (int) bookCount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ud objectForKey:@"libraryInfo"];
    if (dict == NULL) {
        return 0;
    }
    return [dict[@"count"] intValue];
}

- (void) requestInfoAndStore
{
    [TTHttpTool getWithURL:@"http://bl.itfengzi.com/api/v1/book/count" parameters:nil success:^(id responseData) {
        int code = [responseData[@"code"] intValue];
        if (code == 200) {
            NSString *count = [responseData[@"count"] stringValue];
            NSMutableDictionary *dict = [NSMutableDictionary new];
            [dict setValue:count forKey:@"count"];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:dict forKey:@"libraryInfo"] ;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end

