//
//  ViewController.m
//  test_ios_framework
//
//  Created by loary on 2019/5/20.
//  Copyright © 2019 loary. All rights reserved.
//

#import "ViewController.h"
#import <ios_framework/ios_framework.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"flutter制作跨平台SDK-demo";
    NSLog(@"7878");
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"进入flutter页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click {
    [IosFF showFlutterView:self.navigationController];
}

@end
