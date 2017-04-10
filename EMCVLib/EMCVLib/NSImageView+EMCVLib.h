//
//  NSImageView+EMCVLib.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EMCVImage.h"

@interface NSImageView (EMCVLib)

- (void)drawCVImage:(EMCVImage *)cvImg;
- (void)drawAndFitSizeWithCVImage:(EMCVImage *)cvImg;

- (void)setImageAndFitSizeWithImage:(NSImage *)img;

@end
