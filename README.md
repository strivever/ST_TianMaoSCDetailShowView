# ST_TianMaoSCDetailShowView
1.快速集成导航栏滑动渐变效果  
![导航栏渐变效果](https://github.com/strivever/ST_TianMaoSCDetailShowView/blob/master/STNavBar/GIF/3.6__TM_02.gif)
2.完整实现了仿天猫购物商城商品展示界面  
![导航栏渐变效果](https://github.com/strivever/ST_TianMaoSCDetailShowView/blob/master/STNavBar/GIF/3.6__TM_03.gif)
####封装了NavBarSliderTool 快捷集成导航栏滑动效果  
<使用方法 1. 设置ViewController一个实例变量`@property (nonatomic, strong)NavBarSliderTool * sliderTool;` 2.`_sliderTool = [[NavBarSliderTool alloc]init]; _sliderTool.barColor = [UIColor redColor];` 3. `[_sliderTool setViewController:self scrollview:self.tableView];`
