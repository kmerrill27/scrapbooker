//
//  KVMCameraViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVMImagePickerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property id target;
@property SEL action;
@property SEL cancelAction;
@property BOOL sourceTypeAvailable;
@property UIImagePickerController* imagePickerController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction andCancelAction:(SEL)incomingCancelAction;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
-(void)setSourceType:(UIImagePickerControllerSourceType)sourceType;

@end
