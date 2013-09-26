//
//  EBPeopleDbService.h
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBPeopleModel.h"
#import "EBEventModel.h"
#import "EBBillModel.h"

@interface EBPeopleDbService : NSObject

//插入 姓名
+(BOOL)insertPeople:(EBPeopleModel *)model;
// 删除 人
+(BOOL)deletePeople:(NSString *)peopleId;
// 列表 人名 列表
+(NSMutableArray *)peopleArray;
//根据 人名返回model
+(EBPeopleModel *)getPeopleModel: (NSString *)key;

//插入事件
+(BOOL)insertEvent:(EBEventModel *)model;
// 列表 事件 列表
+(NSMutableArray *)eventArray;
// 删除 事件
+(BOOL)deleteEvent:(NSString *)eventId;
// 根据 事件名返回model
+(EBEventModel*)getEventModel:(NSString*)key;

//插入账本名称
+(BOOL)insertBill:(EBBillModel *)model;
// 列表 账目名 列表
+(NSMutableArray *)billArray;
// 删除 账目
+(BOOL)deletebill:(NSString *)billId;

@end
