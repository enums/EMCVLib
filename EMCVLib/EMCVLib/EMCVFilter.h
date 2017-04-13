//
//  EMCVFilter.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCVFilterOperation.h"

@interface EMCVFilter : NSObject

@property (nonatomic, strong) NSMutableArray<EMCVFilterOperation *> * operations;

- (instancetype)init;
- (instancetype)initWithArray:(NSMutableArray<EMCVFilterOperation *> *)array;
- (void)pushOperationBlock:(void(^)(EMCVImage *))block;
- (void)pushOperationBlock:(void(^)(EMCVImage *))block andTag:(int)tag;
- (void)pushOperation:(EMCVFilterOperation *)op;
- (EMCVFilterOperation *)popOperation;
- (void)runFilterWithCVImage:(EMCVImage *)img;
- (void)popAll;

@end
