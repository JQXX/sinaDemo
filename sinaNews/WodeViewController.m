//
//  WodeViewController.m
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import "WodeViewController.h"
#import "MineShoucangViewController.h"
#import "LoginViewController.h"
#import "MineTableViewCell.h"
#import "public.h"

#import "UMSocial.h"
#import "UMSocialShakeService.h"
#import "UMSocialScreenShoter.h"



@interface WodeViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialShakeDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    
    BOOL _isLoginStatus;
}

@end

@implementation WodeViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customTabBarItem];
    }
    return self;
}

- (void)customTabBarItem{
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"feed_tab_ico_4_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"feed_tab_ico_4_enabled"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNc];
    [self createDataSource];
    [self createTableView];
}

- (void)customNc{
    self.navigationItem.title = @"我的";
}

- (void)createDataSource{
    _dataSource = [[NSMutableArray alloc]initWithObjects:@"收藏",@"清除缓存",@"摇一摇", nil];
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self customTableHeaderView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)customTableHeaderView{
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _tableView.tableHeaderView = login;
    
    login.backgroundColor = [UIColor redColor];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleEdgeInsets = UIEdgeInsetsMake(100, 0, 0, 70);
    login.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 50, 0);
    
    [self loginStatus:login];
    
    
    [login addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)logIn:(UIButton*)btn{
    LoginViewController *log = [[LoginViewController alloc]init];
    log.isLogin = _isLoginStatus;
    
    log.loginSuccBlock = ^(){
        [self loginStatus:btn];
    };
    
    [self.navigationController pushViewController:log animated:YES];
}


- (void)loginStatus:(UIButton*)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [user objectForKey:@"user"];

    if (!dic) {
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"head2x"] forState:UIControlStateNormal];
        _isLoginStatus = NO;
    }
    else{
        [btn setTitle:dic[@"userName"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"iconURL"]]]] forState:UIControlStateNormal];
        _isLoginStatus = YES;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.title.text = _dataSource[indexPath.row];
    if ([_dataSource[indexPath.row] isEqualToString:@"摇一摇"]) {
        cell.sw.hidden = NO;
    }
    
    cell.swChangeBlock = ^(BOOL isOn){
        if ([_dataSource[indexPath.row] isEqualToString:@"摇一摇"]) {
            if (isOn) {
               
                //[UMSocialShakeService setShakeToShareWithTypes:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] shareText:@"精彩瞬间，摇摇分享，来自摇摇分享组件" screenShoter:[UMSocialScreenShoterDefault screenShoter] inViewController:self delegate:nil];
                
                
                [UMSocialShakeService setShakeToShareWithTypes:nil shareText:nil screenShoter:nil inViewController:self delegate:self];
                
                //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
                [UMSocialShakeService setShakeThreshold:0.8];
            }
            else{
                [UMSocialShakeService unShakeToSns];
            }
        }
    };
    
    return cell;
}



//在摇一摇的回调方法弹出分享面板
-(UMSocialShakeConfig)didShakeWithShakeConfig
{
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5731a50667e58e2af10007f0" shareText:@"精彩瞬间，摇摇分享，来自摇摇分享组件" shareImage:image shareToSnsNames:@[UMShareToQzone,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
    
    //下面返回值控制是否显示分享编辑页面、是否显示截图、是否有音效，UMSocialShakeConfigNone表示都不显示
    return UMSocialShakeConfigShowScreenShot;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataSource[indexPath.row] isEqualToString:@"清除缓存"]) {
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小:%.2fM,确定要清除缓存吗?",[self folderSizeAtPath:cachPath]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clearCache:cachPath];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
        
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if ([_dataSource[indexPath.row] isEqualToString:@"收藏"]){
        MineShoucangViewController *shoucang = [[MineShoucangViewController alloc]init];
        [self.navigationController pushViewController:shoucang animated:YES];
    }
}



//计算目录大小
- (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//清理缓存文件
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
