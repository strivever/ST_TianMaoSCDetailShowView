//
//  BottomBlurView.m
//  STNavBar
//
//  Created by StriEver on 16/8/9.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "BottomBlurView.h"

@implementation BottomBlurView

- (instancetype)initWithFrame:(CGRect)frame backImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        self.backImage = image;
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    imageView.image = self.backImage;
    [self addSubview:imageView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, imageView.width, imageView.height)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [imageView addSubview:toolbar];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.viewTouchEvent ? self.viewTouchEvent() : nil;
}
@end
