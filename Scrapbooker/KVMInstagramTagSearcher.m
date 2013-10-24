//
//  ISInstagramTagSearcher.m
//  InstaSearch
//
//  Created by Sasha Heinen on 9/18/13.
//  Copyright (c) 2013 William Tachau. All rights reserved.
//

#import "KVMInstagramTagSearcher.h"

@implementation KVMInstagramTagSearcher

- (id) initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super init];
    if (self) {
        NSString *firstWord = [[query componentsSeparatedByString:@" "] objectAtIndex:0];
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=52b557afb1c64d5aa7480bef6c368f3e", firstWord]]] delegate:self];
        self.target = incomingTarget;
        self.action = incomingAction;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [[NSMutableData alloc] initWithCapacity:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    
    [self.target performSelector:self.action withObject:dictionary];
}

@end
