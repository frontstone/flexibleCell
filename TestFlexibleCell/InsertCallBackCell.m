//
//  InsertCallBackCell.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "InsertCallBackCell.h"
#import "BaseModel.h"

@interface InsertCallBackCell()
@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, copy) void(^AddBlock)(NSIndexPath *indexPath);

@end
@implementation InsertCallBackCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.textView.hidden = YES;
    self.showImageView.hidden = YES;
}

+ (UINib *)Nib
{
    return [UINib nibWithNibName:@"InsertCallBackCell" bundle:nil];
}

- (IBAction)addOptionCell:(id)sender {
    
    if (self.AddBlock) {
        self.AddBlock(self.indexPath);
    }
}


- (void)configureWithBaseModel:(BaseModel *)model indexPath:(NSIndexPath *)indexPath andInsertOptionBlock:(void(^)(NSIndexPath *indexPathCallBack))optionblock
{
    if (model.type == ModelTypeWord) {
        self.textView.hidden = NO;
        self.showImageView.hidden = YES;
        self.textView.text = model.data;
    }else if (model.type == ModelTypeImage){
        self.showImageView.hidden = NO;
        self.textView.hidden = YES;
        self.showImageView.image = model.data;
    }
    self.indexPath = indexPath;
    self.AddBlock = optionblock;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
