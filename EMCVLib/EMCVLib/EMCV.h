//
//  EMCV.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/11.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVImage.h"
#import "EMCVSplitedImage.h"

@interface EMCV : NSObject

+ (double)compareHistWithCVImage:(EMCVImage *)imgA andImage:(EMCVImage *)imgB withMethod:(int)method;
+ (double)compareHistWithCVSplitedImage:(EMCVSplitedImage *)imgA andImage:(EMCVSplitedImage *)imgB withMethod:(int)method atChannal:(int)channal;

+ (EMCVImage *)matchTemplateWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ withMethod:(int)method;

+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ;
+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ withDims:(int)dims;
+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ atChannals:(int *)channals andDims:(int)dims andRanges:(float **)ranges;

+ (EMCVImage *)blendingImage:(EMCVImage *)imgA withImage:(EMCVImage *)imgB useAlpha1:(double)a1 andAlpha2:(double)a2 andGama:(double)gamma;

@end
