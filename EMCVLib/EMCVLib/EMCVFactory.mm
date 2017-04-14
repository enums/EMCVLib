//
//  EMCVFactory.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/11.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVFactory.h"
#import "opencv.h"
#import "Static.h"

@implementation EMCVFactory

+ (double)compareHistWithCVImage:(EMCVImage *)imgA andImage:(EMCVImage *)imgB withMethod:(int)method {
    return compareHist(imgA->_hist, imgB->_hist, method);
}

+ (EMCVImage *)matchTemplateWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ withMethod:(int)method {
    int cols = img->_mat.cols - templ->_mat.cols + 1;
    int rows = img->_mat.rows - templ->_mat.rows + 1;
    Mat matchResult;
    matchResult.create(cols, rows, CV_32FC1);
    matchTemplate(img->_mat, templ->_mat, matchResult, method);
//    normalize(matchResult, matchResult, 0, 1, NORM_MINMAX, -1, Mat());
    EMCVImage * ret = [[EMCVImage alloc] init];
    matchResult.convertTo(ret->_mat, CV_8U, 255);
    return ret;
}


+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ {
    int dims = (int)img.channalCount;
    return [self doBackProjectionWithImage:img andTempl:templ withDims:dims];
}

+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ withDims:(int)dims {
    return [self doBackProjectionWithImage:img andTempl:templ atChannals:kEMCVLibChannalDefault andDims:dims andRanges:kEMCVLibRangesDefault];
}

+ (EMCVImage *)doBackProjectionWithImage:(EMCVImage *)img andTempl:(EMCVImage *)templ atChannals:(int *)channals andDims:(int)dims andRanges:(float **)ranges {
    EMCVImage * backProj = [[EMCVImage alloc] init];
    calcBackProject(&(img->_mat), dims, channals, templ->_hist, backProj->_mat, (const float **)ranges);
    return backProj;
}

+ (EMCVImage *)blendingImage:(EMCVImage *)imgA withImage:(EMCVImage *)imgB useAlpha1:(double)a1 andAlpha2:(double)a2 andGama:(double)gamma {
    EMCVImage * img = [[EMCVImage alloc] init];
    addWeighted(imgA->_mat, a1, imgB->_mat, a2, gamma, img->_mat);
    return img;
}

+ (void)copyCVImage:(EMCVImage *)src toCVImage:(EMCVImage *)dst {
    Mat newMat;
    src->_mat.copyTo(newMat);
    dst->_mat = newMat;
}

+ (void)copyCVImage:(EMCVImage *)src toCVSingleImage:(EMCVSingleImage *)dst {
    Mat newMat;
    src->_mat.copyTo(newMat);
    dst->_mat = newMat;
}

+ (void)copyCVSingleImage:(EMCVSingleImage *)src toCVSingleImage:(EMCVSingleImage *)dst {
    Mat newMat;
    src->_mat.copyTo(newMat);
    dst->_mat = newMat;
}
+ (void)copyCVSingleImage:(EMCVSingleImage *)src toCVImage:(EMCVImage *)dst {
    Mat newMat;
    src->_mat.copyTo(newMat);
    dst->_mat = newMat;
}


@end
