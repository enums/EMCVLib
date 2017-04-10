//
//  OneViewController.m
//  EMCVLibDemo
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "OneViewController.h"
#import "opencv_c.h"
#import <EMCVLib/EMCVLib.h>

@interface OneViewController ()

@property (weak) IBOutlet NSImageView *imageView;

@property (nonatomic) EMCVImage * curImage;

@end

@implementation OneViewController

- (void)setCurImage:(EMCVImage *)curImage {
    _curImage = curImage;
    if (curImage != nil) {
        [self.imageView drawCVImage:curImage];
    } else {
        [self.imageView setImage: nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)showImage:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            NSURL * url = panel.URLs[0];
            NSString * path = [url.absoluteString substringFromIndex:7];
            EMCVImage * img = [[EMCVImage alloc] initWithPath:path];
            [img cvtColor:CV_BGR2RGB];
            self.curImage = img;
        }
    }];
}

@end
