//
//  EBUtils.m
//  EBills
//
//  Created by Woo on 13-4-24.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBUtils.h"

@implementation EBUtils

//获取当前日期
NSString *getDateString()
{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *nowDate = [formatter stringFromDate:today];
    //    [formatter release];
    
    return nowDate;
}

NSString *getDateId()
{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *nowDate = [formatter stringFromDate:today];
    //    [formatter release];
    
    return nowDate;
}


@end
