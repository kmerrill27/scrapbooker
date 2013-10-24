//
//  KVMFlickrViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/29/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMFlickrTagSearcher.h"
#import "KVMURLImageView.h"

@interface KVMFlickrViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *searchResultsTable;
@property (strong, nonatomic) KVMFlickrTagSearcher *searcher;
@property (strong, nonatomic) NSMutableArray* photoArray;
@property id target;
@property SEL action;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)searchForPhoto:(NSString*)query;
-(void)clearSearch;

@end
