//
//  WordViewController.h
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordViewController : UIViewController

- (void)configureWithWord:(NSString *)text andCallBack:(void(^)(NSString *text))callBack;
@end
