//
//  EMCVImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVImage.h"
#include "opencv.h"


@interface EMCVImage() {
    
}

@end

@implementation EMCVImage {
    
}

- (NSUInteger)channalCount {
    return (NSUInteger)self->_mat.elemSize();
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

- (instancetype)initWithSplitedImage:(EMCVSplitedImage *)splitedImage {
    Mat mat;
    merge(splitedImage->_mats, mat);
    return [self initWithNoCopyMat:mat];
}

- (instancetype)initWithNoCopyMat:(Mat)mat {
    self = [super init];
    if (self) {
        self->_mat = mat;
    }
    return self;
}

- (EMCVSplitedImage *)splitImage {
    return [[EMCVSplitedImage alloc] initWithCVImage:self];
}

- (void)gaussianBlurWithSize:(NSSize)size {
    GaussianBlur(_mat, _mat, cv::Size(size.width, size.height), 0);
}

- (void)drawARectWithCenter:(NSPoint)center size:(NSSize)size rgbColor:(int *)rgb thickness:(int)thickness {
    NSRect rect = NSMakeRect(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
    [self drawARect:rect rgbColor:rgb thickness:thickness];
}


- (void)drawARect:(NSRect)rect rgbColor:(int *)rgb thickness:(int)thickness {
    int x = (int)rect.origin.x;
    int y = (int)rect.origin.y;
    int w = (int)rect.size.width;
    int h = (int)rect.size.height;
    cv::Point pt1 = cv::Point(x, y);
    cv::Point pt2 = cv::Point(x + w, y + h);
    rectangle(_mat, pt1, pt2, Scalar(rgb[0], rgb[1], rgb[2]), thickness);
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


- (void)calHistWithDims:(int)dims size:(int)size range:(float *)range {
    int * sizes = new int[dims];
    float ** ranges = new float * [dims];
    for (int i = 0; i < dims; i++) {
        sizes[i] = size;
        ranges[i] = range;
    }
    [self calHistWithDims:dims sizes:sizes ranges:ranges];
    delete[] sizes;
    delete[] ranges;
}

- (void)calHistWithDims:(int)dims sizes:(int *)sizes ranges:(float **)ranges {
    const int channels[] = {0, 1, 2, 3};
    calcHist(&_mat, 1, channels, Mat(), _hist, dims, sizes, (const float **)ranges);
}

- (void)normalizeHistWithValue:(double)value  {
    normalize(_hist, _hist, 0, value, NORM_MINMAX, -1, Mat());
}

@end
