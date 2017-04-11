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


@end
