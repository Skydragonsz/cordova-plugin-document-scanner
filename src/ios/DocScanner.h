#import <Cordova/CDV.h>

#import "DocScannerViewControllerMain.h"

@interface ImageOptions : NSObject

@property (strong) NSNumber* quality;
@property (strong) NSNumber* targetWidth;
@property (strong) NSNumber* targetHeight;
@property (assign) BOOL toBase64;
@property (assign) BOOL saveToPhotoAlbum;


+ (instancetype) setImageOptions:(CDVInvokedUrlCommand*)command;

@end

@interface DocScanner : CDVPlugin

// Cordova command method
-(void) takePicture:(CDVInvokedUrlCommand*)command;

// Create and override some properties and methods (these will be explained later)
-(void) capturedImageWithPath:(NSData*)imageData;
-(void) captureImageWithFilePath:(NSString*)imagePath;
-(void) dismissCamera;
@property (strong, nonatomic) ViewController* overlay;
@property (strong, nonatomic) CDVInvokedUrlCommand* latestCommand;
@property (strong, nonatomic) ImageOptions* options;
@property (readwrite, assign) BOOL hasPendingOperation;

@end
