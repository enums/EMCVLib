//
//  EMCVFilterOperation.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVImage.h"

@interface EMCVFilterOperation : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic, copy) void(^op)(EMCVImage *);

- (instancetype)init;
- (instancetype)initWithBlock:(void(^)(EMCVImage *))block;
- (instancetype)initWithBlock:(void(^)(EMCVImage *))block andTag:(int)tag;
- (void)setOperation:(void(^)(EMCVImage *))block;
- (void)doOperationWithCVImage:(EMCVImage *)img;

@end
