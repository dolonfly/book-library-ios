//
//  DLLSearchResultTableViewController.h
//  book-library-ios
//
//  Created by dll on 15/11/15.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLSearchResultTableViewController : UITableViewController

@property (nonatomic,strong) NSString *filterString;
@property (nonatomic,weak) UIViewController *controller;

@end
