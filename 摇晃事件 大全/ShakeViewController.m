//
//  MoveViewController.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeImageView.h"
#define kImageCount 3
@interface ShakeViewController ()
{
    ShakeImageView *_imageView;
}
@end

@implementation ShakeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _imageView = [[ShakeImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400)];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    [_imageView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_imageView resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
