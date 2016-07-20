//
//  LoginTableViewCell.m
//  sinaNews
//
//  Created by a on 16/6/30.
//  Copyright © 2016年 yuzhanjie. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)swChangeValue:(UISwitch *)sender {
    self.swChangeBlock(sender.isOn);
}

@end
