//
//  ShakeImageView.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "ShakeImageView.h"
#define kImageCount 3
@implementation ShakeImageView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [self getImage];
    }
    return self;
}
// 开始震动时执行:motion
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.image = [self getImage];
    }
}

// 使控件能成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIImage *)getImage {
    int index = arc4random()%kImageCount;
    NSString *imageString = [NSString stringWithFormat:@"banner%i",index];
    UIImage *image = [UIImage imageNamed:imageString];
    return image;
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"结束运动");
}

@end
