//
//  InsertCallBackCell.h
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface InsertCallBackCell : UITableViewCell

- (void)configureWithBaseModel:(BaseModel *)model indexPath:(NSIndexPath *)indexPath andInsertOptionBlock:(void(^)(NSIndexPath *indexPathCallBack))optionblock;

+ (UINib *)Nib;

@end
