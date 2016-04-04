//
//  TouchEventViewController.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "TouchEventViewController.h"
#import "TouchView.h"
@interface TouchEventViewController ()
{
    TouchView *_view;
}
@end

@implementation TouchEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view =  [[TouchView alloc] initWithFrame:CGRectMake(50, 50, 150, 169)];
    [self.view addSubview:_view];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"接触self.view触发");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"移动self.view触发");
    UITouch *touch = [touches anyObject];
//    获取当前精确的位置
    CGPoint current = [touch preciseLocationInView:self.view];
//    获取之前精确的位置
    CGPoint previous = [touch precisePreviousLocationInView:self.view];
//    设置偏移量
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
 //   获取图片的中心点
    CGPoint center = _view.center;
    center = CGPointMake(center.x+offset.x, center.y+offset.y);
    _view.center = center;
    NSLog(@"正在移动");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"取消接触self.view触发");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"接触结束时end触发");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
