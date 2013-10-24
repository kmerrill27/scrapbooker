//
//  KVMCropViewController.m
//  Scrapbooker
//
//  Created by Kimberly Merrill on 10/22/13.
//  Copyright (c) 2013 kmerrill27. All rights reserved.
//

#import "KVMCropViewController.h"

@interface KVMCropViewController ()

@end

@implementation KVMCropViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(id)incomingTarget andAction:(SEL)incomingAction
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setTitle:@"Edit Photo"];
        self.target = incomingTarget;
        self.action = incomingAction;

        self.selectPhotoViewController = [[KVMSelectPhotoViewController alloc] initWithNibName:@"KVMSelectPhotoViewController" bundle:nil andTarget:self andAction:@selector(setImage:)];
    }
    return self;
}

- (void)setImage:(UIImage *)newImage
{
    [self.mainImageView setImage:newImage];
    
    CGFloat inViewImageHeight;
    CGFloat inViewImageWidth;
    
    if (newImage.size.height > newImage.size.width) {
        inViewImageHeight = self.mainImageView.frame.size.height;
        inViewImageWidth = (inViewImageHeight/newImage.size.height) * newImage.size.width;
    } else {
        inViewImageWidth = self.mainImageView.frame.size.width;
        inViewImageHeight = (inViewImageWidth/newImage.size.width) * newImage.size.height;
    }
    
    CGFloat minX = (self.mainImageView.frame.size.width - inViewImageWidth)/2;
    CGFloat minY = (self.mainImageView.frame.size.height - inViewImageHeight)/2;
    
    self.cropper.imageBoundsInView = CGRectMake(minX, minY, inViewImageWidth, inViewImageHeight);
    [self.cropper checkBounds];
}

- (void)didPressSelect
{
    [self.navigationController pushViewController:self.selectPhotoViewController animated:YES];
}

- (void)cropImageAndSendToTarget
{
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(self.mainImageView.image.CGImage, [self.cropper cropBounds]);
    UIImage *temp = [UIImage imageWithCGImage:croppedCGImage];
    UIGraphicsBeginImageContext(CGSizeMake(300.0, 300.0));
    [temp drawInRect:CGRectMake(0, 0, 300, 300)];
    UIImage *croppedUIImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(croppedCGImage);

    [self.target performSelector:self.action withObject:croppedUIImage];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.mainImageView image] == [UIImage imageNamed:@"polaroid.png"])
    {
        [self.cropper setHidden:YES];
        [self.doubleTapRecognizer setEnabled:NO];
        [self.selectPhotoViewController clearSearch];
    }
    else
    {
        [self.cropper setHidden:NO];
        [self.doubleTapRecognizer setEnabled:YES];
    }
}

-(IBAction)applySepiaFilter:(id)sender
{
    if ([self.mainImageView image] != [UIImage imageNamed:@"polaroid.png"])
    {
        CIImage *beginImage = [CIImage imageWithCGImage:[self.mainImageView.image CGImage]];
        CIContext *context = [CIContext contextWithOptions:nil];

        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
        CIImage *outputImage = [filter outputImage];

        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImg = [UIImage imageWithCGImage:cgimg];

        [self.mainImageView setImage:newImg];

        CGImageRelease(cgimg);
    }
}

-(IBAction)applyExposureFilter:(id)sender
{
    if ([self.mainImageView image] != [UIImage imageNamed:@"polaroid.png"])
    {
        CIImage *beginImage = [CIImage imageWithCGImage:[self.mainImageView.image CGImage]];
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIFilter *expAdjust = [CIFilter filterWithName:@"CIExposureAdjust"];
        [expAdjust setValue: beginImage forKey: @"inputImage"];
        [expAdjust setValue: [NSNumber numberWithFloat: 2.0f] forKey: @"inputEV"];
        CIImage* outputImage = [expAdjust outputImage];
        
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImg = [UIImage imageWithCGImage:cgimg];
        [self.mainImageView setImage:newImg];

        CGImageRelease(cgimg);
    }
}

-(IBAction)applyBlueFilter:(id)sender
{
    if ([self.mainImageView image] != [UIImage imageNamed:@"polaroid.png"])
    {
        CIImage *beginImage = [CIImage imageWithCGImage:[self.mainImageView.image CGImage]];
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIFilter *filter =[CIFilter filterWithName:@"CIColorMonochrome"];
        [filter setValue: beginImage forKey: @"inputImage"];
        [filter setValue:[CIColor colorWithRed:0.0f green:0.3f blue:1.0f alpha:1.0f]
                           forKey: @"inputColor"];
        CIImage *tempImage = [filter outputImage];
        
        CIFilter *expFilter = [CIFilter filterWithName:@"CIVibrance" keysAndValues:kCIInputImageKey, tempImage, @"inputAmount", [NSNumber numberWithFloat:0.8], nil];
        CIImage *outputImage = [expFilter outputImage];

        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImg = [UIImage imageWithCGImage:cgimg];
        
        [self.mainImageView setImage:newImg];
        
        CGImageRelease(cgimg);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cropper = [[KVMCropRegionView alloc] initWithFrame:CGRectMake(130, 130, 130, 130)];
    self.cropper.parentView = self.mainImageView;
    [self.mainImageView addSubview:self.cropper];
    
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cropImageAndSendToTarget)];
    [self.doubleTapRecognizer setNumberOfTapsRequired:2];
    [self.cropper addGestureRecognizer:self.doubleTapRecognizer];

    self.mainViewTapRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressSelect)];
    [self.mainViewTapRecognizer setNumberOfTapsRequired:1];
    [self.mainViewTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
    [self.mainImageView addGestureRecognizer:self.mainViewTapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
