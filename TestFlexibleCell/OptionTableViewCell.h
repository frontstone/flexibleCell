//
//  OptionTableViewCell.h
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,OptionType) {
    OptionTypeWord,
    OptionTypeImage,
    OptionTypeProduct,
    OptionTypeVideo,
};

@interface OptionTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^SelectBlock)(OptionType type);

@end
