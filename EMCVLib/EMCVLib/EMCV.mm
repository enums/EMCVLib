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

@end
