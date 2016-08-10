//
//  NavBarSliderTool.h
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavBarSliderTool : NSObject
@property (nonatomic, strong) UIColor * barColor;
@property (nonatomic, strong) UIView * navBarBgView;
@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIViewController * viewController;
- (void)setViewController:(UIViewController *)viewController scrollview:(UIScrollView *)scrollView;
@end
