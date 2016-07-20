//
//  MineShoucangViewController.m
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "MineShoucangViewController.h"
#import "MineShoucangNextViewController.h"
#import "MineShoucangTableViewCell.h"
#import "public.h"

@interface MineShoucangViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}


@end

@implementation MineShoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNc];
    [self createDB];
    [self createDataSource];
    [self createTableView];
}

- (void)customNc{
    self.navigationItem.title = @"收藏";
}



- (void)createDB{
    [MagicalRecord setupCoreDataStackWithStoreNamed:SHOUCANG_DBPATH];
}



//删除一条数据
- (void)deleteData:(ShouCangModelData*)data{

    [data MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)createDataSource{
    _dataSource = [[NSMutableArray alloc]initWithArray:[ShouCangModelData MR_findAll]];
}


- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineShoucangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineShoucangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ShouCangModelData *model = _dataSource[indexPath.row];
    cell.title.text = model.titl;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineShoucangNextViewController *shoucangNext = [[MineShoucangNextViewController alloc]init];
    
    ShouCangModelData *model = _dataSource[indexPath.row];
    shoucangNext.link = model.link;
    
    [self.navigationController pushViewController:shoucangNext animated:YES];

}



- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    UITableViewRowAction *row = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self deleteData:_dataSource[indexPath.row]];
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return @[row];
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
