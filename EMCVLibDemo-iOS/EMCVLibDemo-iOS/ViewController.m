//
//  ViewController.m
//  EMCVLibDemo-iOS
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "ViewController.h"
#import "EMCVLibiOS/EMCVLibiOS.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"rgb" ofType:@"jpg"];
    EMCVImage * i = [[EMCVImage alloc] initWithPath:path];
    [self.imageView setImage:[i toImage]];
}

@end
