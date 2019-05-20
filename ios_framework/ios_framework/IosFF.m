//
//  IosFF.m
//  ios_framework
//
//  Created by loary on 2019/5/20.
//  Copyright © 2019 loary. All rights reserved.
//

#import "IosFF.h"
#import <Flutter/FlutterViewController.h>

@implementation IosFF

+ (void)showFlutterView:(UIViewController *)ro {
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    [ro.navigationController pushViewController:flutterViewController animated:YES];
}
    
@end
