//
//  KVMScrapbookViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMScrapbookPage.h"
#import "KVMPageDetailViewController.h"
#import "KVMAddPageViewController.h"
#import "KVMDatabase.h"

@interface KVMScrapbookViewController : UITableViewController

@property NSMutableArray* pages;
@property KVMPageDetailViewController* pageDetailViewController;
@property KVMAddPageViewController* addPageViewController;

-(void)addPage:(NSMutableDictionary *)data;
- (void)addButtonPressed;

@end
