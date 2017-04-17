//
//  UIImageView+EMCVLib.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "UIImageView+EMCVLib.h"
#import "Static.h"

@implementation UIImageView (EMCVLib)

- (void)drawCVImage:(EMCVImage *)cvImg {
    UIImage * img = [cvImg toImage];
    [self setImage:img];
}

- (void)drawRGBHistWithCVImage:(EMCVBasicImage *)cvImg size:(int)size {
    Mat histMat = Mat((int)self.frame.size.height, (int)self.frame.size.width, CV_8UC3, Scalar(0, 0, 0));
    EMCVSplitedImage * splitedImg = [cvImg splitImage];
    EMCVSingleImage * rImg = [splitedImg imageAtChannal:0];
    EMCVSingleImage * gImg = [splitedImg imageAtChannal:1];
    EMCVSingleImage * bImg = [splitedImg imageAtChannal:2];
    [rImg calHistWithSize:size];
    [gImg calHistWithSize:size];
    [bImg calHistWithSize:size];
    [rImg normalizeHistWithValue:self.frame.size.height];
    [gImg normalizeHistWithValue:self.frame.size.height];
    [bImg normalizeHistWithValue:self.frame.size.height];
    [self drawHistOnMat:histMat withHist:rImg->_hist size:size color:Scalar(255, 0, 0)];
    [self drawHistOnMat:histMat withHist:gImg->_hist size:size color:Scalar(0, 255, 0)];
    [self drawHistOnMat:histMat withHist:bImg->_hist size:size color:Scalar(0, 0, 255)];
    EMCVImage * img = [[EMCVImage alloc] initWithNoCopyMat:histMat];
    [self drawCVImage:img];
}

- (void)drawHistWithCVImage:(EMCVBasicImage *)cvImg size:(int)size rgbColor:(int *)rgb {
    Mat histImage = Mat((int)self.frame.size.height, (int)self.frame.size.width, CV_8UC3, Scalar(0, 0, 0));
    [self drawHistOnMat:histImage withHist:cvImg->_hist size:size color:Scalar(rgb[0], rgb[1], rgb[2])];
    EMCVImage * img = [[EMCVImage alloc] initWithNoCopyMat:histImage];
    [self setImage:[img toImage]];
}

- (void)drawHistWithCVSplitedImage:(EMCVSplitedImage *)splitedImg sizes:(int *)sizes rgbColors:(int **)rgbs {
    int dims = (int)splitedImg->_mats.size();
    Mat histImage = Mat((int)self.frame.size.height, (int)self.frame.size.width, CV_8UC3, Scalar(0, 0, 0));
    for (int i = 0; i < dims; i++) {
        [self drawHistOnMat:histImage withHist:splitedImg->_hists.at(i) size:sizes[i] color:Scalar(rgbs[i][0], rgbs[i][1], rgbs[i][2])];
    }
    EMCVImage * img = [[EMCVImage alloc] initWithNoCopyMat:histImage];
    [self setImage:[img toImage]];
}

- (void)drawHistWithCVSplitedImage:(EMCVSplitedImage *)splitedImg channal:(int)channal size:(int)size rgbColor:(int *)rgb {
    Mat histImage = Mat((int)self.frame.size.height, (int)self.frame.size.width, CV_8UC3, Scalar(0, 0, 0));
    [self drawHistOnMat:histImage withHist:splitedImg->_hists.at(channal) size:size color:Scalar(rgb[0], rgb[1], rgb[2])];
    EMCVImage * img = [[EMCVImage alloc] initWithNoCopyMat:histImage];
    [self setImage:[img toImage]];
}

- (void)drawHistOnMat:(Mat)mat withHist:(MatND)hist size:(int)size color:(Scalar)color {
    double width = self.frame.size.width;
    double height = self.frame.size.height;
    int bin_w = cvRound((double)width / size);
    for(int i = 1; i < size; i++) {
        line(mat,
             cv::Point(bin_w * (i - 1), height - cvRound(hist.at<float>(i - 1))),
             cv::Point(bin_w * i, height - cvRound(hist.at<float>(i))),
             color);
    }
}
@end
