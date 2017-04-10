//
//  EMCVSplitedImage.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVSplitedImage.h"

@implementation EMCVSplitedImage

- (int)getChannalCount {
    return (int)self->_mats.size();
}

- (instancetype)initWithPath:(NSString *)path {
    EMCVImage * img = [[EMCVImage alloc] initWithPath:path];
    return [self initWithCVImage:img];
}

- (instancetype)initWithCVImage:(EMCVImage *)img {
    vector<Mat> mats;
    split(img->_mat, mats);
    return [self initWithNoCopyMats:mats];
}

- (instancetype)initWithMats:(vector<Mat>)mats {
    vector<Mat> newMats;
    for_each(mats.cbegin(), mats.cend(), [&newMats](const Mat mat)->void {
        Mat newMat;
        mat.copyTo(newMat);
        newMats.push_back(newMat);
    });
    return [self initWithNoCopyMats:newMats];
}

- (instancetype)initWithNoCopyMats:(vector<Mat>)mats {
    self = [super init];
    if (self) {
        self->_mats = mats;
    }
    return self;
}

- (EMCVImage *)mergeImage {
    return [[EMCVImage alloc] initWithSplitedImage:self];
}

- (EMCVImage *)getImageWithChannal:(int)channal {
    return [[EMCVImage alloc] initWithMat:_mats.at(channal)];
}

- (void)calHistWithSize:(int)size range:(float *)range {
    int dims = (int)_mats.size();
    int * sizes = new int[dims];
    float ** ranges = new float * [dims];
    for (int i = 0; i < dims; i++) {
        sizes[i] = size;
        ranges[i] = range;
    }
    [self calHistWithSizes:sizes range:ranges];
}

- (void)calHistWithSizes:(int *)sizes range:(float **)ranges {
    int dims = (int)_mats.size();
    _hists.clear();
    for (int i = 0; i < dims; i++) {
        [self calHistWithChannal:i size:sizes[i] range:ranges[i]];
    }
}

- (void)calHistWithChannal:(int)channal size:(int)size range:(float *)range {
    MatND hist;
    calcHist(&_mats.at(channal), 1, 0, Mat(), hist, 1, &size, (const float **)&range);
    if (_hists.size() > channal) {
        _hists[channal] = hist;
    } else if (_hists.size() == channal) {
        _hists.push_back(hist);
    } else {
        while (_hists.size() < channal) {
            _hists.push_back(MatND());
        }
        _hists.push_back(hist);
    }
}

- (void)normalizeHistWithValue:(double)value {
    int dims = (int)_mats.size();
    for (int i = 0; i < dims; i++) {
        [self normalizeHistWithChanal:i value:value];
    }
}

- (void)normalizeHistWithChanal:(int)channal value:(double)value  {
    normalize(_hists.at(channal), _hists.at(channal), 0, value, NORM_MINMAX, -1, Mat());
}

- (void)findMaxValue:(double *)value outPoint:(NSPoint *)point inChannal:(int)channal {
    cv::Point maxPoint;
    minMaxLoc(_mats.at(channal), nil, value, nil, &maxPoint);
    *point = NSMakePoint(maxPoint.x, maxPoint.y);
}

- (void)findMinValue:(double *)value outPoint:(NSPoint *)point inChannal:(int)channal {
    cv::Point minPoint;
    minMaxLoc(_mats.at(channal), value, nil, &minPoint, nil);
    *point = NSMakePoint(minPoint.x, minPoint.y);
}


@end
