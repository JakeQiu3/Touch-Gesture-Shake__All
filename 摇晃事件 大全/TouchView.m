//
//  TouchImage.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"1-首页.jpg"];
        self.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    return self;
}

@end
