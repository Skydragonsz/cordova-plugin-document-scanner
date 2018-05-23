//
//  OrientationHelper.h
//  IPDFCameraViewControllerDemo
//
//  Created by Damiano Giusti on 26/03/18.
//  Copyright © 2018 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrientationHelper: NSObject

/**
 Creates a new instance of the OrientationHelper.

 @param bundle The main NSBundle instance.
 @return A brand new OrientationHelper
 */
-(instancetype)initWithBundle:(NSBundle*) bundle;

/**
 Tells whether the given UIDeviceOrientation is supported by the application.

 @param orientation UIDeviceOrientation to check.
 @return YES if supported, NO otherwise.
 */
-(BOOL)isCurrentOrientationSupported:(UIDeviceOrientation)orientation;

@end
