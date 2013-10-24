//
//  KVMFlickrTagSearcher.m
//  Flickr
//
//  Created by Kimberly Merrill on 9/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMFlickrTagSearcher.h"

@implementation KVMFlickrTagSearcher

- (id) initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super init];
    if (self) {
        NSString *firstWord = [[query componentsSeparatedByString:@" "] objectAtIndex:0];
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=0597b605a069e04f931458f4c7c17dda&tags=%@&per_page=20&format=json&nojsoncallback=1", firstWord]]] delegate:self];
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
