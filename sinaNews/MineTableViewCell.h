//
//  MineTableViewCell.h
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UISwitch *sw;


@property (copy) void(^swChangeBlock)(BOOL);


@end
