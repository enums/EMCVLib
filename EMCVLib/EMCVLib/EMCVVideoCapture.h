//
//  EMCVVideoCapture.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"
#import "EMCVImage.h"

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVVideoCapture : NSObject

#ifdef __cplusplus
{
@public
    VideoCapture _capture;
}
#endif

@property (nonatomic, assign) NSSize size;
@property (nonatomic, assign) int frameRate;
@property (nonatomic, assign) long frameCount;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithDevice:(int)device;
- (EMCVImage *)nextFrame;

@end
