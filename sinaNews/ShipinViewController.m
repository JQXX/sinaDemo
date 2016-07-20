//
//  ShipinViewController.m
//  sinaNews
//
//  Created by a on 16/6/22.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "ShipinViewController.h"
#import "ShipinTableViewCell.h"
#import "ShipinCellModel.h"
#import "ShipinCellModelData.h"
#import "public.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>



@interface ShipinViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_tableViewDataSource;
    
    AVPlayerViewController *_avPlayer;
    
    NSInteger _currentCellSection;
}

@end

@implementation ShipinViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDataSource];
    [self createTableView];
    [self createAvplayer];
    [self analysizeData];
}


- (void)createDataSource{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"shipinCellModelData.sqlite"];
    _tableViewDataSource = [NSMutableArray arrayWithArray:[self queryAllData]];
}


//向表中添加一条数据
- (void)insertData:(ShipinCellModel*)model{
    
    ShipinCellModelData *data = [ShipinCellModelData MR_createEntity];
    data.title = model.title;
    data.url = model.url;
    data.pic = model.pic;
    data.link = model.link;
    data.playnumber = model.playnumber;
    
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

//删除所有数据
- (void)deleteData{
    NSArray *ret = [ShipinCellModelData MR_findAll];
    for (ShipinCellModelData *data in ret) {
        [data MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    }
}

//查询所有数据
- (NSArray *)queryAllData{
    NSArray *ret = [ShipinCellModelData MR_findAll];
    
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (ShipinCellModelData *data in ret) {
        ShipinCellModel *model = [[ShipinCellModel alloc]init];
        model.title = data.title;
        model.url = data.url;
        model.pic = data.pic;
        model.link = data.link;
        model.playnumber = data.playnumber;
        [result addObject:model];
    }
    
    return result;
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-40-64-49) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ShipinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

- (void)createAvplayer{
     _avPlayer = [[AVPlayerViewController alloc]init];
    _avPlayer.view.frame = CGRectMake(0, 30, ScreenWidth, 180);
}

- (void)analysizeData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:SHOUYE_SHIPIN parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (!dic) {
            return ;
        }
        else{
            //清空数据库
             [self deleteData];
        }
       
        
        NSDictionary *data = dic[@"data"];
        NSArray *feed = data[@"feed"];
        for (NSDictionary *news in feed) {
            ShipinCellModel *model = [[ShipinCellModel alloc]init];
            model.title = news[@"title"];
            model.pic = news[@"pic"];
            model.link = news[@"link"];
            
            NSDictionary *videoInfo = news[@"videoInfo"];
            NSNumber *playnum = videoInfo[@"playnumber"];
            model.playnumber = [NSString stringWithFormat:@"%d万",playnum.intValue/10000];
            model.url = videoInfo[@"url"];
            
            //写数据库
            [self insertData:model];
        }
        _tableViewDataSource = [NSMutableArray arrayWithArray:[self queryAllData]];
        
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
     ShipinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    ShipinCellModel *model = _tableViewDataSource[indexPath.section];
    cell.title.text = model.title;
    cell.playnumber.text = model.playnumber;
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    
    //播放
    __block UIView *view = cell.contentView;
    cell.playBlock = ^(){
         _avPlayer.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:model.url]];
        [view addSubview:_avPlayer.view];
        [_avPlayer.player play];
        _currentCellSection = indexPath.section;
    };
    
    
    //分享
    cell.shareBlock = ^(){
        [UMSocialData defaultData].extConfig.title = model.title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = model.link;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = model.link;
        
        [UMSocialData defaultData].extConfig.qqData.url = model.link;
        [UMSocialData defaultData].extConfig.qzoneData.url = model.link;
        
        
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeNone;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeNone;
        
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.pic]]];
        [UMSocialSnsService presentSnsIconSheetView:self
            appKey:@"5731a50667e58e2af10007f0"
                    shareText:model.title
                    shareImage:image
                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToRenren,UMShareToSms,UMShareToTencent,UMShareToQzone,UMShareToQQ]
                                           delegate:nil];
    };
    
    
    //评论
    cell.commentBlock = ^(){
        UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:model.title];
        UMSocialControllerServiceComment *socialControllerService = [[UMSocialControllerServiceComment alloc] initWithUMSocialData:socialData];
        
        UINavigationController *commentList = [socialControllerService getSocialCommentListController];
        [self presentViewController:commentList animated:YES completion:nil];
    };
    
    
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

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){
    if(_currentCellSection == indexPath.section){
        [_avPlayer.player pause];
        [_avPlayer.view removeFromSuperview];
    }
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
