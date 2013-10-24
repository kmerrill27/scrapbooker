//
//  KVMDatabase.h
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/5/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "KVMScrapbookPage.h"

@interface KVMDatabase : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded;
+ (void)initDatabase;
+ (NSMutableArray *)fetchAllScrapbookPages;
+ (void)saveScrapbookPageWithTitle:(NSString *)photoTitle andDescription:(NSString *)photoDescription andPhoto:(UIImage *)photo;
+ (void)deleteScrapbookPageWithID:(int)rowid andPhotoPath:(NSString *)photoPath;
+ (void)cleanUpDatabaseForQuit;

@end
