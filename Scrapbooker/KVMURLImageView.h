//
//  INETImageView.h
//  IImageTest
//
//  Created by Patrick McNally on 9/16/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVMURLImageView : UIImageView <NSURLConnectionDataDelegate>

@property NSURLConnection *connection;
@property NSMutableData *webData;

- (id)initWithURL:(NSURL *)url andFrame:(CGRect)frame;

- (void)requestImage;
- (void)requestImageWithURLFromString:(NSString *)url;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
