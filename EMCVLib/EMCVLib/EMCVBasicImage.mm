//
//  EMCVBasicImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/17.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVBasicImage.h"
#import "Static.h"

@implementation EMCVBasicImage

- (NSUInteger)channalCount {
    return (NSUInteger)_mat.channels();
}

- (NSSize)imageSize {
    return NSMakeSize(_mat.cols, _mat.rows);
}

- (instancetype)initWithSize:(NSSize)size andType:(int)type andColor:(int *)rgb {
    Mat mat = Mat(size.height, size.width, type, Scalar(rgb[0], rgb[1], rgb[2]));
    return [self initWithNoCopyMat:mat];
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

- (EMCVBasicImage *)makeACopy {
    return [[EMCVBasicImage alloc] initWithMat:_mat];
}

- (void)cvtColor:(int)code {
    cvtColor(_mat, _mat, code);
}

- (void)forEachPixelWithBlock:(void(^)(int, int, unsigned char *))block {
    for (int y = 0; y < _mat.rows; y++) {
        for (int x = 0; x < _mat.cols; x++) {
            [self forEachPixelAtX:x andY:y withBlock:block];
        }
    }
}

- (void)forEachPixelAtX:(int)x andY:(int)y withBlock:(void(^)(int, int, unsigned char *))block {
    unsigned char * ptr = _mat.ptr(y, x);
    block(x, y, ptr);
}


- (void)flipWithXAxis {
    flip(_mat, _mat, 1);
}

- (void)flipWithYAxis {
    flip(_mat, _mat, -1);
}
- (void)drawALineWithPoint:(NSPoint)p1 andPoint:(NSPoint)p2 andColor:(int *)rgb andThickness:(int)thickness {
    line(_mat, cv::Point(p1.x, p1.y), cv::Point(p2.x, p2.y), Scalar(rgb[0], rgb[1], rgb[2]), thickness);
}

- (void)drawARectWithCenter:(NSPoint)center size:(NSSize)size rgbColor:(int *)rgb thickness:(int)thickness {
    NSRect rect = NSMakeRect(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
    [self drawARect:rect rgbColor:rgb thickness:thickness];
}

- (void)drawACircleWithCenter:(NSPoint)center andRadius:(int)radius andColor:(int *)rgb andThickness:(int)thickness {
    circle(_mat, cv::Point(center.x, center.y), radius, Scalar(rgb[0], rgb[1], rgb[2]), thickness);
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


- (void)normalizeImageWithValue:(double)value  {
    normalize(_mat, _mat, 0, value, NORM_MINMAX, -1, Mat());
}
- (void)normalizeHistWithValue:(double)value  {
    normalize(_hist, _hist, 0, value, NORM_MINMAX, -1, Mat());
}


- (void)pyrUpWithRatio:(double)ratio {
    NSSize size = self.imageSize;
    pyrUp(_mat, _mat, cv::Size(size.width * ratio, size.height * ratio));
}

- (void)pyrDownWithRatio:(double)ratio {
    NSSize size = self.imageSize;
    pyrDown(_mat, _mat, cv::Size(size.width * ratio, size.height * ratio));
}


- (void)setBrightness:(double)brightness {
    _mat.convertTo(_mat, -1, 1, brightness);
}



- (void)blurWithSize:(NSSize)size {
    blur(_mat, _mat, cv::Size(size.width, size.height));
}

- (void)medianBlurWithSize:(int)size {
    medianBlur(_mat, _mat, size);
}

- (void)bilateralFilterWithDelta:(int)d andSigmaColor:(double)sc andSigmaSpace:(double)sp {
    bilateralFilter(_mat, _mat, d, sc, sp);
}

- (void)gaussianBlurWithSize:(NSSize)size {
    GaussianBlur(_mat, _mat, cv::Size(size.width, size.height), 0);
}

- (void)calHistWithSize:(int)size {
    [self calHistWithSize:size range:kEMCVLibRangeDefault];
}

- (void)calHistWithSize:(int)size range:(float *)range {
    int sizes[] = {size, size, size, size};
    float * ranges[] = {range, range, range, range};
    [self calHistWithSizes:sizes ranges:ranges];
}

- (void)calHistWithSizes:(int *)sizes ranges:(float **)ranges {
    calcHist(&_mat, 1, kEMCVLibChannalDefault, Mat(), _hist, (int)self.channalCount, sizes, (const float **)ranges);
}


#if TARGET_OS_IPHONE

- (instancetype)initWithImage:(UIImage *)img {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(img.CGImage);
    CGFloat cols = img.size.width;
    CGFloat rows = img.size.height;
    if  (img.imageOrientation == UIImageOrientationLeft || img.imageOrientation == UIImageOrientationRight) {
        cols = img.size.height;
        rows = img.size.width;
    }
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to backing data
                                                    cols,                      // Width of bitmap
                                                    rows,                     // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), img.CGImage);
    CGContextRelease(contextRef);
    return [self initWithNoCopyMat:cvMat];
}

- (UIImage *)toImage {
    UIImage * img;
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
        img = [[UIImage alloc] initWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpace);
    }
    return img;
}

#elif TARGET_OS_MAC

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
#endif

@end
