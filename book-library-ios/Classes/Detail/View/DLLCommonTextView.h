//
//  DLLCommonTextView.h
//  book-library-ios
//
//  Created by dll on 15/10/31.
//  Copyright © 2015年 dll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLBook.h"

@interface DLLCommonTextView : UITableViewCell

@property(nonatomic,strong) DLLBook *book;
@property(nonatomic,assign) CGFloat viewHeigth;

@end
