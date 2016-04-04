//
//  GestureRecognizerViewController.m
//  摇晃事件 大全
//
//  Created by 邱少依 on 15/12/29.
//  Copyright © 2015年 QSY. All rights reserved.
//

#import "GestureRecognizerViewController.h"
#define kImageCount 3
@interface GestureRecognizerViewController ()
{
    UIImageView *_imageView;
    int _currentIndex;//当前图片索引
}
@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addGesture];
    
    // Do any additional setup after loading the view.
}

- (void)initUI {
    CGRect imageFrame = CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, 400);
    _imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    _imageView.image = [UIImage imageNamed:@"banner1"];//默认
    [self showPhotoName];
}

- (void)showPhotoName {
    NSString *title = [NSString stringWithFormat:@"banner%d.png",_currentIndex];
    self.navigationItem.title = title;
}

- (void)addGesture {
/*添加点击手势*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    
/*添加长按手势*/
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_imageView addGestureRecognizer:longPress];
    
/*添加捏合手势*/
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
    [_imageView addGestureRecognizer:pinchGesture];
    
/*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    [_imageView addGestureRecognizer:rotationGesture];
    
/*添加拖动手势*/
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)];
    [_imageView addGestureRecognizer:panGesture];
    
/*添加轻扫手势：向右侧*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    //swipeGestureToRight.direction=UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [_imageView addGestureRecognizer:swipeGestureToRight];
    
/*添加轻扫手势：向左侧*/
    
    UISwipeGestureRecognizer *swipeGestureToLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:swipeGestureToLeft];
    
#warning 少 解决拖动和轻扫的冲突
    //解决在图片上滑动时拖动手势和轻扫手势的冲突
    [panGesture requireGestureRecognizerToFail:swipeGestureToRight];
    [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
    //解决拖动和长按手势之间的冲突
    [longPress requireGestureRecognizerToFail:panGesture];
}
//隐藏导航栏
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}
//长按弹出删除框
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    //由于连续手势此方法会调用多次，所以需要判断其手势状态
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"System Info" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete the photo" otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
    }
}

//捏合时缩放图片
- (void)pinchImage:(UIPinchGestureRecognizer *)pinch {
    
    if (pinch.state == UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);//捏合手势中scale属性记录的缩放比例
    } else if (pinch.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.8f animations:^{
            _imageView.transform = CGAffineTransformIdentity;//取消之前的缩放
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 旋转图片
- (void)rotateImage:(UIRotationGestureRecognizer *)rotate {
    if (rotate.state == UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotate.rotation);
    } else if (rotate.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.5 animations:^{
             _imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
       
    }
}
// 拖动图片
- (void)panImage:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:self.view];//移动到相对的视图。
        _imageView.transform = CGAffineTransformTranslate(_imageView.transform, translation.x, translation.y);
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        _imageView.transform = CGAffineTransformIdentity;
    }
}
//#pragma mark 轻扫则查看下一张或上一张
- (void)swipeImage:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self lastImage];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self nextImage];
    }
}

- (void)lastImage {
//   涉及到多次循环，一般都是用取余数的方式
    int index = (_currentIndex + kImageCount - 1)%kImageCount;
    NSString *imageStr = [NSString stringWithFormat:@"banner%d.png",index];
    _imageView.image = [UIImage imageNamed:imageStr];
    _currentIndex = index;
    [self showPhotoName];
    
}

- (void)nextImage {
    
    int index = (_currentIndex + kImageCount + 1)%kImageCount;
    NSString *imageStr = [NSString stringWithFormat:@"banner%d.png",index];
    _imageView.image = [UIImage imageNamed:imageStr];
    _currentIndex = index;
    [self showPhotoName];
 
    
    
}

@end
