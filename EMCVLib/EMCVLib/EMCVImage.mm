//
//  EMCVImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVImage.h"
#import "opencv.h"
#import "Static.h"

class CppObject {
    
};

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

- (instancetype)initWithBasicImage:(EMCVBasicImage *)basicImage {
    return [self initWithMat:basicImage->_mat];
}

- (instancetype)initWithBasicImageWithNoCopy:(EMCVBasicImage *)basicImage {
    return [self initWithNoCopyMat:basicImage->_mat];
}

- (instancetype)initWithCVSplitedImage:(EMCVSplitedImage *)splitedImage {
    Mat mat;
    merge(splitedImage->_mats, mat);
    return [self initWithNoCopyMat:mat];
}

- (instancetype)initWithCVSingleImage:(EMCVSingleImage *)singleImage {
    return [self initWithMat:singleImage->_mat];
}


- (EMCVImage *)makeACopy {
    return [[EMCVImage alloc] initWithMat:_mat];
}


- (EMCVImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2 {
    NSSize size = NSMakeSize(self->_mat.cols, self->_mat.rows);
    EMCVImage * img = [[EMCVImage alloc] initWithSize:size andType:CV_8UC3 andColor:kEMCVLibColorBlack];
    [self cannyOnCVImage:img withThresh1:thresh1 andThreash2:thresh2];
    return img;
}

- (void)cannyOnCVImage:(EMCVImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2 {
    Canny(self->_mat, img->_mat, thresh1, thresh2);
}




@end
