//
//  ViewController.m
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//
#import "DocScanner.h"
#import "ViewController.h"
#import "ViewControllerPreview.h"
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

    [self.cameraViewController setCameraViewType:IPDFCameraViewTypeNormal];
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
    //[self changeButton:sender targetTitle:(enable) ? @"CROP On" : @"CROP Off" toStateEnabled:enable];
    [self changeButton:sender toStateEnabled:!enable]; //This is needed because selected is off.
    self.cameraViewController.enableBorderDetection = enable;
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
        // ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewControllerPreview" bundle:nil];
        // [self presentViewController:vc animated:YES completion:nil];
        // ViewControllerPreview *viewControllerPre = [[ViewControllerPreview alloc] initWithNib:@"ViewControllerPreview" bundle:nil];
        // viewControllerPre.imageData = imageData;
        // [self pushViewController:viewControllerPre animated:YES];
        [self.plugin capturedImageWithPath:imageData];
    }];
}

-(void) dismissButton:(id)sender{
    [self.plugin dismissCamera];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//Not used anymore, still here for users that still want to enable this again.
// - (void)dismissPreview:(UITapGestureRecognizer *)dismissTap
// {
//     [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^
//     {
//         dismissTap.view.frame = CGRectOffset(self.view.bounds, 0, self.view.bounds.size.height);
//     }
//     completion:^(BOOL finished)
//     {
//         [dismissTap.view removeFromSuperview];
//     }];
// }

@end
