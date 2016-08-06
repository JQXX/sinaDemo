//
//  RemenCellPushViewController.m
//  sinaNews
//
//  Created by a on 16/6/29.
//  Copyright © 2016年 J. All rights reserved.
//

#import "RemenCellPushViewController.h"
#import "public.h"

@interface RemenCellPushViewController ()
{
    BOOL isShoucang;
}

@end

@implementation RemenCellPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createDB];
    [self customNc];
    [self createWebView];
}

- (void)customNc{
    self.navigationItem.title = self.rankid;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightBarBtnClick)];
}

- (void)rightBarBtnClick{
    if (isShoucang == NO) {
        [self insertDataWith:self.titl andLink:self.link];
        isShoucang = YES;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(rightBarBtnClick)];
    }
    else{
        [self deleteData];
        isShoucang = NO;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightBarBtnClick)];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    isShoucang = NO;
}


- (void)createWebView{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    [self.view addSubview:web];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    
    [web loadRequest:request];
}



- (void)createDB{
    [MagicalRecord setupCoreDataStackWithStoreNamed:SHOUCANG_DBPATH];
}


//向表中添加一条数据
- (void)insertDataWith:(NSString *)title andLink:(NSString *)link{
    
    ShouCangModelData *data = [ShouCangModelData MR_createEntity];
    data.titl = title;
    data.link = link;
    
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


//删除一条数据
- (void)deleteData{
    NSArray *ret = [ShouCangModelData MR_findAll];
    ShouCangModelData *data = ret.lastObject;
    [data MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
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
