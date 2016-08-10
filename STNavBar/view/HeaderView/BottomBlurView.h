//
//  BottomBlurView.h
//  STNavBar
//
//  Created by StriEver on 16/8/9.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^viewTouchEvent) (void);
@interface BottomBlurView : UIView
@property (nonatomic, strong) UIImage * backImage;
@property (nonatomic, copy) viewTouchEvent viewTouchEvent;

- (instancetype)initWithFrame:(CGRect)frame backImage:(UIImage *)image;
@end
