//
//  KVMSelectPhotoViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/29/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMSelectPhotoViewController.h"

@interface KVMSelectPhotoViewController ()

@end

@implementation KVMSelectPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 170,44)];
        [self.searchBar setTintColor:[UIColor colorWithRed:48.0/255.0 green:36.0/255.0 blue:30.0/255.0 alpha:1.0]];
        self.searchBar.delegate = self;
        self.navigationItem.titleView = self.searchBar;

        self.instagramViewController = [[KVMInstagramViewController alloc] initWithNibName:@"KVMInstagramViewController" bundle:nil andTarget:self andAction:@selector(handlePhoto:)];
        self.instagramViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Instagram" image:[UIImage imageNamed:@"paper-message.png"] tag:0];
        
        self.flickrViewController = [[KVMFlickrViewController alloc] initWithNibName:@"KVMFlickrViewController" bundle:nil andTarget:self andAction:@selector(handlePhoto:)];
        self.flickrViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Flickr" image:[UIImage imageNamed:@"photo.png"] tag:1];

        self.photoLibraryViewController = [[KVMImagePickerViewController alloc] initWithNibName:@"KVMCameraViewController" bundle:nil andTarget:self andAction:@selector(handlePhoto:) andCancelAction:@selector(navigateFromCamera)];
        self.photoLibraryViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Library" image:[UIImage imageNamed:@"bookmark.png"] tag:2];
        [self.photoLibraryViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

        self.cameraViewController = [[KVMImagePickerViewController alloc] initWithNibName:@"KVMCameraViewController" bundle:nil andTarget:self andAction:@selector(handlePhoto:) andCancelAction:@selector(navigateFromCamera)];
         self.cameraViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Camera" image:[UIImage imageNamed:@"camera.png"] tag:3];
        [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];

        [self setViewControllers:[NSArray arrayWithObjects:self.instagramViewController, self.flickrViewController, self.photoLibraryViewController, self.cameraViewController, nil] animated:YES];

        self.target = incomingTarget;
        self.action = incomingAction;
    }
    return self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.selectedViewController performSelector:@selector(searchForPhoto:) withObject:[searchBar text]];
}

-(void)handlePhoto:(UIImageView *)imageView
{
    [self.target performSelector:self.action withObject:[imageView image]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigateFromCamera
{
    [self setSelectedViewController:self.instagramViewController];
}

-(void)clearSearch
{
    [self.searchBar setText:@""];
    [self.instagramViewController clearSearch];
    [self.flickrViewController clearSearch];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setTintColor:[UIColor colorWithRed:48.0/255.0 green:36.0/255.0 blue:30.0/255.0 alpha:1.0]];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:255.0/255.0 green:229.0/255.0 blue:182.0/255.0 alpha:1.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
