//
//  EMCVFilterOperation.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVFilterOperation.h"

@implementation EMCVFilterOperation

- (instancetype)init {
    return [self initWithBlock:nil];
}

- (instancetype)initWithBlock:(void(^)(EMCVImage *))block {
    return [self initWithBlock:block andTag:-1];
}

- (instancetype)initWithBlock:(void(^)(EMCVImage *))block andTag:(int)tag {
    self = [super init];
    if (self) {
        _op = block;
        _tag = tag;
    }
    return self;
}

- (void)setOperation:(void(^)(EMCVImage *))block {
    self.op = block;
}


- (void)doOperationWithCVImage:(EMCVImage *)img {
    self.op(img);
}

@end
