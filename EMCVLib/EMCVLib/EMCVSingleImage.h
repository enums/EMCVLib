//
//  EMCVSingleImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVImage.h"

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
using namespace std;
#endif

@interface EMCVSingleImage : NSObject
#ifdef __cplusplus
{
@public
    Mat _mat;
    MatND _hist;
}
- (instancetype)initWithMat:(Mat)mat;
- (instancetype)initWithNoCopyMat:(Mat)mat;
#endif

@property (nonatomic, readonly)NSSize imageSize;

- (instancetype)initWithSize:(NSSize)size andType:(int)type andValue:(int)value;

- (void)threshold:(double)thresh;
- (void)threshold:(double)thresh maxValue:(double)maxValue type:(int)type;

- (void)flipWithXAxis;
- (void)flipWithYAxis;

- (void)setBrightness:(double)brightness;

- (void)pyrUpWithRatio:(double)ratio;
- (void)pyrDownWithRatio:(double)ratio;

- (void)calHistWithSize:(int)size;
- (void)calHistWithSize:(int)size range:(float *)range;

- (void)normalizeHistWithValue:(double)value;

- (void)findMaxValue:(double *)value outPoint:(NSPoint *)point;
- (void)findMinValue:(double *)value outPoint:(NSPoint *)point;

- (EMCVSingleImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2;
- (void)cannyOnCVImage:(EMCVSingleImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2;

- (EMCVSingleImage *)newDrawContoursWithMode:(int)mode andMethod:(int)method;
- (void)drawContoursOnImage:(EMCVSingleImage *)img withMode:(int)mode andMethod:(int)method andColor:(int)value;

//- (EMCVSingleImage *)newCornerHarrisWithBlockSize:(int)blockSize andKSize:(int)ksize;
//- (void)cornerHarrisOnImage:(EMCVSingleImage *)img withBlockSize:(int)blockSize andKSize:(int)ksize;

@end
