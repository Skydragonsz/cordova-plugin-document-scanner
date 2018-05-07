#import "DocScanner.h"
#import "ViewController_Preview.h"
#import "IPDFCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController_Preview ()

@property (nonatomic, retain) NSString *imageData;
- (IBAction)selectButton:(id)sender;

- (IBAction)redoButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end

@implementation ViewController_Preview

-(void) cancelButton:(id)sender{
    [self.plugin dismissCamera];
}
@end
