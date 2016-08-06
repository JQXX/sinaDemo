//
//  ToutiaoViewController.m
//  sinaNews
//
//  Created by a on 16/6/22.
//  Copyright © 2016年 J. All rights reserved.
//

#import "ToutiaoViewController.h"

#import "headLinePageScroViewModel.h"
#import "headLinePageTableViewModel.h"

#import "headLinePageTableViewCell.h"

#import "public.h"

@interface ToutiaoViewController () <UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_headLinePageScroViewDataSource;
    NSMutableArray *_headLinePageTableViewDataSource;
    
    UITableView *_mainPageTableView;
}

@end

@implementation ToutiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _headLinePageScroViewDataSource = [[NSMutableArray alloc]init];
    _headLinePageTableViewDataSource = [[NSMutableArray alloc]init];
    
    [self creatMainTableView];
    [self anaysisData];
    
}

- (void)creatMainTableView {
    
    _mainPageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_mainPageTableView];
    _mainPageTableView.delegate     = self;
    _mainPageTableView.dataSource   = self;
    _mainPageTableView.rowHeight    = 80;
    [_mainPageTableView registerNib:[UINib nibWithNibName:@"headLinePageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"headLinePageCell"];
    [self creatHeadLineScroView:_mainPageTableView];
    
}

#pragma mark 创建头条页头部滚动视图
-(void)creatHeadLineScroView:(UITableView *)tableView{
    
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    tableView.tableHeaderView = scroView;
    scroView.delegate = self;
    scroView.contentSize = CGSizeMake(ScreenWidth * 5, 0);
    scroView.pagingEnabled = YES;
    scroView.tag = 150;
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, 200)];
        [scroView addSubview:imageView];
        imageView.tag = 151+i;
    }
    
    
}


#pragma mark 解析网络
-(void)anaysisData{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:SHOUYE_TOUTIAO parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dataDic = jsDic[@"data"];
        NSArray *focusArr = dataDic[@"focus"];
        int n = 0;
        for (NSDictionary *dic in focusArr) {
            
            headLinePageScroViewModel *hdScModel = [[headLinePageScroViewModel alloc]init];
            hdScModel.title = dic[@"title"];
            hdScModel.picUrl = dic[@"pic"];
            hdScModel.link = dic[@"link"];
            NSDictionary *picsDic = dic[@"pics"];
            hdScModel.picTotal = [NSString stringWithFormat:@"%@",picsDic[@"total"]];
            
            [_headLinePageScroViewDataSource addObject:hdScModel];
            
            UIImageView *imageView = [self.view viewWithTag:151+n];
            [imageView sd_setImageWithURL:[NSURL URLWithString:hdScModel.picUrl]];
            n++;
            
        }
        
        NSArray *feedArr = dataDic[@"feed"];
        for (NSDictionary *dic in feedArr) {
            
            headLinePageTableViewModel *tabModel = [[headLinePageTableViewModel alloc]init];
            tabModel.title = dic[@"title"];
            tabModel.intro = dic[@"intro"];
            tabModel.picUrl = dic[@"pic"];
            tabModel.link = dic[@"link"];
            //            NSLog(tabModel.title);
            
            [_headLinePageTableViewDataSource addObject:tabModel];
            
        }
        
        [_mainPageTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];
    
}

#pragma mark tableView实现方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _headLinePageTableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headLinePageCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"headLinePageCell"];
    }
    
    
//    headLinePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headLinePageCell"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[_headLinePageTableViewDataSource [indexPath.row] picUrl]]];
    cell.textLabel.text = [_headLinePageTableViewDataSource[indexPath.row] title];
    cell.detailTextLabel.text = [_headLinePageTableViewDataSource[indexPath.row] intro];
    
    
    return cell;
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
