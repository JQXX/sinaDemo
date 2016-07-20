//
//  RemenTableViewCell.h
//  sinaNews
//
//  Created by a on 16/6/29.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemenTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UILabel *posStatus;

@property (weak, nonatomic) IBOutlet UILabel *rankid;

@property (weak, nonatomic) IBOutlet UILabel *title;


@property (weak, nonatomic) IBOutlet UILabel *time;


@property (weak, nonatomic) IBOutlet UILabel *intro;



@end
