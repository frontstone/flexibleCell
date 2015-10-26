//
//  BaseModel.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithModelType:(ModelType)type andData:(id)data
{
    self = [super init];
    if (self) {
        _type = type;
        _data = data;
    }
    return self;
}
@end
