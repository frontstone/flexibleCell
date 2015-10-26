//
//  BaseModel.h
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ModelType) {
    ModelTypeWord,
    ModelTypeImage,
    ModelTypeProduct,
    ModelTypeVideo,
    ModelTypeOption,
};

@interface BaseModel : NSObject

@property (nonatomic, assign) ModelType type;
@property (nonatomic, strong) id data;

- (instancetype)initWithModelType:(ModelType)type andData:(id)data;
@end
