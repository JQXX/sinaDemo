//
//  ShipinTableViewCell.h
//  sinaNews
//
//  Created by a on 16/6/23.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipinTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *playnumber;

@property (weak, nonatomic) IBOutlet UIImageView *pic;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@property (copy)void (^playBlock)();
@property (copy)void (^shareBlock)();
@property (copy)void (^commentBlock)();




@end
