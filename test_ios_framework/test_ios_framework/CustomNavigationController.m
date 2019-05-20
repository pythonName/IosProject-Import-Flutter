//
//  CustomNavigationController.m
//  cop
//
//  Created by lizhenzhen on 15/5/7.
//
//

#import "CustomNavigationController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HYNavgationBar : UINavigationBar

@end

@implementation HYNavgationBar

// 这里是为了解决透明的导航栏挡住下方的内容的问题。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hited = [super hitTest:point withEvent:event];
    CGRect frameInNavBar = [self convertRect:hited.bounds fromView:hited];
    if (CGRectEqualToRect(self.bounds, frameInNavBar)) {
        return nil;
    }
    return hited;
}

@end

@interface CustomNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
 
@end

@implementation CustomNavigationController

- (id) initWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        rootViewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self = [super initWithNavigationBarClass:[HYNavgationBar class] toolbarClass:nil];
    [self setViewControllers:@[rootViewController]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UINavigationDelegate
    self.delegate = self;
    
//    UIImage *bgImage = [[UIImage imageNamed:@"navigationBar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];

    [self.navigationBar setBarTintColor:[UIColor whiteColor]];

    //自定义导航栏标题的颜色字体大小
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x222222),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];

    //去掉系统分割线
    [self.navigationBar setShadowImage:[UIImage new]];
    //分割线
    _vLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationBar.frame) - 0.5, CGRectGetWidth(self.navigationBar.frame), 0.5)];
    _vLine.backgroundColor = UIColorFromRGB(0xF0F0F0);
    [self.navigationBar addSubview:_vLine];

//    //参考：https://www.cnblogs.com/mengfei90/p/5210517.html
//    // 获取系统手势的target对象
//    //id tagart = self.interactivePopGestureRecognizer.delegate;
//    // 创建手势调用系统的方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handlePan:)];
//    // 添加手势
//    [self.view addGestureRecognizer:pan];
//    // 设置手势的代理
//    pan.delegate = self;
//    // 禁能系统的手势
//    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)hideNaviBar {
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];//导航栏底部默认的分割线
}

- (void)showNaviBar {
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];

//    UIImage *bgImage = [[UIImage imageNamed:@"navigationBar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationBar setBackgroundImage:bgImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}

//- (void) handlePan:(UIPanGestureRecognizer*) recognizer
//{
//    CGPoint point = [recognizer translationInView:self.view];
//    NSLog(@"%f,%f",point.x,point.y);
//    id tagart = self.interactivePopGestureRecognizer.delegate;
//    [tagart performSelector:@selector(handleNavigationTransition:) withObject:recognizer];
////    //recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
////                                         recognizer.view.center.y + translation.y);
//
//    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
//   // [recognizer setTranslation:CGPointZero inView:self.view];
//
//}
//
//#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (self.viewControllers.count <= 1) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - 重定义父类方法
//- (void)setTitle:(NSString *)title{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:20.0];
//    label.textAlignment = NSTextAlignmentCenter;
//
//    label.textColor = [UIColor blackColor];
//    label.shadowColor=[UIColor blackColor];
//    label.shadowOffset=CGSizeMake(0, -1);
//
//    label.text=title;
//    [label sizeToFit];
//    self.navigationItem.titleView = label;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if ([viewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;//不让viewController的view扩展到整个屏幕
    }
    
    //在滑动过程中你会发现如果在pushViewController的动画过程中激活滑动手势会导致crash, 解决方案
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    //当调用CustomNavigationController 的 initWithRootViewController方法时，pushViewController也会被调用【真机有效】
    if (self.viewControllers.count > 0) {
        UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
        [backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
       
        UIBarButtonItem *bbi=[[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = bbi;
        
        self.interactivePopGestureRecognizer.enabled = YES;
        __weak typeof (self)weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        viewController.hidesBottomBarWhenPushed = YES;
    }else {//根视图时
        self.interactivePopGestureRecognizer.enabled = NO;
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    //return UIStatusBarStyleDefault;
    return [self.topViewController preferredStatusBarStyle];
}

#pragma mark - UINavigationDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /* if rootViewController, set delegate nil */
        if (navigationController.viewControllers.count == 1) {
            self.interactivePopGestureRecognizer.enabled = NO;
            self.interactivePopGestureRecognizer.delegate = nil;
        }
}
@end
