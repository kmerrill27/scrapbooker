//
//  KVMPageDetailViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMPageDetailViewController.h"

@interface KVMPageDetailViewController ()

@end

@implementation KVMPageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setTitle:@"View Photo"];
    }
    return self;
}

-(void)setFieldsWithTitle:(NSString *)newTitle andDescription:(NSString *)newDescription andPhoto:(UIImage *)newPhoto
{
    [self.detailTitle setText:newTitle];
    [self.detailDescription setText:newDescription];
    [self.detailPhoto setImage:newPhoto];
}

-(IBAction)didPressTwitterButton:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [composeViewController setInitialText:[self.detailTitle text]];
        [composeViewController addImage:[self.detailPhoto image]];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *noTwitterAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Twitter unavailable on device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noTwitterAlert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
