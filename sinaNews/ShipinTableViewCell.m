//
//  ShipinTableViewCell.m
//  sinaNews
//
//  Created by a on 16/6/23.
//  Copyright © 2016年 J. All rights reserved.
//

#import "ShipinTableViewCell.h"

@implementation ShipinTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)playAudio:(UIButton *)sender {
    self.playBlock();
}


- (IBAction)share:(UIButton *)sender {
    self.shareBlock();
}


- (IBAction)comment:(UIButton *)sender {
    self.commentBlock();
}



@end
