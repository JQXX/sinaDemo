//
//  ShouyeViewController.m
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "ShouyeViewController.h"
#import "public.h"
#import "ShouyePublic.h"




#pragma mark
@interface ShouyeViewController ()<UIScrollViewDelegate>
{
    //标题滚动视图
    UIScrollView *_titleScrollView;
    
    //主页面滚动视图
    UIScrollView *_mainScrollView;
    
    //viewController名称数据源
    NSMutableDictionary *_vcDic;
    
    
    //右上角切换频道的btn
    UIView *_changeChannelView;
    BOOL _isTitleScrollViewRightBtnUp;
    
    //频道中的两组数据源
    NSMutableArray *_selectChannelArr;
    NSMutableArray *_deselectchannelArr;
    
    
    //当前选中的btn在_selectChannelArr中的位置
    NSInteger _selectBtnIndex;
    
}


@end

@implementation ShouyeViewController


#pragma mark
#pragma mark 更改状态条颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark
#pragma mark 定制tabbar
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customTabBarItem];
    }
    return self;
}

- (void)customTabBarItem{
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"feed_tab_ico_1_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"feed_tab_ico_1_enabled"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}


#pragma mark
#pragma mark 创建数据源
- (void)createDataSource{
    _selectBtnIndex = 2;
    [self createSelectChannelArr];
    [self createDeselectChannelArr];
    [self createVcArr];
    
}

- (void)createSelectChannelArr{
    _selectChannelArr = [[NSMutableArray alloc]initWithObjects:@"头条",@"推荐",@"视频",@"娱乐",@"体育", nil];

}

- (void)createDeselectChannelArr{
    _deselectchannelArr = [[NSMutableArray alloc]initWithObjects:@"科技",@"汽车",@"图片",@"财经",@"高考",@"游戏",@"军事",@"社会",@"搞笑",@"NBA",@"八卦",@"时尚",@"女性",@"博客",@"数码",@"教育",@"星座",@"家居",@"健康",@"精读",@"专栏",@"育儿",@"收藏",@"历史",@"地方",@"房产", nil];
}

- (void)createVcArr{
    _vcDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"ToutiaoViewController",@"头条",@"TuijianViewController",@"推荐",@"ShipinViewController",@"视频",@"YuleViewController",@"娱乐",@"TiyuViewController",@"体育",@"KejiViewController",@"科技",@"QicheViewController",@"汽车",@"TupianViewController",@"图片",@"CaijingViewController",@"财经",@"GaokaoViewController",@"高考",@"YouxiViewController",@"游戏",@"JunshiViewController",@"军事",@"ShehuiViewController",@"社会",@"GaoxiaoViewController",@"搞笑",@"NBAViewController",@"NBA",@"BaguaViewController",@"八卦",@"ShishangViewController",@"时尚",@"NvxingViewController",@"女性",@"BokeViewController",@"博客",@"ShumaViewController",@"数码",@"JiaoyuViewController",@"教育",@"XingzuoViewController",@"星座",@"JiajuViewController",@"家居",@"JiankangViewController",@"健康",@"JingduViewController",@"精读",@"ZhuanlanViewController",@"专栏",@"YuerViewController",@"育儿",@"ShoucangViewController",@"收藏",@"LishiViewController",@"历史",@"DifangViewController",@"地方",@"FangchanViewController",@"房产", nil];
}



#pragma mark
#pragma  mark 定制导航条
- (void)customNavigationBar{
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIImageView *titileView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 60, 40)];
    titileView.image = [UIImage imageNamed:@"b_logo_ico_normal_night"];
    self.navigationItem.titleView = titileView;
    
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftBtn setImage:[[UIImage imageNamed:@"navi_box_icon_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [leftBtn setImage:[[UIImage imageNamed:@"navi_box_icon_hl"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[[UIImage imageNamed:@"navi_search_icon_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [rightBtn setImage:[[UIImage imageNamed:@"navi_search_icon_hl"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
                                             
    
}

- (void)leftBarBtnClick:(UIButton*)btn{
    
}

- (void)rightBarBtnClick:(UIButton*)btn{
    [self presentViewController:[[SearchViewController alloc]init] animated:YES completion:nil];
}





#pragma mark
#pragma mark 定制标题滚动视图
- (void)customTitleScrollView{
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 40)];
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_titleScrollView];
    

    [self refreshTitleScrollView];
}

- (void)refreshTitleScrollView{
    
    //先将原有的清除
    NSArray *subViews = _titleScrollView.subviews;
    for (UIButton *btn in subViews) {
        [btn removeFromSuperview];
    }
    
    //刷新contentSize
    _titleScrollView.contentSize = CGSizeMake(70*_selectChannelArr.count, 40);
    
    //刷新数据源中的新数据
    for (int i = 0; i < _selectChannelArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(70*i, 5, 40, 30)];
        btn.tag = TitleBtnStartTag + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        [btn setTitle:_selectChannelArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitle:_selectChannelArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [_titleScrollView addSubview:btn];
        
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //刷新titleScrollView的偏移
    [self changeTitleScrollViewContentOffset:_selectBtnIndex];
}

- (void)titleBtnClick:(UIButton*)btn{
    _selectBtnIndex = btn.tag-TitleBtnStartTag;
    
    [self changeChannelViewBtnSelected:_selectBtnIndex];
    [self changeTitleScrollViewContentOffset:_selectBtnIndex];
    [self changeMainScrollViewContentOffset:_selectBtnIndex];
}

- (void)changeTitleScrollViewContentOffset:(NSInteger)btnIndex{
    UIButton *btn = [_titleScrollView viewWithTag:TitleBtnStartTag+btnIndex];
    for (int i = 0; i < _selectChannelArr.count; i++) {
        UIButton *bt = [_titleScrollView viewWithTag:TitleBtnStartTag+i];
        bt.titleLabel.font = [UIFont systemFontOfSize:18];
        [bt setSelected:NO];
    }
    
    [btn setSelected:YES];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    if (btnIndex >= 3) {
        _titleScrollView.contentOffset = CGPointMake(70*(btnIndex-2), 0);
    }
    else{
        _titleScrollView.contentOffset = CGPointMake(0, 0);
    }
}


#pragma mark
#pragma mark定制主页面滚动视图
- (void)customMainScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40-64-49)];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    [self addControllerViewToMainScrollView];
    
}


- (void)addControllerViewToMainScrollView{
    
    NSArray *viewArr = _mainScrollView.subviews;
    for (UIView *view in viewArr) {
        [view removeFromSuperview];
    }
    
    NSArray *vcArr = self.childViewControllers;
    for (UIViewController *vc in vcArr) {
        [vc removeFromParentViewController];
    }
    
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth*_selectChannelArr.count, ScreenHeight-40-64-49);

    
    NSMutableArray *vcView = [[NSMutableArray alloc]init];
    for (int i = 0;i < _selectChannelArr.count;i++) {
        Class cls = NSClassFromString(_vcDic[_selectChannelArr[i]]);
        UIViewController *vc = [[cls alloc]init];
        [self addChildViewController:vc];
        [vcView addObject:vc.view];
    }
    
    
    for (int i = 0; i < vcView.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight-40-64-49)];
        [view addSubview:vcView[i]];
        [_mainScrollView addSubview:view];
    }
    
    //刷新MainScrollView的偏移
    [self changeMainScrollViewContentOffset:_selectBtnIndex];
}

- (void)changeMainScrollViewContentOffset:(NSInteger)btnIndex{
    _mainScrollView.contentOffset = CGPointMake(ScreenWidth*btnIndex, 0);
}



#pragma mark
#pragma mark 定制频道view
- (void)customChannelView{
    _changeChannelView = [[UIView alloc]initWithFrame:CGRectMake(0, -(ScreenHeight-64), ScreenWidth, ScreenHeight-64)];
    _changeChannelView.backgroundColor = [UIColor darkGrayColor];
    _changeChannelView.userInteractionEnabled = YES;
    [self.view addSubview:_changeChannelView];
    
    
    
    
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (_selectChannelArr.count/4+2)*50)];
    upView.backgroundColor = [UIColor lightGrayColor];
    upView.tag = 2;
    [_changeChannelView addSubview:upView];
    
    
    UILabel *uplabell = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    uplabell.text = @"切换频道";
    [upView addSubview:uplabell];
    
    UILabel *uplabelr = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 100, 30)];
    uplabelr.text = @"长按删除";
    uplabelr.font = [UIFont systemFontOfSize:10];
    [upView addSubview:uplabelr];
    
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, upView.bounds.size.height+2, ScreenWidth, _changeChannelView.bounds.size.height-(upView.bounds.size.height+2))];
    downView.backgroundColor = [UIColor lightGrayColor];
    downView.tag = 3;
    [_changeChannelView addSubview:downView];
    
    UILabel *downlabell = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    downlabell.text = @"添加频道";
    [downView addSubview:downlabell];
    
    UILabel *downlabelr = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 100, 30)];
    downlabelr.font = [UIFont systemFontOfSize:10];
    downlabelr.text = @"点击即可快速添加";
    [downView addSubview:downlabelr];
    
    
    int tag = ChannelBtnStartTag;
    for (int i = 0;i < _selectChannelArr.count;i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12+i%4*90, 50+i/4*50, 80, 40)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 5;
        btn.tag = tag++;
        
        [btn setTitle:_selectChannelArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitle:_selectChannelArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_changeChannelView addSubview:btn];
        
        if (btn.tag == ChannelBtnStartTag) {
            [btn setSelected:YES];
        }
        
        [btn addTarget:self action:@selector(channelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGes:)];
        [btn addGestureRecognizer:longPress];
    }
    
    
    
    
    for (int i = 0;i < _deselectchannelArr.count;i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12+i%4*90, upView.bounds.size.height+ 50+i/4*50, 80, 40)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 5;
        btn.tag = tag++;
        
        [btn setTitle:_deselectchannelArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitle:_deselectchannelArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_changeChannelView addSubview:btn];
        
        [btn addTarget:self action:@selector(channelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGes:)];
        [btn addGestureRecognizer:longPress];
    }
}

- (void)channelBtnClick:(UIButton*)btn{
    if ([self isBtnInSelectArr:btn]) {
        
        //关闭ChannelView
        UIButton *rightBtn = [self.view viewWithTag:TitleScrollViewRightBtnTag];
        [self closeChangeChannelView:rightBtn];
        
        
        //将btn本身变为选中状态
        //改变标题滚动视图偏移，并将对应的btn变为选中
        //改变主页面滚动视图偏移
        _selectBtnIndex = 0;
        for (NSString *btnTitle in _selectChannelArr) {
            if ([btn.titleLabel.text isEqualToString:btnTitle]) {
                break;
            }
            _selectBtnIndex++;
        }
        
        [self changeChannelViewBtnSelected:_selectBtnIndex];
        [self changeTitleScrollViewContentOffset:_selectBtnIndex];
        [self changeMainScrollViewContentOffset:_selectBtnIndex];
        
    }
    else{
        //先更新数据源
        [_selectChannelArr addObject:btn.titleLabel.text];
        [_deselectchannelArr removeObject:btn.titleLabel.text];
        

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        
        //重新计算频道上下view的高度并刷新
        UIView *upView = [self.view viewWithTag:ChannelViewUpViewTag];
        upView.frame = CGRectMake(0, 0, ScreenWidth, (_selectChannelArr.count/4+2)*50);
        
        UIView *downView = [self.view viewWithTag:ChannelViewDownViewTag];
        downView.frame = CGRectMake(0, upView.bounds.size.height+2, ScreenWidth, _changeChannelView.bounds.size.height-(upView.bounds.size.height+2));
        
        
        //将添加的btn移动到切换频道中
        btn.frame = CGRectMake(12+(_selectChannelArr.count-1)%4*90, 50+(_selectChannelArr.count-1)/4*50, 80, 40);
        
        //刷新添加频道的downView中的所有btn
        for (int j = 0;j < _deselectchannelArr.count;j++) {
            for (int i = ChannelBtnStartTag; i <= ChannelBtnEndTag; i++) {
                UIButton * but = [self.view viewWithTag:i];
                if ([but.titleLabel.text isEqualToString:_deselectchannelArr[j]]) {
                   but.frame = CGRectMake(12+j%4*90, upView.bounds.size.height+ 50+j/4*50, 80, 40);
                    break;
                }
            }
        }
        
        [UIView commitAnimations];
        
        [self refreshTitleScrollView];
        [self addControllerViewToMainScrollView];
    }
}

- (void)longPressGes:(UILongPressGestureRecognizer*)longPress{
    UIButton *btn = (UIButton*)longPress.view;
    
    //头条btn不能被删除
    if (btn.tag == ChannelBtnStartTag) {
        return;
    }
    
    if ([self isBtnInSelectArr:btn]) {
        //如果btn是选中状态,将btn本身去选中，将头条变为选中
        if (btn.isSelected) {
            _selectBtnIndex = 0;
            [self changeChannelViewBtnSelected:_selectBtnIndex];
        }
        
        //更新数据源
        [_deselectchannelArr addObject:btn.titleLabel.text];
        [_selectChannelArr removeObject:btn.titleLabel.text];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        
        //重新计算频道上下view的高度并刷新
        UIView *upView = [self.view viewWithTag:ChannelViewUpViewTag];
        upView.frame = CGRectMake(0, 0, ScreenWidth, (_selectChannelArr.count/4+2)*50);
        
        UIView *downView = [self.view viewWithTag:ChannelViewDownViewTag];
        downView.frame = CGRectMake(0, upView.bounds.size.height+2, ScreenWidth, _changeChannelView.bounds.size.height-(upView.bounds.size.height+2));
        
        
        //刷新频道的downView中的所有btn
        for (int j = 0;j < _deselectchannelArr.count;j++) {
            for (int i = ChannelBtnStartTag; i <= ChannelBtnEndTag; i++) {
                UIButton * but = [self.view viewWithTag:i];
                if ([but.titleLabel.text isEqualToString:_deselectchannelArr[j]]) {
                    but.frame = CGRectMake(12+j%4*90, upView.bounds.size.height+ 50+j/4*50, 80, 40);
                    break;
                }
            }
        }
        
        
        //刷新频道的upView中的所有btn
        for (int j = 0;j < _selectChannelArr.count;j++) {
            for (int i = ChannelBtnStartTag; i <= ChannelBtnEndTag; i++) {
                UIButton * but = [self.view viewWithTag:i];
                if ([but.titleLabel.text isEqualToString:_selectChannelArr[j]]) {
                    but.frame = CGRectMake(12+j%4*90,50+j/4*50, 80, 40);
                    break;
                }
            }
        }
        
        [UIView commitAnimations];
        
        [self refreshTitleScrollView];
        [self addControllerViewToMainScrollView];
    }
}

- (BOOL)isBtnInSelectArr:(UIButton*)btn{
    for (NSString *btnTitle in _selectChannelArr) {
        if ([btn.titleLabel.text isEqualToString:btnTitle]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)changeChannelViewBtnSelected:(NSInteger)btnIndex{
    
    for (int i = ChannelBtnStartTag; i <= ChannelBtnEndTag; i++) {
        UIButton * but = [self.view viewWithTag:i];
        [but setSelected:NO];
        
        if ([but.titleLabel.text isEqualToString:_selectChannelArr[btnIndex]]) {
            [but setSelected:YES];
        }
    }
}


#pragma mark
#pragma mark 定制标题滚动视图右边的btn
- (void)customTitleScrollViewRightBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(340, 5, 30, 30)];
    btn.tag = 1;
    [self.view addSubview:btn];
    
    
    [btn setBackgroundImage:[UIImage imageNamed:@"feed_tab_ico_subscribe_enabled1"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"feed_tab_ico_subscribe_enabled2"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(15, 12, 0, 0);
    
    [btn addTarget:self action:@selector(titleScrollViewRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)titleScrollViewRightBtnClick:(UIButton*)btn{
    
    if (_isTitleScrollViewRightBtnUp == NO) {
        [self openChangeChannelView:btn];
    }
    else{
        [self closeChangeChannelView:btn];
    }
}

- (void)openChangeChannelView:(UIButton*)btn{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    //改变btn本身的transform
    btn.imageView.transform = CGAffineTransformRotate(btn.imageView.transform, -M_PI);
    
    //动画效果呈现频道切换的view
    _changeChannelView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    
    //设置ncItem的左右btn为禁用
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //隐藏tabbar
    self.tabBarController.tabBar.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 49);
    
    
    _isTitleScrollViewRightBtnUp = YES;
    
    [UIView commitAnimations];
}

- (void)closeChangeChannelView:(UIButton*)btn{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    //恢复btn本身
    btn.imageView.transform = CGAffineTransformRotate(btn.imageView.transform, M_PI);
    
    //动画效果消失频道切换的view
    _changeChannelView.frame = CGRectMake(0, -(ScreenHeight-64), ScreenWidth, ScreenHeight-64);
    
    //设置ncItem的左右btn为恢复
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    //恢复tabbar
    self.tabBarController.tabBar.frame = CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    
     _isTitleScrollViewRightBtnUp = NO;
    
    [UIView commitAnimations];
}


#pragma mark
#pragma mark 主函数
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //automaticallyAdjustsScrollViewInsets根据按所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，不让viewController调整，我们自己修改布局即可~
    self.automaticallyAdjustsScrollViewInsets= NO;
    
    [self createDataSource];
    [self customNavigationBar];
    [self customTitleScrollView];
    [self customMainScrollView];
    [self customChannelView];
    [self customTitleScrollViewRightBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark
#pragma mark scrollView协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _mainScrollView){
        _selectBtnIndex = _mainScrollView.contentOffset.x/ScreenWidth;
        [self changeChannelViewBtnSelected:_selectBtnIndex];
        [self changeTitleScrollViewContentOffset:_selectBtnIndex];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
