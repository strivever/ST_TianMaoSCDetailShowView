//
//  BottomTableViewHeaderView.m
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "BottomTableViewHeaderView.h"

@implementation BottomTableViewHeaderView
+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"BottomTableViewHeaderView" owner:nil options:nil][0];
}

@end
