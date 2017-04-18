//
//  EMCVFilterOperation.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVBasicImage.h"

@interface EMCVFilterOperation : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, copy) void(^op)(EMCVBasicImage *);

- (instancetype)init;
- (instancetype)initWithBlock:(void(^)(EMCVBasicImage *))block;
- (instancetype)initWithBlock:(void(^)(EMCVBasicImage *))block andTag:(int)tag;
- (void)setOperation:(void(^)(EMCVBasicImage *))block;
- (void)doOperationWithImage:(EMCVBasicImage *)img;

@end
