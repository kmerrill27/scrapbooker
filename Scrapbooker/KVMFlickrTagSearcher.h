//
//  KVMFlickrTagSearcher.h
//  Flickr
//
//  Created by Kimberly Merrill on 9/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMTagSearcher.h"

@interface KVMFlickrTagSearcher : NSObject <KVMTagSearcher>

@property NSURLConnection* connection;
@property NSMutableData* data;
@property id target;
@property SEL action;

@end
