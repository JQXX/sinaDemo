//
//  ToutiaoViewController.m
//  sinaNews
//
//  Created by a on 16/6/22.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "ToutiaoViewController.h"
#import "ToutiaoTableViewCell.h"
#import "public.h"


@interface ToutiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_tableViewDataSource;
}

@end

@implementation ToutiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self createDataSource];
    [self createTableView];
}

- (void)createDataSource{
    _tableViewDataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i < 100; i++) {
        [_tableViewDataSource addObject:[NSString stringWithFormat:@"第%d行",i+1]];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-40-64-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ToutiaoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ToutiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _tableViewDataSource[indexPath.row];
    
    return cell;
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
