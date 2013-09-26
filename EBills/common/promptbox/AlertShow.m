//
//  AlertShow.m
//  My12580_Hotel
//
//  Created by lichunhua on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AlertShow.h"
#import "WCAlertView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AlertShow

void showCustomAlertMessage(NSString *message)
{
    WCAlertView *customAlartView = [WCAlertView showAlertWithTitle:@"温馨提示" message:message customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleLightBlueHatched;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {
            NSLog(@"Cancel");
        } else {
            NSLog(@"Ok");
        }
    } cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    //// TODO: 根据屏幕方向，调整弹出框位置
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationLandscapeLeft == orientation) 
    {
        customAlartView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    else if (UIDeviceOrientationLandscapeRight == orientation) 
    {
        customAlartView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    }
}

void showCustomTitleAlertMessage(NSString *title,NSString *message)
{
    WCAlertView *customAlartView = [WCAlertView showAlertWithTitle:title message:message customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleLightBlueHatched;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {
            NSLog(@"Cancel");
        } else {
            NSLog(@"Ok");
        }
    } cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    //// TODO: 根据屏幕方向，调整弹出框位置
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationLandscapeLeft == orientation)
    {
        customAlartView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    else if (UIDeviceOrientationLandscapeRight == orientation)
    {
        customAlartView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    }
}
@end
