//
//  platform.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#ifndef platform_h
#define platform_h

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#define NSSize CGSize
#define NSMakeSize(a, b) CGSizeMake((a), (b))
#define NSPoint CGPoint
#define NSMakePoint(a, b) CGPointMake((a), (b))
#define NSRect CGRect
#define NSMakeRect(a, b, c, d) CGRectMake((a), (b), (c), (d))

#elif TARGET_OS_MAC

#import <Cocoa/Cocoa.h>

#endif

#endif /* platform_h */
