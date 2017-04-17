//
//  EMCVImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"
#import "EMCVBasicImage.h"
#import "EMCVSplitedImage.h"
#import "EMCVSingleImage.h"

@class EMCVSingleImage;
@class EMCVSplitedImage;

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVImage : EMCVBasicImage

#ifdef __cplusplus
{

}
#endif

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithBasicImage:(EMCVBasicImage *)basicImage;
- (instancetype)initWithBasicImageWithNoCopy:(EMCVBasicImage *)basicImage;
- (instancetype)initWithCVSplitedImage:(EMCVSplitedImage *)splitedImage;
- (instancetype)initWithCVSingleImage:(EMCVSingleImage *)singleImage;

- (EMCVImage *)makeACopy;

- (EMCVImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2;
- (void)cannyOnCVImage:(EMCVImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2;

@end

