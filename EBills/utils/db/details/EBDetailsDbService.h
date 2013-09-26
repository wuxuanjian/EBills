//
//  EBDetailsDbService.h
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBBillDetailsModel.h"

@interface EBDetailsDbService : NSObject

// 创建表
+(void) createForm:(NSString*)billFormName;
//插入
+(BOOL)insertDetails:(EBBillDetailsModel *)model tableName:(NSString*)billFormName;
// 列表
+(NSMutableArray *)detailsArray:(NSString*)billFormName;
// 删除
+(BOOL)deletedetails:(NSString *) peopleId tableName:(NSString*)billFormName;
//查找到不重复的人 （去重）
+(NSMutableArray*) detailsNameDistinct:(NSString*)billFormName;
//查找一个人的 账目
+(NSArray *)getPeopleDetailsModel:(NSString *)key tableName:(NSString*)billFormName;

@end
