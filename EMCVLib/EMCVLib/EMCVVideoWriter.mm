//
//  EMCVVideoWriter.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/5/18.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVVideoWriter.h"
#import "Static.h"

static int _getFormatWithIndex(int index) {
    if (index == kEMCVLibVideoWriterFormatMJPG) {
        return CV_FOURCC('M', 'J', 'P', 'G');
    } else if (index == kEMCVLibVideoWriterFormatFLV1) {
        return CV_FOURCC('F', 'L', 'V', '1');
    } else {
        return -1;
    }
}

@implementation EMCVVideoWriter

- (instancetype)initWithPath:(NSString *)path frameRate:(int)frameRate size:(NSSize)size outputFormat:(int)format {
    int _format = _getFormatWithIndex(format);
    if (_format == -1) {
        return nil;
    }
    self = [super init];
    if (self) {
        _writer = VideoWriter([path UTF8String], _format, frameRate, cv::Size(size.width, size.height));
        _size = size;
        _frameRate = frameRate;
    }
    return self;
}

- (void)writeFrame:(EMCVBasicImage *)img {
    _writer.write(img->_mat);
}


@end
