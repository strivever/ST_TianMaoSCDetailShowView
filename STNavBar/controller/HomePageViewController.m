//
//  HomePageViewController.m
//  STNavBar
//
//  Created by StriEver on 16/8/5.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "HomePageViewController.h"
#import "AdView.h"
#import "NavBarSliderTool.h"
#import "DetailViewController.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * navBarBgView;
@property (nonatomic, strong)NavBarSliderTool * sliderTool;
@property (nonatomic, strong)UIScrollView * titleView;
@end

@implementation HomePageViewController
- (void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"but_Photograph_press"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 25, 25);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    AdView * adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, 375, 200) imageLinkURL:@[@"0-0.jpg",@"0-1.jpg",@"0-4.jpg",@"0-3.jpg"] placeHoderImageName:nil pageControlShowStyle:UIPageControlShowStyleCenter];
    self.tableView.tableHeaderView = adView;
    _sliderTool = [[NavBarSliderTool alloc]init];
    _sliderTool.barColor = [UIColor redColor];
   
    
    
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
     [_sliderTool setViewController:self scrollview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
