//
//  DetailHeaderView.m
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"DetailHeaderView" owner:nil options:nil][0];
}
- (void)upDateBottomViewContraint:(CGFloat)contraint{
    contraint = contraint * .6;
    if (contraint <= 0) {
        contraint = 0;
    }
    [self layoutIfNeeded];
    [UIView animateWithDuration:.1 animations:^{
        _midViewTopContraint.constant = -contraint;
        [self layoutIfNeeded];
    }];
}
@end
