//
//  EMCVSingleImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVSingleImage.h"
#import "Static.h"

@implementation EMCVSingleImage

- (instancetype)initWithBasicImage:(EMCVBasicImage *)basicImage {
    return [self initWithMat:basicImage->_mat];
}
- (instancetype)initWithBasicImageWithNoCopy:(EMCVBasicImage *)basicImage {
    return [self initWithNoCopyMat:basicImage->_mat];
}


- (void)threshold:(double)thresh {
    [self threshold:thresh maxValue:255 type:CV_THRESH_TOZERO];
}

- (void)threshold:(double)thresh maxValue:(double)maxValue type:(int)type {
    threshold(_mat, _mat, thresh, maxValue, type);
}

- (void)findMaxValue:(double *)value outPoint:(NSPoint *)point {
    cv::Point maxPoint;
    minMaxLoc(_mat, nil, value, nil, &maxPoint);
    *point = NSMakePoint(maxPoint.x, maxPoint.y);
}

- (void)findMinValue:(double *)value outPoint:(NSPoint *)point {
    cv::Point minPoint;
    minMaxLoc(_mat, value, nil, &minPoint, nil);
    *point = NSMakePoint(minPoint.x, minPoint.y);
}

- (EMCVSingleImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2 {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_8UC1 andColor:kEMCVLibColorBlack];
    [self cannyOnCVImage:img withThresh1:thresh1 andThreash2:thresh2];
    return img;
}

- (void)cannyOnCVImage:(EMCVSingleImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2 {
    Canny(_mat, img->_mat, thresh1, thresh2);
}

- (EMCVSingleImage *)newDrawContoursWithMode:(int)mode andMethod:(int)method {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_8UC1 andColor:kEMCVLibColorBlack];
    [self drawContoursOnImage:img withMode:mode andMethod:method andColor:255];
    return img;
}

- (void)drawContoursOnImage:(EMCVSingleImage *)img withMode:(int)mode andMethod:(int)method andColor:(int)value {
    vector<vector<cv::Point>> contours;
    vector<Vec4i> hierarchy;
    findContours(_mat, contours, hierarchy, mode, method);
    for(int i = 0; i< contours.size(); i++) {
        Scalar color = Scalar(value);
        drawContours(img->_mat, contours, i, color, 2, 8, hierarchy);
    }
}

- (EMCVSingleImage *)newCornerHarrisWithBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k {
    NSSize size = self.imageSize;
    EMCVSingleImage * img = [[EMCVSingleImage alloc] initWithSize:size andType:CV_8UC1 andColor:kEMCVLibColorBlack];
    [self cornerHarrisOnImage:img withBlockSize:blockSize andKSize:ksize andK: k];
    return img;
}

- (void)cornerHarrisOnImage:(EMCVSingleImage *)img withBlockSize:(int)blockSize andKSize:(int)ksize andK:(double)k {
    cornerHarris(_mat, img->_mat, blockSize, ksize, k, BORDER_DEFAULT);
}

- (void)convertScaleAbs {
    convertScaleAbs(_mat, _mat);
}

- (vector<Point2f>)goodFeaturesToTrackInCppWithMaxCorners:(int)maxCorners andQLevel:(double)q andMinDistance:(double)minDistance {
    vector<Point2f> corners;
    goodFeaturesToTrack(_mat, corners, maxCorners, q, minDistance);
    return corners;
}
- (NSArray<NSValue *> *)goodFeaturesToTrackWithMaxCorners:(int)maxCorners andQLevel:(double)q andMinDistance:(double)minDistance {
    vector<Point2f> corners = [self goodFeaturesToTrackInCppWithMaxCorners:maxCorners andQLevel:q andMinDistance:minDistance];
    NSMutableArray<NSValue *> * arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < corners.size(); i++) {
        NSValue * value = [NSValue valueWithPoint: NSMakePoint(corners.at(i).x, corners.at(i).y)];
        [arr addObject:value];
    }
    return [arr copy];
}

- (vector<KeyPoint>)calSURFKeyPoints {
    Ptr<SURF> surf = SURF::create();
    vector<KeyPoint> keypoints;
    surf->detect(_mat, keypoints);
    return keypoints;
}

- (Mat)calSURFDescriptorsWithKeypoints:(vector<KeyPoint>)keypoints {
    Ptr<SURF> surf = SURF::create();
    Mat descriptors;
    surf->compute(_mat, keypoints, descriptors);
    return descriptors;
}

- (NSArray<NSValue *> *)doSURFMathchWithImage:(EMCVSingleImage *)img {
    vector<KeyPoint> keypointsB = [self calSURFKeyPoints];
    vector<KeyPoint> keypointsA = [img calSURFKeyPoints];
    Mat descriptorB = [self calSURFDescriptorsWithKeypoints:keypointsB];
    Mat descriptorA = [img calSURFDescriptorsWithKeypoints:keypointsA];
    BFMatcher matcher;
    vector<DMatch> matches;
    matcher.match(descriptorA, descriptorB, matches);
    NSMutableArray<NSValue *> * result = [[NSMutableArray alloc] init];
    for (int i = 0; i < matches.size(); i++) {
        Point2f p = keypointsB[matches[i].trainIdx].pt;
        NSPoint point = NSMakePoint(p.x, p.y);
        NSValue * value = [NSValue valueWithPoint:point];
        [result addObject:value];
    }
    return [result copy];
}

@end
