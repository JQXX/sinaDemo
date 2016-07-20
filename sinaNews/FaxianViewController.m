//
//  FaxianViewController.m
//  sinaNews
//
//  Created by a on 16/6/21.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "FaxianViewController.h"

@interface FaxianViewController ()

@end

@implementation FaxianViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customTabBarItem];
    }
    return self;
}

- (void)customTabBarItem{
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[[UIImage imageNamed:@"feed_tab_ico_3_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"feed_tab_ico_3_enabled"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
