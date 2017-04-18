//
//  EMCVFactory.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/11.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVImage.h"
#import "EMCVSplitedImage.h"

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
using namespace std;
#endif

@interface EMCVFactory : NSObject

+ (double)compareHistWithImage:(EMCVBasicImage *)imgA andImage:(EMCVBasicImage *)imgB withMethod:(int)method;

+ (EMCVBasicImage *)matchTemplateWithImage:(EMCVBasicImage *)img andTempl:(EMCVBasicImage *)templ withMethod:(int)method;

+ (EMCVBasicImage *)doBackProjectionWithImage:(EMCVBasicImage *)img andTempl:(EMCVBasicImage *)templ;
+ (EMCVBasicImage *)doBackProjectionWithImage:(EMCVBasicImage *)img andTempl:(EMCVBasicImage *)templ withDims:(int)dims;
+ (EMCVBasicImage *)doBackProjectionWithImage:(EMCVBasicImage *)img andTempl:(EMCVBasicImage *)templ atChannals:(int *)channals andDims:(int)dims andRanges:(float **)ranges;

+ (EMCVBasicImage *)blendingImage:(EMCVBasicImage *)imgA withImage:(EMCVBasicImage *)imgB useAlpha1:(double)a1 andAlpha2:(double)a2 andGama:(double)gamma;

+ (void)copyImage:(EMCVBasicImage *)src toImage:(EMCVBasicImage *)dst;

// NSPoint -> NSValue, [[NSValue, NSValue], [NSValue, NSValue], ...]
+ (NSArray<NSArray<NSValue *> *> *)calOpticalFlowPyrLKWithImage:(EMCVSingleImage *)imgA andImage:(EMCVSingleImage *)imgB useMaxCorners:(int)maxCorners andQLevel:(double)q andMinDistance:(double)minDistance;


@end
