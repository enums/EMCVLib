//
//  EMCVVideoCapture.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVVideoCapture.h"
#include "opencv.h"


@implementation EMCVVideoCapture


- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        _capture = VideoCapture([path UTF8String]);
    }
    return self;
}

- (instancetype)initWithDevice:(int)device {
    self = [super init];
    if (self) {
        _capture = VideoCapture(device);
        _size = NSMakeSize(_capture.get(CV_CAP_PROP_FRAME_WIDTH), _capture.get(CV_CAP_PROP_FRAME_HEIGHT));
        _frameRate = _capture.get(CV_CAP_PROP_FPS);
        _frameCount = _capture.get(CV_CAP_PROP_FRAME_COUNT);
    }
    return self;
}

- (EMCVImage *)nextFrame {
    EMCVImage * img = [[EMCVImage alloc] init];
    _capture.read(img->_mat);
    return img;
}

@end
