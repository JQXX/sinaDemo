//
//  LoginViewController.h
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property BOOL isLogin;

@property (copy)void(^loginSuccBlock)();

@end
