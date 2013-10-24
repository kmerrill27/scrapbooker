//
//  KVMCameraViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMImagePickerViewController.h"

@interface KVMImagePickerViewController ()

@end

@implementation KVMImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction andCancelAction:(SEL)incomingCancelAction
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.target = incomingTarget;
        self.action = incomingAction;
        self.cancelAction = incomingCancelAction;
    }
    return self;
}

-(void)setSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        self.imagePickerController.sourceType = sourceType;
        self.sourceTypeAvailable = YES;
    }
    else
    {
        self.sourceTypeAvailable = NO;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (tempImage.imageOrientation != UIImageOrientationUp)
    {
        UIGraphicsBeginImageContextWithOptions(tempImage.size, NO, tempImage.scale);
        [tempImage drawInRect:(CGRect){0, 0, tempImage.size}];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    UIImageView* imageView = [[UIImageView alloc] initWithImage:tempImage];
    [self.target performSelector:self.action withObject:imageView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.target performSelector:self.cancelAction];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![self isBeingDismissed] && self.sourceTypeAvailable)
    {
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Source type unavailable on this device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noCameraAlert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
