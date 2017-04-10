//
//  EMCVImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVImage : NSObject

#ifdef __cplusplus
{
@public
    Mat _mat;
}
- (instancetype)initWithMat:(Mat)mat;
- (instancetype)initWithMat:(Mat)mat cvtColor:(int)color;
- (instancetype)initWithNoCopyMat:(Mat)mat;
#endif

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithCVImage:(EMCVImage *)img;
- (instancetype)initWithCVImage:(EMCVImage *)img cvtColor:(int)color;

- (void)cvtColor:(int)code;

- (NSImage *)toImage;

@end

