//
//  EBBillModel.h
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBBillModel : NSObject

@property (nonatomic,strong) NSString* billName; //账目名
@property (nonatomic,strong) NSString* billId;
@property (nonatomic,strong) NSString* billDate; //记账日期
@property (nonatomic,strong) NSString* billPeople; //记账人
@property (nonatomic,strong) NSString* billPeopleId;
@property (nonatomic,strong) NSString* billDetails; //账目详情
@property (nonatomic,strong) NSString* billDbName; //数据库表单名称

-(void)initEmptyValue;
@end
