//
//  KVMScrapbookPage.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 9/28/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMScrapbookPage.h"

@implementation KVMScrapbookPage

-(id)initWithTitle:(NSString *)myTitle andDescription:(NSString *)myDescription andPhotoPath:(NSString *)myPhotoPath andID:(int)row
{
    self.photoTitle = myTitle;
    self.photoDescription = myDescription;
    self.photo = [[UIImage alloc] initWithContentsOfFile:myPhotoPath];
    self.photoPath = myPhotoPath;
    self.rowid = row;
    return self;
}

@end
