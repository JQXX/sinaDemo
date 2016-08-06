//
//  LoginViewController.m
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 J. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"

#import "public.h"
#import "UMSocial.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNc];
    [self createDataSource];
    [self createTableView];
}

- (void)customNc{
    self.navigationItem.title = @"登录";
}


- (void)createDataSource{
    if (self.isLogin) {
        _dataSource = [[NSMutableArray alloc]initWithObjects:@"退出登录", nil];
    }else{
        _dataSource = [[NSMutableArray alloc]initWithObjects:@"手机号",@"微信",@"QQ",@"新浪微博", nil];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    
    [_tableView registerNib:[UINib nibWithNibName:@"LoginTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.title.text = _dataSource[indexPath.row];
    
    cell.swChangeBlock = ^(BOOL isOn){
        if ([_dataSource[indexPath.row] isEqualToString:@"QQ"]) {
            [self QQLogin];
        }
        else if ([_dataSource[indexPath.row] isEqualToString:@"手机号"]){
            [self telphoneLogin];
        }
        else if([_dataSource[indexPath.row] isEqualToString:@"退出登录"]){
            [self logOut];
        }
    };
    
    return cell;
}

- (void)QQLogin{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [dict valueForKey:snsPlatform.platformName];

            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:snsAccount.usid,@"usid",snsAccount.accessToken,@"accessToken",snsAccount.userName,@"userName",snsAccount.iconURL,@"iconURL", nil];

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:dic forKey:@"user"];
            [user synchronize];
            
            self.loginSuccBlock();

            [self.navigationController popViewControllerAnimated:YES];
        }});
}

- (void)telphoneLogin{
    
}

- (void)logOut{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    [user removeObjectForKey:@"user"];
    [user synchronize];
    
    self.loginSuccBlock();
    
    [self.navigationController popViewControllerAnimated:YES];
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
