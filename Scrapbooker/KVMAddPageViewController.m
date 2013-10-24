//
//  KVMAddPageViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMAddPageViewController.h"

@interface KVMAddPageViewController ()

@end

@implementation KVMAddPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setTitle:@"Add Photo"];
        self.cropViewController = [[KVMCropViewController alloc] initWithNibName:nil bundle:nil andTarget:self andAction:@selector(didCropImage:)];
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDidGetPressed:)];
        self.tapRecognizer.numberOfTapsRequired = 1;
    }
    return self;
}

-(void)didCropImage:(UIImage*)croppedImage {
    [self.photoView setImage:croppedImage];
}

-(IBAction)selectDidGetPressed:(UIGestureRecognizer*)sender
{
    if (self.photoView.image == [UIImage imageNamed:@"polaroid.png"])
    {
        [self.cropViewController setImage:[UIImage imageNamed:@"polaroid.png"]];
    }
    [self.navigationController pushViewController:self.cropViewController animated:YES];
}

-(IBAction)addButtonDidGetPressed:(id)sender
{
    // Scrapbook page must have an image in order to be saved
    if (self.photoView.image != [UIImage imageNamed:@"polaroid.png"]) {
        NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.titleField.text, self.descriptionField.text, self.photoView.image, nil] forKeys:[NSArray arrayWithObjects:@"title", @"description", @"photo", nil]];
        [self.target performSelector:self.action withObject:temp];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)clearFields
{
    [self.titleField setText:@""];
    [self.descriptionField setText:@""];
    [self.photoView setImage:[UIImage imageNamed:@"polaroid.png"]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.titleField.isFirstResponder) {
        [self.titleField resignFirstResponder];
    }
    if (self.descriptionField.isFirstResponder) {
        [self.descriptionField resignFirstResponder];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.photoView addGestureRecognizer:self.tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
