//
//  EMCVSplitedImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"
#import "EMCVImage.h"
#import "EMCVSingleImage.h"

@class EMCVImage;
@class EMCVSingleImage;

#ifdef __cplusplus
#include "opencv.h"
using namespace std;
using namespace cv;
#endif

@interface EMCVSplitedImage : NSObject

#ifdef __cplusplus
{
@public
    vector<Mat> _mats;
    vector<MatND> _hists;
}
- (instancetype)initWithMats:(vector<Mat>)mats;
- (instancetype)initWithNoCopyMats:(vector<Mat>)mats;
#endif

@property (nonatomic, readonly) int channalCount;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithCVImage:(EMCVImage *)img;

- (EMCVImage *)mergeImage;
- (EMCVSingleImage *)imageAtChannal:(int)channal;
- (EMCVSingleImage *)imageCopyAtChannal:(int)channal;
- (NSSize)sizeAtChannal:(int)channal;

@end
