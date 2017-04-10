//
//  NSImageView+EMCVLib.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "NSImageView+EMCVLib.h"

@implementation NSImageView (EMCVLib)

- (void)drawCVImage:(EMCVImage *)cvImg {
    NSImage * img = [cvImg toImage];
    [self setImage:img];
}

- (void)drawAndFitSizeWithCVImage:(EMCVImage *)cvImg {
    NSImage * img = [cvImg toImage];
    [self setImageAndFitSizeWithImage:img];
}

- (void)setImageAndFitSizeWithImage:(NSImage *)img {
    @autoreleasepool {
        NSSize size = self.frame.size;
        NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
        NSImage * targetImage = [[NSImage alloc] initWithSize:size];
        NSSize sourceSize = img.size;
        
        CGFloat ratioH = size.height / sourceSize.height;
        CGFloat ratioW = size.width / sourceSize.width;
        
        NSRect cropRect = NSMakeRect(0, 0, 0, 0);
        
        if (ratioH >= ratioW) {
            cropRect.size.width = floor(size.width / ratioH);
            cropRect.size.height = sourceSize.height;
        } else {
            cropRect.size.width = sourceSize.width;
            cropRect.size.height = floor(size.height / ratioW);
        }
        
        cropRect.origin.x = floor((sourceSize.width - cropRect.size.width) / 2);
        cropRect.origin.y = floor((sourceSize.height - cropRect.size.height) / 2);
        
        [targetImage lockFocus];
        [img drawInRect:targetFrame fromRect:cropRect operation:NSCompositingOperationCopy fraction:1.0 respectFlipped:YES hints:@{NSImageHintInterpolation: [NSNumber numberWithInt:NSImageInterpolationLow]}];
        [targetImage unlockFocus];
        
        [self setImage:targetImage];
    }
}


@end
