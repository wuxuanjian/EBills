//
//  EBBillDetailsModel.h
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBBillDetailsModel : NSObject

@property (nonatomic,strong) NSString* detailsEvent;    //事项
@property (nonatomic,strong) NSString* detailsEventId;
@property (nonatomic,strong) NSString* detailsPeople;   //垫付人
@property (nonatomic,strong) NSString* detailsPeopleId;
@property (nonatomic,strong) NSString* detailsMoney;    //金额
@property (nonatomic,strong) NSString* detailsDate;     //日期
@property (nonatomic,strong) NSString* detailsExPlain;  //简介
@property (nonatomic,strong) NSString* detailsId;       //单项事项id
-(void)initEmptyValue;
@end
