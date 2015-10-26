//
//  OptionTableViewCell.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "OptionTableViewCell.h"

@implementation OptionTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)optionAction:(UIButton *)sender {
    
    if (self.SelectBlock) {
        self.SelectBlock(sender.tag);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
