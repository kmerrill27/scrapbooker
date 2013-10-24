//
//  ISInstagramTagSearcher.h
//  InstaSearch
//
//  Created by Sasha Heinen on 9/18/13.
//  Copyright (c) 2013 William Tachau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVMTagSearcher.h"

@interface KVMInstagramTagSearcher : NSObject <KVMTagSearcher>

@property NSURLConnection* connection;
@property NSMutableData* data;
@property id target;
@property SEL action;

@end
