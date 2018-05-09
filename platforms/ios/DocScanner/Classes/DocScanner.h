#import <Cordova/CDV.h>

#import "ViewController.h"

@interface DocScanner : CDVPlugin

// Cordova command method
-(void) takePicture:(CDVInvokedUrlCommand*)command;

// Create and override some properties and methods (these will be explained later)
-(void) capturedImageWithPath:(NSData*)imageData;
-(void) captureImageWithFilePath:(NSString*)imagePath;
-(void) dismissCamera;
@property (strong, nonatomic) ViewController* overlay;
@property (strong, nonatomic) CDVInvokedUrlCommand* latestCommand;
@property (readwrite, assign) BOOL hasPendingOperation;

@end
