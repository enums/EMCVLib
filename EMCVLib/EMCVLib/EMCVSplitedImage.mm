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

@end
