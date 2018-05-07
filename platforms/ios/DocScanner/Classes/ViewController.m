//
//  ViewController.m
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//
#import "DocScanner.h"
#import "ViewController.h"
#import "IPDFCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet IPDFCameraViewController *cameraViewController;
@property (weak, nonatomic) IBOutlet UIImageView *focusIndicator;
- (IBAction)focusGesture:(id)sender;

- (IBAction)captureButton:(id)sender;
- (IBAction)dismissButton:(id)sender;

@end

@implementation ViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.cameraViewController setupCameraView];
    [self.cameraViewController setEnableBorderDetection:YES];

    //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterToggle)];
    //singleTap.numberOfTapsRequired = 1;
    //self.titleLabel.userInteractionEnabled = NO;
    //[self.titleLabel addGestureRecognizer:singleTap];

    [self.cameraViewController setCameraViewType:IPDFCameraViewTypeNormal];
    //[self updateTitleLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.cameraViewController start];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark CameraVC Actions

- (IBAction)focusGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint location = [sender locationInView:self.cameraViewController];

        [self focusIndicatorAnimateToPoint:location];

        [self.cameraViewController focusAtPoint:location completionHandler:^
         {
             [self focusIndicatorAnimateToPoint:location];
         }];
    }
}

- (void)focusIndicatorAnimateToPoint:(CGPoint)targetPoint
{
    [self.focusIndicator setCenter:targetPoint];
    self.focusIndicator.alpha = 0.0;
    self.focusIndicator.hidden = NO;

    [UIView animateWithDuration:0.4 animations:^
    {
         self.focusIndicator.alpha = 1.0;
    }
    completion:^(BOOL finished)
    {
         [UIView animateWithDuration:0.4 animations:^
         {
             self.focusIndicator.alpha = 0.0;
         }];
     }];
}

- (IBAction)borderDetectToggle:(id)sender
{
    BOOL enable = !self.cameraViewController.isBorderDetectionEnabled;
//    [self changeButton:sender targetTitle:(enable) ? @"CROP On" : @"CROP Off" toStateEnabled:enable];
    self.cameraViewController.enableBorderDetection = enable;
    //[self updateTitleLabel];
}

- (void)filterToggle
{
    [self.cameraViewController setCameraViewType:IPDFCameraViewTypeNormal];
    //[self updateTitleLabel];
}

- (IBAction)torchToggle:(id)sender
{
    BOOL enable = !self.cameraViewController.isTorchEnabled;
    [self changeButton:sender toStateEnabled:enable];
    self.cameraViewController.enableTorch = enable;
}

- (void)updateTitleLabel
{
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = 0.35;
    [self.titleLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"caret"];
    attachment.bounds = CGRectMake(0, -8, 25, 25);
    NSMutableAttributedString *attachmentString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];

    NSString *filterMode = (self.cameraViewController.cameraViewType != IPDFCameraViewTypeBlackAndWhite) ? @"Color " : @"Grayscale ";

    NSMutableAttributedString *myFilterString= [[NSMutableAttributedString alloc] initWithString:filterMode];

    [myFilterString appendAttributedString:attachmentString];

    self.titleLabel.attributedText = myFilterString;
//    self.titleLabel.text = [filterMode stringByAppendingFormat:@" | %@",(self.cameraViewController.isBorderDetectionEnabled)?@"AUTOCROP On":@"AUTOCROP Off"];
}

- (void)changeButton:(UIButton *)button toStateEnabled:(BOOL)enabled
{
    if(enabled){
        button.selected = YES;
    }else{
        button.selected = NO;
    }
}


#pragma mark -
#pragma mark CameraVC Capture Image

- (IBAction)captureButton:(id)sender
{
//    __weak typeof(self) weakSelf = self;

    [self.cameraViewController captureImageWithCompletionHander:^(NSString *imageFilePath)
    {
//        UIImageView *captureImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
//        captureImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
//        captureImageView.frame = CGRectOffset(self.view.bounds, 0, self.view.bounds.size.height);
//        captureImageView.alpha = 1.0;
//        captureImageView.contentMode = UIViewContentModeScaleAspectFit;
//        captureImageView.userInteractionEnabled = YES;
//        [self.view addSubview:captureImageView];

//        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPreview:)];
//        [captureImageView addGestureRecognizer:dismissTap];
//
//        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^
//        {
//            captureImageView.frame = self.view.bounds;
//        } completion:nil];

        // Get a reference to the captured image
        UIImage* image = [UIImage imageWithContentsOfFile:imageFilePath];


        // Get the image data (blocking; around 1 second)
        NSData* imageData = UIImageJPEGRepresentation(image, 0.8); //NGRepresentation(image);

        // Write the data to the file
        [imageData writeToFile:imageFilePath atomically:YES];


        // Tell the plugin class that we're finished processing the image
        ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController_Preview" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
        //[self.plugin capturedImageWithPath:imageData];
    }];
}

-(void) dismissButton:(id)sender{
    [self.plugin dismissCamera];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dismissPreview:(UITapGestureRecognizer *)dismissTap
{
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^
    {
        dismissTap.view.frame = CGRectOffset(self.view.bounds, 0, self.view.bounds.size.height);
    }
    completion:^(BOOL finished)
    {
        [dismissTap.view removeFromSuperview];
    }];
}

@end
