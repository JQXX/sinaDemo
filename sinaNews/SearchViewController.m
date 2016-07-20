//
//  SearchViewController.m
//  sinaNews
//
//  Created by a on 16/6/23.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "SearchViewController.h"
#import "public.h"

@interface SearchViewController ()<UISearchBarDelegate,UISearchControllerDelegate>
{
    //搜索控制器
    UISearchController *_searchBarController;
}
@end

@implementation SearchViewController



#pragma mark
#pragma mark 创建搜索页面
- (void)createSearchView{
    
    _searchBarController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    _searchBarController.searchBar.showsCancelButton = YES;
    _searchBarController.hidesNavigationBarDuringPresentation =NO;
    _searchBarController.delegate = self;
    _searchBarController.searchBar.delegate = self;

    [self.view addSubview:_searchBarController.searchBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor grayColor];
    
    [self createSearchView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
     _searchBarController.active = YES;
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark searchBar协议方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED{
   
    [self dismissViewControllerAnimated:YES completion:nil];
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
