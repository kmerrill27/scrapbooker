//
//  KVMAddPageViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMScrapbookPage.h"
#import "KVMSelectPhotoViewController.h"
#import "KVMCropViewController.h"

@interface KVMAddPageViewController : UIViewController

@property IBOutlet UITextField* titleField;
@property IBOutlet UITextField* descriptionField;
@property IBOutlet UIImageView* photoView;
@property UITapGestureRecognizer* tapRecognizer;
@property KVMSelectPhotoViewController* selectPhotoViewController;
@property KVMCropViewController* cropViewController;
@property id target;
@property SEL action;

-(IBAction)selectDidGetPressed:(UIGestureRecognizer*)sender;
-(IBAction)addButtonDidGetPressed:(id)sender;
-(void)didCropImage:(UIImage*)croppedImage;
-(void)clearFields;

@end
