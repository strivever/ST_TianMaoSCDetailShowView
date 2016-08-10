//
//  NavBarSliderTool.m
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "NavBarSliderTool.h"

@implementation NavBarSliderTool
- (void)dealloc{
    @try {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
- (void)setViewController:(UIViewController *)viewController scrollview:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    viewController.navigationController.navigationBar.clipsToBounds = YES;
    [viewController.navigationController.navigationBar setShadowImage:[UIImage new]];
    [viewController.view insertSubview:self.navBarBgView atIndex:viewController.view.subviews.count];
    self.scrollView = scrollView;
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.viewController = viewController;
//    self.viewController.navigationItem.titleView
}
- (UIView *)navBarBgView{
    if (!_navBarBgView) {
        _navBarBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
        _navBarBgView.backgroundColor = self.barColor;
        _navBarBgView.alpha = 0;
    }
    return _navBarBgView;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSLog(@"%@",[change objectForKey:@"new"]);
        CGPoint point = [[change objectForKey:@"new"] CGPointValue];
        CGFloat y = point.y;
        if (y >= 0) {
            self.navBarBgView.alpha = y/64.0;
        }
        //根据偏移是否隐藏导航栏Items
        [_viewController.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.customView.hidden = y >= 0 ? YES : NO;
        }];
        [_viewController.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.customView.alpha = y >= 0 ? YES : NO;
        }];
    }
    
}
@end
