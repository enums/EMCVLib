//
//  EMCVFilter.m
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "EMCVFilter.h"

@implementation EMCVFilter

- (instancetype)init {
    return [self initWithArray:[[NSMutableArray alloc] init]];
}

- (instancetype)initWithArray:(NSMutableArray<EMCVFilterOperation *> *)array {
    self = [super init];
    if (self) {
        _operations = array;
    }
    return self;
}

- (void)pushOperationBlock:(void(^)(EMCVBasicImage *))block {
    [self pushOperationBlock:block andTag:-1];
}

- (void)pushOperationBlock:(void(^)(EMCVBasicImage *))block andTag:(int)tag {
    EMCVFilterOperation * fop = [[EMCVFilterOperation alloc] initWithBlock:block andTag:tag];
    [self pushOperation:fop];
}

- (void)pushOperation:(EMCVFilterOperation *)op {
    [self.operations addObject:op];
}

- (EMCVFilterOperation *)popOperation {
    EMCVFilterOperation * last = self.operations.lastObject;
    [self.operations removeLastObject];
    return last;
}

- (void)runFilterWithImage:(EMCVBasicImage *)img {
    for (EMCVFilterOperation * op in self.operations) {
        [op doOperationWithImage:img];
    }
}

- (void)popAll {
    [self.operations removeAllObjects];
}

@end
