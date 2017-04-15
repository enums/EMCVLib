//
//  EMCVSingleImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVSingleImage.h"
#import "Static.h"

@implementation EMCVSingleImage

- (NSSize)imageSize {
    return NSMakeSize(_mat.cols, _mat.rows);
}

- (instancetype)initWithSize:(NSSize)size andType:(int)type andValue:(int)value {
    Mat mat = Mat(size.height, size.width, type, Scalar(value));
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

- (void)forEachPixelWithBlock:(void(^)(int, int, unsigned char *))block {
    for (int y = 0; y < _mat.rows; y++) {
        for (int x = 0; x < _mat.cols; x++) {
            [self forPixelAtX:x andY:y withBlock:block];
        }
    }
}

- (void)forPixelAtX:(int)x andY:(int)y withBlock:(void(^)(int, int, unsigned char *))block {
    unsigned char * ptr = _mat.ptr(y, x);
    block(x, y, ptr);
}

- (void)threshold:(double)thresh {
    [self threshold:thresh maxValue:255 type:CV_THRESH_TOZERO];
}

- (void)threshold:(double)thresh maxValue:(double)maxValue type:(int)type {
    threshold(_mat, _mat, thresh, maxValue, type);
}

- (void)flipWithXAxis {
    flip(_mat, _mat, 1);
}

- (void)flipWithYAxis {
    flip(_mat, _mat, -1);
}

- (void)setBrightness:(double)brightness {
    _mat.convertTo(_mat, -1, 1, brightness);
}

- (void)pyrUpWithRatio:(double)ratio {
    NSSize size = self.imageSize;
    pyrUp(_mat, _mat, cv::Size(size.width * ratio, size.height * ratio));
}

- (void)pyrDownWithRatio:(double)ratio {
    NSSize size = self.imageSize;
    pyrDown(_mat, _mat, cv::Size(size.width * ratio, size.height * ratio));
}

- (void)calHistWithSize:(int)size {
    [self calHistWithSize:size range:kEMCVLibRangeDefault];
}

- (void)calHistWithSize:(int)size range:(float *)range {
    calcHist(&_mat, 1, 0, Mat(), _hist, 1, &size, (const float **)&range);
}


- (void)normalizeImageWithValue:(double)value {
    normalize(_mat, _mat, 0, value, NORM_MINMAX, -1, Mat());
}
- (void)normalizeHistWithValue:(double)value {
    normalize(_hist, _hist, 0, value, NORM_MINMAX, -1, Mat());
}

- (void)findMaxValue:(double *)value outPoint:(NSPoint *)point {
    cv::Point maxPoint;
    minMaxLoc(_mat, nil, value, nil, &maxPoint);
    *point = NSMakePoint(maxPoint.x, maxPoint.y);
}

- (void)findMinValue:(double *)value outPoint:(NSPoint *)point {
    cv::Point minPoint;
    minMaxLoc(_mat, value, nil, &minPoint, nil);
    *point = NSMakePoint(minPoint.x, minPoint.y);
}

- (EMCVSingleImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2 {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_8UC1 andValue:0];
    [self cannyOnCVImage:img withThresh1:thresh1 andThreash2:thresh2];
    return img;
}

- (void)cannyOnCVImage:(EMCVSingleImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2 {
    Canny(_mat, img->_mat, thresh1, thresh2);
}

- (EMCVSingleImage *)newDrawContoursWithMode:(int)mode andMethod:(int)method {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_8UC1 andValue:0];
    [self drawContoursOnImage:img withMode:mode andMethod:method andColor:255];
    return img;
}

- (void)drawContoursOnImage:(EMCVSingleImage *)img withMode:(int)mode andMethod:(int)method andColor:(int)value {
    vector<vector<cv::Point>> contours;
    vector<Vec4i> hierarchy;
    findContours(_mat, contours, hierarchy, mode, method);
    for(int i = 0; i< contours.size(); i++) {
        Scalar color = Scalar(value);
        drawContours(img->_mat, contours, i, color, 2, 8, hierarchy);
    }
}

- (EMCVSingleImage *)newCornerHarrisWithBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_32FC1 andValue:0];
    [self cornerHarrisOnImage:img withBlockSize:blockSize andKSize:ksize andK: k];
    return img;
}

- (void)cornerHarrisOnImage:(EMCVSingleImage *)img withBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k {
    cornerHarris(_mat, img->_mat, blockSize, ksize, k, BORDER_DEFAULT);
}

- (void)convertScaleAbs {
    convertScaleAbs(_mat, _mat);
}


@end
