//
//  ViewController.m
//  TestAppDemo
//
//  Created by loary on 2019/5/19.
//  Copyright © 2019 loary. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/FlutterViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ios现有工程引入flutter";
    NSLog(@"7878");
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"进入flutter页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click {
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterViewController animated:YES];
//    [self presentViewController:flutterViewController animated:YES completion:^{
//
//    }];
}

@end
