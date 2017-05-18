//
//  EMCVVideoWriter.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/5/18.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"
#import "EMCVBasicImage.h"

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVVideoWriter : NSObject
#ifdef __cplusplus
{
@public
    VideoWriter _writer;
}
#endif

@property (nonatomic, assign) NSSize size;
@property (nonatomic, assign) int frameRate;

- (instancetype)initWithPath:(NSString *)path frameRate:(int)frameRate size:(NSSize)size outputFormat:(int)format;
- (void)writeFrame:(EMCVBasicImage *)img;

@end
