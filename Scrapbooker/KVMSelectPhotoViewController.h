//
//  KVMSelectPhotoViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/29/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVMInstagramViewController.h"
#import "KVMFlickrViewController.h"
#import "KVMImagePickerViewController.h"
#import "KVMURLImageView.h"

@interface KVMSelectPhotoViewController : UITabBarController<UISearchBarDelegate>

@property UISearchBar* searchBar;
@property KVMInstagramViewController* instagramViewController;
@property KVMFlickrViewController* flickrViewController;
@property KVMImagePickerViewController* cameraViewController;
@property KVMImagePickerViewController* photoLibraryViewController;
@property id target;
@property SEL action;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
-(void)clearSearch;
-(void)navigateFromCamera;

@end
