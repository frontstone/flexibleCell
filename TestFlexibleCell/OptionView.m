//
//  OptionView.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "OptionView.h"

@implementation OptionView

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%@",NSStringFromCGRect( self.frame));
}

- (IBAction)optionAction:(UIButton *)sender {
    if (self.SelectBlock) {
        self.SelectBlock(sender.tag);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
