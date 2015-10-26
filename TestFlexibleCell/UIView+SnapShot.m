//
//  UIView+SnapShot.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "UIView+SnapShot.h"

@implementation UIView (SnapShot)


+ (UIView *)customSnapshoFromView:(UIView *)originView
{
    UIGraphicsBeginImageContextWithOptions(originView.bounds.size, NO, 0);
    [originView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;

}

@end
