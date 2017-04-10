//
//  EMCVImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVImage.h"
#include "opencv.h"

using namespace cv;

@interface EMCVImage() {
    
}

@end

@implementation EMCVImage {
    
}


- (instancetype)initWithPath:(NSString *)path {
    const char * imagePath = [path UTF8String];
    Mat mat = imread(imagePath);
    return [self initWithMat: mat];
}

- (instancetype)initWithCVImage:(EMCVImage *)img {
    return [self initWithMat:img->_mat];
}

- (instancetype)initWithCVImage:(EMCVImage *)img cvtColor:(int)color {
    return [self initWithMat:img->_mat cvtColor:color];
}

- (instancetype)initWithMat:(Mat)mat cvtColor:(int)color {
    Mat newMat;
    cvtColor(mat, newMat, color);
    return [self initWithNoCopyMat:newMat];
}

- (instancetype)initWithMat:(Mat)mat {
    Mat newMat;
    mat.copyTo(newMat);
    return [self initWithNoCopyMat:newMat];
}

- (instancetype)initWithNoCopyMat:(Mat)mat {
    self = [super init];
    if (self) {
        self->_mat = mat;
    }
    return self;
}

- (void)cvtColor:(int)code {
    cvtColor(_mat, _mat, code);
}

- (NSImage *)toImage {
    NSImage *image = [[NSImage alloc] init];
    @autoreleasepool {
        NSData *data = [NSData dataWithBytes:_mat.data length:_mat.elemSize() * _mat.total()];
        CGColorSpaceRef colorSpace;
        if (_mat.elemSize() == 1) {
            colorSpace = CGColorSpaceCreateDeviceGray();
        } else {
            colorSpace = CGColorSpaceCreateDeviceRGB();
        }
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
        CGImageRef imageRef = CGImageCreate(_mat.cols, _mat.rows, 8, 8 * _mat.elemSize(), _mat.step[0], colorSpace, kCGImageAlphaNone | kCGBitmapByteOrderDefault, provider, NULL, false, kCGRenderingIntentDefault);
        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:imageRef];
        [image addRepresentation:bitmapRep];
        CGImageRelease(imageRef);
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpace);
    }
    return image;
}

@end
