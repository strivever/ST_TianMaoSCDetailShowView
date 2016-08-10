//
//  BottomSectionHeaderView.m
//  STNavBar
//
//  Created by StriEver on 16/8/9.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "BottomSectionHeaderView.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation BottomSectionHeaderView
- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    NSArray * btnArray = @[@"首页",@"搜索",@"消息",@"足迹",@"收藏"];
    NSArray * imageName = @[@"home",@"search",@"message",@"footprint",@"SHJ_NoCollection"];
    [btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * title  = obj;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setImage:[UIImage imageNamed:imageName[idx]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(8 + idx * ((kUIScreenWidth - 48)/5 + 8) , 20, (kUIScreenWidth - 48)/5, (kUIScreenWidth - 48)/5);
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    }];

}
@end
