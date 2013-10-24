//
//  CropRegionView.h
//  ImageEditor
//
//  Created by Patrick McNally on 10/8/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVMCropRegionView : UIView

@property UIImageView *parentView;
@property CGRect imageBoundsInView;

- (void)checkBounds;
- (CGRect)cropBounds;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end
