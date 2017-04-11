//
//  EMCV.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/11.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCV.h"
#import "opencv.h"

@implementation EMCV

+ (double)compareHistWithCVImage:(EMCVImage *)imgA andImage:(EMCVImage *)imgB withMethod:(int)method {
    return compareHist(imgA->_hist, imgB->_hist, method);
}

+ (double)compareHistWithCVSplitedImage:(EMCVSplitedImage *)imgA andImage:(EMCVSplitedImage *)imgB withMethod:(int)method atChannal:(int)channal {
    return compareHist(imgA->_hists.at(channal), imgB->_hists.at(channal), method);
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

@end
