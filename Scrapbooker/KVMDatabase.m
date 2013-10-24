//
//  KVMDatabase.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/5/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMDatabase.h"

@implementation KVMDatabase

static sqlite3 *db;
static sqlite3_stmt *createScrapbookPages;
static sqlite3_stmt *fetchScrapbookPages;
static sqlite3_stmt *insertScrapbookPages;
static sqlite3_stmt *deleteScrapbookPage;

+ (void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"ScrapbookPages.sql"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    // If failed to find one, copy the empty database into the location
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ScrapbookPages.sql"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"FAILED to create writable database file with message, '%@'.", [error localizedDescription]);
    }

}

+ (void)initDatabase
{
    const char *createScrapbookPagesString = "CREATE TABLE IF NOT EXISTS scrapbookPages (rowid INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, photoPath TEXT)";
    const char *fetchScrapbookPagesString = "SELECT * FROM scrapbookPages";
    const char *insertScrapbookPagesString = "INSERT INTO scrapbookPages (title, description, photoPath) VALUES (?, ?, ?)";
    const char *deleteScrapbookPageString = "DELETE FROM scrapbookPages WHERE rowid=?";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"ScrapbookPages.sql"];
    
    if (sqlite3_open([path UTF8String], &db)) {
        NSLog(@"ERROR: failed to open database");
    }
    
    int success;
    
    if (sqlite3_prepare_v2(db, createScrapbookPagesString, -1, &createScrapbookPages, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrapbook pages create table statement");
    }
    
    success = sqlite3_step(createScrapbookPages);
    sqlite3_reset(createScrapbookPages);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to create scrapbook pages table");
    }
    
    if (sqlite3_prepare_v2(db, fetchScrapbookPagesString, -1, &fetchScrapbookPages, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrapbook pages fetch statement");
    }
    
    if (sqlite3_prepare_v2(db, insertScrapbookPagesString, -1, &insertScrapbookPages, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrapbook pages insert statement");
    }
    
    if (sqlite3_prepare_v2(db, deleteScrapbookPageString, -1, &deleteScrapbookPage, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare scrapbook pages delete statement");
    }
}

+ (NSMutableArray *)fetchAllScrapbookPages
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:0];
    
    while (sqlite3_step(fetchScrapbookPages) == SQLITE_ROW) {
        char *titleChars = (char *) sqlite3_column_text(fetchScrapbookPages, 1);
        char *descriptionChars = (char *) sqlite3_column_text(fetchScrapbookPages, 2);
        char *photoPathChars = (char *) sqlite3_column_text(fetchScrapbookPages, 3);
        
        NSString *tempTitle = [NSString stringWithUTF8String:titleChars];
        NSString *tempDescription = [NSString stringWithUTF8String:descriptionChars];
        NSString *tempPhotoPath = [NSString stringWithUTF8String:photoPathChars];
        
        KVMScrapbookPage *temp = [[KVMScrapbookPage alloc] initWithTitle:tempTitle andDescription:tempDescription andPhotoPath:tempPhotoPath andID:sqlite3_column_int(fetchScrapbookPages, 0)];
        [ret addObject:temp];
    }
    
    sqlite3_reset(fetchScrapbookPages);
    return ret;
}

+ (void)saveScrapbookPageWithTitle:(NSString *)photoTitle andDescription:(NSString *)photoDescription andPhoto:(UIImage *)photo
{
    NSString* photoPath = [NSString stringWithFormat:@"%d%d%d.png",     [photoTitle hash], [photoDescription hash], [photo hash]];
    
    // Save photo to file directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedPhotoPath = [documentsDirectory stringByAppendingPathComponent:photoPath];
    NSData *imageData = UIImagePNGRepresentation(photo);
    [imageData writeToFile:savedPhotoPath atomically:NO];
    
    // Bind data to the statement
    sqlite3_bind_text(insertScrapbookPages, 1, [photoTitle UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertScrapbookPages, 2, [photoDescription UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertScrapbookPages, 3, [savedPhotoPath UTF8String], -1, SQLITE_TRANSIENT);
    
    int success = sqlite3_step(insertScrapbookPages);
    sqlite3_reset(insertScrapbookPages);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to insert scrapbook page");
    }
}

+ (void)deleteScrapbookPageWithID:(int)rowid andPhotoPath:(NSString *)photoPath
{
    sqlite3_bind_int(deleteScrapbookPage, 1, rowid);
    int success = sqlite3_step(deleteScrapbookPage);
    sqlite3_reset(deleteScrapbookPage);
    
    // Remove image from file directoy
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:photoPath error:&error];
    
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to delete scrapbook page");
    }
}

+ (void)cleanUpDatabaseForQuit
{
    // Finalize frees the compiled statements, close closes the database connection
    sqlite3_finalize(fetchScrapbookPages);
    sqlite3_finalize(insertScrapbookPages);
    sqlite3_finalize(deleteScrapbookPage);
    sqlite3_finalize(createScrapbookPages);
    sqlite3_close(db);
}

@end
