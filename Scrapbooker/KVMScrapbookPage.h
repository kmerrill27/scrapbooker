//
//  KVMScrapbookPage.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVMScrapbookPage : NSObject

@property int rowid;
@property NSString* photoTitle;
@property NSString* photoDescription;
@property UIImage* photo;
@property NSString* photoPath;

-(id)initWithTitle:(NSString *)myTitle andDescription:(NSString *)myDescription andPhotoPath:(NSString*)myImagePath andID:(int)row;

@end
