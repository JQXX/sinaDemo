//
//  MineShoucangNextViewController.m
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "MineShoucangNextViewController.h"
#import "public.h"

@interface MineShoucangNextViewController ()

@end

@implementation MineShoucangNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNc];
    [self createWebView];
}

- (void)customNc{
    self.navigationItem.title = @"新浪新闻";
}



- (void)createWebView{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    [self.view addSubview:web];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    
    [web loadRequest:request];
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
