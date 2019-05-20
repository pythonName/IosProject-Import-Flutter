//
//  CustomNavigationController.h
//  cop
//
//  Created by lizhenzhen on 15/5/7.
//
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController
@property (nonatomic, strong) UIView *vLine;
- (void)hideNaviBar;
- (void)showNaviBar;
@end
