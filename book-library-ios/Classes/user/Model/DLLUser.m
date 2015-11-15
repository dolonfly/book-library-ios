//
//  DLLUser.m
//  book-library-ios
//
//  Created by dll on 15/10/20.
//  Copyright © 2015年 dll. All rights reserved.
//

#import "DLLUser.h"
#import "TTHttpTool.h"

@implementation DLLUser

- (BOOL) isLogin
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ud objectForKey:@"user"];
    NSLog(@"dict:%@",dict);
    if (!dict || !dict[@"token"]) {
        return false;
    }
    return true;
}

- (void)login
{
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:@"admin" forKey:@"user"];
    [dict setValue:@"admin" forKey:@"password"];
    [dict setValue:@"token_admin" forKey:@"token"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dict forKey:@"user"] ;
}

-(void)loginout
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:@"user"];
}

@end
