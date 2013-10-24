//
//  KVMFlickrViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/29/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMFlickrViewController.h"

@interface KVMFlickrViewController ()

@end

@implementation KVMFlickrViewController

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
    self.searcher = [[KVMFlickrTagSearcher alloc] initWithTagQuery:query andTarget:self andAction:@selector(handleFlickrData:)];
}

-(void)clearSearch
{
    [self.photoArray removeAllObjects];
    [self.searchResultsTable reloadData];
}

- (void) handleFlickrData:(NSMutableDictionary *)data
{
    NSMutableArray *photos = [[data objectForKey:@"photos"] objectForKey:@"photo"];
    
    int i = 0;
    
    NSString *photoUrl = @"http://farm%@.staticflickr.com/%@/%@_%@.jpg";
    for (NSMutableDictionary *photo in photos) {
        KVMURLImageView* temp = [[KVMURLImageView alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:photoUrl, [photo objectForKey:@"farm"], [photo objectForKey: @"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]]] andFrame:CGRectMake(0, 50 * i, 50, 50)];
        
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
