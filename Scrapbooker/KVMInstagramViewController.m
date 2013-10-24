//
//  KVMInstagramViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/29/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMInstagramViewController.h"

@interface KVMInstagramViewController ()

@end

@implementation KVMInstagramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.target = incomingTarget;
        self.action = incomingAction;
    }
    return self;
}

-(void)searchForPhoto:(NSString*)query
{
    [self.photoArray removeAllObjects];
    self.searcher = [[KVMInstagramTagSearcher alloc] initWithTagQuery:query andTarget:self andAction:@selector(handleInstagramData:)];
}

- (void)handleInstagramData:(NSMutableDictionary *)data
{
    NSMutableArray *photos = [data objectForKey:@"data"];
    
    int i = 0;
    
    for (NSMutableDictionary *photo in photos) {
        KVMURLImageView* temp = [[KVMURLImageView alloc] initWithURL:[NSURL URLWithString:[[[photo objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"]] andFrame:CGRectMake(0, 50 * i, 50, 50)];
        
        [self.photoArray addObject:temp];
        
        ++i;
    }
    
    // Yay hacking!
    [self performSelector:@selector(reload:) withObject:nil afterDelay:1.5];
}

-(void)reload:(NSObject *)data
{
    [self.searchResultsTable reloadData];
}

-(void)clearSearch
{
    [self.photoArray removeAllObjects];
    [self.searchResultsTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    KVMURLImageView* temp = [self.photoArray objectAtIndex:indexPath.row];
    cell.imageView.image = temp.image;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KVMURLImageView* temp = [self.photoArray objectAtIndex:indexPath.row];
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchResultsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
