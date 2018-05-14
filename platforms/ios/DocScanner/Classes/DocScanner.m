#import "DocScanner.h"

#ifndef __CORDOVA_4_0_0
#import <Cordova/NSData+Base64.h>
#endif

#define CDV_PHOTO_PREFIX @"cdv_photo_"

static NSString* toBase64(NSData* theData) {
  const uint8_t* input = (const uint8_t*)[theData bytes];
  NSInteger length = [theData length];

  static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

  NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
  uint8_t* output = (uint8_t*)data.mutableBytes;

  NSInteger i;
  for (i=0; i < length; i += 3) {
    NSInteger value = 0;
    NSInteger j;
    for (j = i; j < (i + 3); j++) {
      value <<= 8;

      if (j < length) {
        value |= (0xFF & input[j]);
      }
    }

    NSInteger theIndex = (i / 3) * 4;
    output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
    output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
    output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
    output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
  }

  return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@implementation ImageOptions

+ (instancetype) setImageOptions:(CDVInvokedUrlCommand*)command
{
    ImageOptions* pictureOptions = [[ImageOptions alloc] init];

    pictureOptions.quality = [command argumentAtIndex:0 withDefault:@(80)];

    pictureOptions.targetWidth = [command argumentAtIndex:1 withDefault:@(0)];
    pictureOptions.targetHeight = [command argumentAtIndex:2 withDefault:@(0)];


    pictureOptions.correctOrientation = [[command argumentAtIndex:3 withDefault:@(NO)] boolValue];

    return pictureOptions;
}

@end

@implementation DocScanner

// Cordova command method
-(void) takePicture:(CDVInvokedUrlCommand *)command {
    NSLog(@"Initialized DocScanner");

    // Set the hasPendingOperation field to prevent the webview from crashing
    self.hasPendingOperation = YES;
    __weak DocScanner* weakSelf = self;
    // Save the CDVInvokedUrlCommand as a property.  We will need it later.
    weakSelf.latestCommand = command;

    weakSelf.options = [ImageOptions setImageOptions:command];

    // Make the overlay view controller.
//    self.overlay = [[ViewController alloc] initWithNibName:@"Main" bundle:nil];
    weakSelf.overlay = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController_Camera"];
//    [self presentViewController:self.overlay animated:YES completion:nil];
    weakSelf.overlay.plugin = self;

    // Display the view.  This will "slide up" a modal view from the bottom of the screen.
    [weakSelf.viewController presentViewController:self.overlay animated:YES completion:nil];
}

-(void)dismissCamera{
    __weak DocScanner* weakSelf = self;
    [weakSelf.overlay dismissViewControllerAnimated:YES completion:nil];
}
-(void) captureImageWithFilePath:(NSString*)imagePath{

     [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imagePath] callbackId:self.latestCommand.callbackId];

    // Unset the self.hasPendingOperation property
    self.hasPendingOperation = NO;

    // Hide the picker view
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

// // Method called by the overlay when the image is ready to be sent back to the web view
 -(void) capturedImageWithPath:(NSData*)imageData {
     [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:toBase64(imageData)] callbackId:self.latestCommand.callbackId];

     // Unset the self.hasPendingOperation property
     self.hasPendingOperation = NO;

     // Hide the picker view
     [self.viewController dismissViewControllerAnimated:YES completion:nil];
 }

@end
