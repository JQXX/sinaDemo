//
//  RemenViewController.m
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "RemenViewController.h"
#import "RemenCellPushViewController.h"

#import "RemenTableViewCell.h"
#import "RemenTableViewCellModel.h"
#import "public.h"


@interface RemenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_tableViewDataSource;
}


@end

@implementation RemenViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customTabBarItem];
    }
    return self;
}

- (void)customTabBarItem{
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"热门" image:[[UIImage imageNamed:@"feed_tab_ico_2_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"feed_tab_ico_2_enabled"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNc];
    [self createDataSource];
    [self createTableView];
    [self analysizeData];
}

- (void)customNc{
    self.navigationItem.title = @"热门";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}


- (void)createDataSource{
    _tableViewDataSource = [[NSMutableArray alloc]init];
}


- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RemenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}


- (void)analysizeData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:REMEN parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (!dic) {
            return ;
        }
        
        
        NSDictionary *data = dic[@"data"];
        NSArray *list = data[@"list"];
        for (NSDictionary *news in list) {
            RemenTableViewCellModel *model = [[RemenTableViewCellModel alloc]init];
            model.title = news[@"title"];
            model.pic = news[@"pic"];
            model.link = news[@"link"];
            model.time = news[@"time"];
            
            NSString *rankid = news[@"rankId"];
            NSRange rag = [rankid rangeOfString:@"-"];
            NSRange rag2 = {rag.location+1,1};
            model.rankId = [NSString stringWithFormat:@"TOP %@",[rankid substringWithRange:rag2]];
            
            model.intro = news[@"intro"];
            model.posStatus = [NSString stringWithFormat:@"%@",news[@"posStatus"]];
            
            [_tableViewDataSource addObject:model];
           
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableViewDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    RemenTableViewCellModel *model = _tableViewDataSource[indexPath.section];

    [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.rankid.text = model.rankId;
    cell.posStatus.text = model.posStatus;
    cell.time.text = model.time;
    cell.title.text = model.title;
    cell.intro.text = model.intro;
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RemenCellPushViewController *nextVC = [[RemenCellPushViewController alloc]init];
    nextVC.link = [_tableViewDataSource[indexPath.section] link];
    nextVC.titl = [_tableViewDataSource[indexPath.section] title];
    nextVC.rankid = [_tableViewDataSource[indexPath.section] rankId];

    
    [self.navigationController pushViewController:nextVC animated:YES];
}



-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
