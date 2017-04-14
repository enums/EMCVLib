//
//  EMCVVideo.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVVideo.h"
#include "opencv.h"


@implementation EMCVVideo


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
    }
    return self;
}

- (EMCVImage *)nextFrame {
    EMCVImage * img = [[EMCVImage alloc] init];
    _capture.read(img->_mat);
    return img;
}

@end
