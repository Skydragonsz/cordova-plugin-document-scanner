//
//  ViewController.h
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerPreview.h"
@class DocScanner;
@interface ViewController : UIViewController

@property (strong, nonatomic) DocScanner* plugin;
@end
