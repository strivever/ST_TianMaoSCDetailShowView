//
//  DetailViewController.m
//  STNavBar
//
//  Created by StriEver on 16/8/8.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailHeaderView.h"
#import "AdView.h"
#import "BottomTableViewHeaderView.h"
#import "BottomBlurView.h"
#import "StTableViewCell.h"
#import "BottomSectionHeaderView.h"
@interface DetailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    BOOL _isWebShow;
    //是否隐藏NavBar
    BOOL _isHidenNavBar;
    CGFloat _lastContentsetY;
}
@property (nonatomic, strong) DetailHeaderView * headerView;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UITableView * bottomTableView;
@property (nonatomic, strong) BottomBlurView * blurView;
@property (nonatomic, strong) BottomTableViewHeaderView * bottomTableViewheaderView;
@property (nonatomic, strong)UIScrollView * titleView;
@property (nonatomic, strong)NSMutableArray * btnArray;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIView * navView ;
@end
static NSString * const urlString = @"https://detail.m.tmall.com/item.htm?spm=a220m.6910245.0.0.jfDvSY&id=532668401051&skuId=4611686551095788955&pic=//img.alicdn.com/bao/uploaded/i4/1795616675/TB2mtFipVXXXXarXXXXXXXXXXXX-1795616675.jpg_250x250Q30.jpg&itemTitle=%E3%80%90%E6%98%93%E6%9E%9C%E7%94%9F%E9%B2%9C%E3%80%91%E7%BE%8E%E5%9B%BD%E5%8D%8E%E7%9B%9B%E9%A1%BF%E6%A8%B1%E6%A1%832kg%20%E6%9E%9C%E5%BE%84%E7%BA%A626.5mm%20%E8%BD%A6%E5%8E%98%E5%AD%90&price=156.00&from=h5";
static NSString * const cellID = @"StTableViewCell";
@implementation DetailViewController
- (void)dealloc{
    NSLog(@"DetailViewController释放啦");
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    self.webView.delegate = nil;
    [self.webView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏黑线
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    self.navigationController.navigationBar.clipsToBounds = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.headerView = (DetailHeaderView *)[DetailHeaderView view];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor clearColor];
    _bottomTableViewheaderView = [BottomTableViewHeaderView view];
    self.bottomTableView.tableHeaderView = _bottomTableViewheaderView;
    [self blurView];
    __weak typeof(self) weakSelf = self;
    _blurView.viewTouchEvent = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setTableViewFrameWithType:0];
        strongSelf.bottomTableView.contentOffset = CGPointZero;
        strongSelf.bottomTableView.hidden = YES;
    };
    [self setNavTitleView];
    [self webView];
    [self setScrollViewAdview];
    
    //导航条
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 64)];
    _navView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:_navView atIndex:self.view.subviews.count];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"ar_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}
#pragma mark ---gettter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kUIScreenHeight - 64)];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.delegate = self;
        _webView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (UITableView *)bottomTableView{
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - 120)style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
       // _bottomTableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0);
        _bottomTableView.backgroundColor = [UIColor whiteColor];
        [_bottomTableView registerNib:[UINib nibWithNibName:@"StTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        [self.view insertSubview:_bottomTableView belowSubview:self.tableView];
    }
    return _bottomTableView;
}
- (BottomBlurView *)blurView{
    if (!_blurView) {
        _blurView = [[BottomBlurView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bottomTableView.frame),kUIScreenWidth, 120) backImage:[UIImage imageNamed:@"0-0.jpg"]];
        _blurView.hidden = YES;
        [self.view insertSubview:_blurView belowSubview:self.tableView];
    }
    return _blurView;
}
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = @[].mutableCopy;
    }
    return _btnArray;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.frame = CGRectMake(0, 43, 50, 1);
        [_titleView addSubview:_lineView];
    }
    return _lineView;
}
#pragma mark ---UI
- (void)setNavTitleView{
    _titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    _titleView.contentSize = CGSizeMake(0, 44 * 2);
    self.navigationItem.titleView = _titleView;
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *(50 + 5), 0, 50, 44);
        [button setTitle:@[@"商品",@"详情",@"评价"][i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_titleView addSubview:button];
        [button addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
    }
    UILabel * label = [UILabel new];
    label.text = @"图文详情";
    label.frame = CGRectMake(0, 44 + 0, 160, 44);
    label.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:label];
    UIButton * btn = self.btnArray[0];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.lineView.x = btn.x;
}
- (void)setScrollViewAdview{
    AdView * adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, kUIScreenWidth,kUIScreenWidth) imageLinkURL:@[@"IMG_0691.JPG",@"IMG_0692.JPG",@"IMG_0693.JPG",@"IMG_0694.JPG",@"IMG_0695.JPG",@"IMG_0696.JPG"] placeHoderImageName:nil pageControlShowStyle:UIPageControlShowStyleCenter];
    
    [self.headerView.adBackView addSubview:adView];
}
- (void)btnActions:(UIButton *)btn{
    for (UIButton * btn in self.btnArray) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:.2 animations:^{
      self.lineView.x = btn.x;
    }];
    
}

- (void)setViewsFrame{
    CGRect currentWebFrame = CGRectMake(0, 64, kUIScreenWidth, kUIScreenHeight - 64);
    CGRect oldWebFrame = CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kUIScreenHeight);
    
    CGRect oldTabViewFrame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight);
    CGRect newTableViewFrame = CGRectMake(0, -kUIScreenHeight, kUIScreenWidth, kUIScreenHeight);
    if (_isWebShow) {
        [UIView animateWithDuration:.5 animations:^{
            self.webView.frame = currentWebFrame;
            self.tableView.frame = newTableViewFrame;
            self.titleView.contentOffset = CGPointMake(0, 44);
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            self.webView.frame = oldWebFrame;
            self.tableView.frame = oldTabViewFrame;
            self.titleView.contentOffset = CGPointMake(0, 0);
        }];
    }
    _lineView.hidden = _isWebShow;
}
- (void)setTableViewFrameWithType:(NSInteger)type{
    //type = 0 设置frame当前屏幕   type = 1 溢出屏幕
    CGRect oldFrame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight);
    CGRect newFrame = CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kUIScreenHeight);
    if (type == 1) {
        self.tableView.delegate = nil;
        self.bottomTableViewheaderView.alpha = 1;
        self.blurView.hidden = NO;
    }else{
        self.tableView.delegate = self;
        self.blurView.hidden = YES;
        self.navView.alpha = self.navigationController.navigationBar.alpha = 1;
        self.bottomTableViewheaderView.alpha = 0;
    }
    [UIView animateWithDuration:.2 animations:^{
        self.tableView.frame = type == 0 ? oldFrame : newFrame;
    }];
}
#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        [_headerView upDateBottomViewContraint:scrollView.contentOffset.y + 64];
        if (scrollView.contentOffset.y <= -64) {
            self.navView.alpha = self.navigationController.navigationBar.alpha = 1- (fabs(scrollView.contentOffset.y)- 64)/20.0;
            self.bottomTableView.hidden = NO;
            self.bottomTableViewheaderView.alpha = (fabs(scrollView.contentOffset.y) - 84)/25;
        }else{
            self.navView.alpha = self.navigationController.navigationBar.alpha = 1;
            self.bottomTableView.hidden = YES;
        }
        
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.webView.scrollView) {
        if (scrollView.contentOffset.y < -120) {
            _isWebShow = NO;
            [self setViewsFrame];
        }
    }else if (scrollView == self.tableView){
        NSLog(@"%f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y >= self.tableView.contentSize.height - kUIScreenHeight) {
            _isWebShow = YES;
            [self setViewsFrame];
        }
        if (scrollView.contentOffset.y < - 160) {
            [self setTableViewFrameWithType:1];
        }
    }
    
    
}
#pragma mark ---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _bottomTableView) {
        return 100;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _bottomTableView) {
        StTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _bottomTableView) {
        return (kUIScreenWidth - 5)/2.0 + 5 + 35 + 20;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _bottomTableView) {
        BottomSectionHeaderView * view = [[BottomSectionHeaderView alloc]init];
        return view;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _bottomTableView) {
        return 100;
    }
    return 0;
}
#pragma mark ---UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 防止内存飙升
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma mark ---buttonAction
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
