//
//  EMCVSplitedImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "EMCVImage.h"

@class EMCVImage;

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
}
- (instancetype)initWithMats:(vector<Mat>)mats;
- (instancetype)initWithNoCopyMats:(vector<Mat>)mats;
#endif

@property (nonatomic, readonly) int channalCount;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithCVImage:(EMCVImage *)img;

- (EMCVImage *)mergeImage;
- (EMCVImage *)getImageWithChannal:(int)channal;

@end
