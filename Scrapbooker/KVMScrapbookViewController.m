//
//  KVMScrapbookViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMScrapbookViewController.h"

@interface KVMScrapbookViewController ()

@end

@implementation KVMScrapbookViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.pages = [KVMDatabase fetchAllScrapbookPages];
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        self.pageDetailViewController = [[KVMPageDetailViewController alloc] initWithNibName:@"KVMPageDetailViewController" bundle:nil];
        self.addPageViewController = [[KVMAddPageViewController alloc] initWithNibName:@"KVMAddPageViewController" bundle:nil];
        self.addPageViewController.target = self;
        self.addPageViewController.action = @selector(addPage:);
        
    }
    return self;
}

-(void)addPage:(NSMutableDictionary *)data
{
    [KVMDatabase saveScrapbookPageWithTitle:[data objectForKey:@"title"] andDescription:[data objectForKey:@"description"] andPhoto:[data objectForKey:@"photo"]];
    self.pages = [KVMDatabase fetchAllScrapbookPages];
    [self.tableView reloadData];
}

- (void)addButtonPressed
{
    [self.addPageViewController clearFields];
    [self.navigationController pushViewController:self.addPageViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:229.0/255.0 blue:182.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    KVMScrapbookPage* tempPage = [self.pages objectAtIndex:indexPath.row];
    [[cell textLabel] setText:tempPage.photoTitle];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    cell.textLabel.textColor = [UIColor colorWithRed:48.0/255.0 green:36.0/255.0 blue:30.0/255.0 alpha:1.0];
    cell.imageView.image = [tempPage photo];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        KVMScrapbookPage *pageToDelete = [self.pages objectAtIndex:indexPath.row];
        [KVMDatabase deleteScrapbookPageWithID:[pageToDelete rowid] andPhotoPath:[pageToDelete photoPath]];
        self.pages = [KVMDatabase fetchAllScrapbookPages];
        [self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KVMScrapbookPage* tempPage = [self.pages objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:self.pageDetailViewController animated:YES];
    [self.pageDetailViewController setFieldsWithTitle:tempPage.photoTitle andDescription:tempPage.photoDescription andPhoto:tempPage.photo];
}

@end
