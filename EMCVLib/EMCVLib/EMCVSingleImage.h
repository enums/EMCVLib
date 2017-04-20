//
//  EMCVSingleImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVBasicImage.h"
#import "EMCVImage.h"


#ifdef __cplusplus
#import "opencv.h"
using namespace cv;
using namespace std;
#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC
#import "opencv2/xfeatures2d.hpp"
#import "opencv2/xfeatures2d/nonfree.hpp"
using namespace xfeatures2d;
#endif

#endif

@interface EMCVSingleImage : EMCVBasicImage
#ifdef __cplusplus
{
}
- (vector<Point2f>)goodFeaturesToTrackInCppWithMaxCorners:(int)maxCorners andQLevel:(double)q andMinDistance:(double)minDistance;
#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC
- (vector<KeyPoint>)calSURFKeyPoints;
- (Mat)calSURFDescriptorsWithKeypoints:(vector<KeyPoint>)keypoints;
#endif
#endif
- (instancetype)initWithBasicImage:(EMCVBasicImage *)basicImage;
- (instancetype)initWithBasicImageWithNoCopy:(EMCVBasicImage *)basicImage;

- (void)threshold:(double)thresh;
- (void)threshold:(double)thresh maxValue:(double)maxValue type:(int)type;

- (void)findMaxValue:(double *)value outPoint:(NSPoint *)point;
- (void)findMinValue:(double *)value outPoint:(NSPoint *)point;

- (EMCVSingleImage *)newDrawContoursWithMode:(int)mode andMethod:(int)method;
- (void)drawContoursOnImage:(EMCVSingleImage *)img withMode:(int)mode andMethod:(int)method andColor:(int)value;

- (EMCVSingleImage *)newCornerHarrisWithBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k;
- (void)cornerHarrisOnImage:(EMCVSingleImage *)img withBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k;

- (void)convertScaleAbs;

// NSPoint / CGPoint -> NSValue
- (NSArray<NSValue *> *)goodFeaturesToTrackWithMaxCorners:(int)maxCorners andQLevel:(double)q andMinDistance:(double)minDistance;

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC
- (NSArray<NSValue *> *)doSURFMathchWithImage:(EMCVSingleImage *)img;
#endif

@end
