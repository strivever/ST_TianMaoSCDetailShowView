//
//  DetailHeaderView.h
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midViewTopContraint;
@property (weak, nonatomic) IBOutlet UIView *adBackView;
+ (instancetype)view;
- (void)upDateBottomViewContraint:(CGFloat)contraint;
@end
