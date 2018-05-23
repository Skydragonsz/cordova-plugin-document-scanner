//
//  OrientationHelper.m
//  IPDFCameraViewControllerDemo
//
//  Created by Damiano Giusti on 26/03/18.
//  Copyright © 2018 Maximilian Mackh. All rights reserved.
//

#import "OrientationHelper.h"

@interface OrientationHelper()

@property (nonatomic, strong) NSArray* _Nonnull supportedOrientations;

@end

@implementation OrientationHelper

-(instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    self.supportedOrientations = [[bundle infoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
    return self;
}

-(BOOL)isCurrentOrientationSupported:(UIDeviceOrientation)orientation {
    NSString* description = [self deviceOrientationString:orientation];
    return [self.supportedOrientations containsObject:description];
}

#pragma mark Private methods

- (NSString *)deviceOrientationString:(UIDeviceOrientation)orientation {
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            return @"UIInterfaceOrientationPortrait";
        case UIDeviceOrientationPortraitUpsideDown:
            return @"UIInterfaceOrientationPortraitUpsideDown";
        case UIDeviceOrientationLandscapeLeft:
            return @"UIInterfaceOrientationLandscapeLeft";
        case UIDeviceOrientationLandscapeRight:
            return @"UIInterfaceOrientationLandscapeRight";
        default:
            return @"Invalid Interface Orientation";
    }
}

@end
