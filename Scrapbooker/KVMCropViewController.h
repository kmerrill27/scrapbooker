//
//  KVMCropViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMCropRegionView.h"
#import "KVMSelectPhotoViewController.h"

@interface KVMCropViewController : UIViewController

@property id target;
@property SEL action;

@property IBOutlet UIImageView *mainImageView;
@property KVMSelectPhotoViewController *selectPhotoViewController;
@property KVMCropRegionView *cropper;
@property UITapGestureRecognizer *doubleTapRecognizer;
@property UITapGestureRecognizer *mainViewTapRecognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction;
- (void)didPressSelect;
- (void)cropImageAndSendToTarget;
- (void)setImage:(UIImage *)newImage;
-(IBAction)applySepiaFilter:(id)sender;
-(IBAction)applyExposureFilter:(id)sender;
-(IBAction)applyBlueFilter:(id)sender;

@end
