//
//  KVMPageDetailViewController.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface KVMPageDetailViewController : UIViewController

@property IBOutlet UILabel *detailTitle;
@property IBOutlet UILabel *detailDescription;
@property IBOutlet UIImageView *detailPhoto;

-(void)setFieldsWithTitle:(NSString *)newTitle andDescription:(NSString *)newDescription andPhoto:(UIImage *)newPhoto;
-(IBAction)didPressTwitterButton:(id)sender;

@end
