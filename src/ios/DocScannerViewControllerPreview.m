// Not used yet
#import "DocScanner.h"
#import "DocScannerViewControllerPreview.h"
#import "IPDFCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewControllerPreview ()

//@property (nonatomic, retain) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

- (IBAction)cancelButton:(id)sender;
- (IBAction)redoButton:(id)sender;
- (IBAction)selectButton:(id)sender;

@end

@implementation ViewControllerPreview

-(void) cancelButton:(id)sender{
    [self.plugin dismissCamera];
}

- (IBAction)selectButton:(id)sender{

    //[self.plugin capturedImageWithPath:imageData];
}

- (IBAction)redoButton:(id)sender{

}


@end
