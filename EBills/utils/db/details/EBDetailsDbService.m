//
//  EBDetailsDbService.m
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBDetailsDbService.h"
#import "EBDetailsDbManager.h"
#import "EBPeopleModel.h"

@implementation EBDetailsDbService

// 创建用户表
+(NSString *) createStr:(NSString*)billFormName
{
    
    NSString *sql = [NSString stringWithFormat:@" \n"
     
     "    DROP TABLE IF EXISTS [HT_CPA_CODE_FORM];  \n"
     "    CREATE TABLE [%@] \n"
     "    ( \n"
     "       [ID] INTEGER PRIMARY KEY,  \n"
     "       [EB_E_NAME] TEXT NOT NULL DEFAULT '',   \n"
     "       [EB_D_E_NAME_ID] TEXT NOT NULL DEFAULT '', \n"
     "       [EB_D_P_NAME] TEXT NOT NULL DEFAULT '',   \n"
     "       [EB_D_P_NAME_ID] TEXT NOT NULL DEFAULT '', \n"
     "       [EB_D_MONEY] TEXT NOT NULL DEFAULT '',   \n"
     "       [EB_D_DATE] TEXT NOT NULL DEFAULT '', \n"
     "       [EB_D_EXPLAIN] TEXT NOT NULL DEFAULT '', \n"
     "       [EB_D_ID] TEXT NOT NULL DEFAULT '' \n"
     "    ); \n",billFormName];
    
   
    
    return sql;
    
}



// 创建用户表
+(void) createForm:(NSString*)billFormName
{
    [EBDetailsDbManager executeSqlWithSqlStrings:[EBDetailsDbService createStr:billFormName]];
}


//插入 
+(BOOL)insertDetails:(EBBillDetailsModel *)model tableName:(NSString*)billFormName
{
    BOOL result = NO;
    PLSqliteDatabase *db = [EBDetailsDbManager openDatabase];
    
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(EB_E_NAME, EB_D_E_NAME_ID, EB_D_P_NAME, EB_D_P_NAME_ID, EB_D_MONEY, EB_D_DATE, EB_D_EXPLAIN, EB_D_ID) VALUES (:detailsEvent, :detailsEventId, :detailsPeople, :detailsPeopleId, :detailsMoney, :detailsDate, :detailsExPlain, :detailsId)",billFormName];
        
        // 关键路径开启事务
        [db beginTransaction];
        
        [model initEmptyValue];
        id<PLPreparedStatement> stmt = [db prepareStatement: sql];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity: 16];
        
        [parameters setObject: model.detailsEvent forKey: @"detailsEvent"];
        [parameters setObject: model.detailsEventId forKey: @"detailsEventId"];
        
        [parameters setObject: model.detailsPeople forKey: @"detailsPeople"];
        [parameters setObject: model.detailsPeopleId forKey: @"detailsPeopleId"];
        
        [parameters setObject: model.detailsMoney forKey: @"detailsMoney"];
        [parameters setObject: model.detailsDate forKey: @"detailsDate"];
        [parameters setObject: model.detailsExPlain forKey: @"detailsExPlain"];
        [parameters setObject: model.detailsId forKey: @"detailsId"];
        [stmt bindParameterDictionary: parameters];
        // Execute the INSERT
        if ([stmt executeUpdate] == NO)
        {
            NSLog(@"INSERT failed");
            result = NO;
        }
        else
        {
            result = YES;
        }
        [db commitTransaction];
    }
    @catch (NSException *exception)
    {
        [db rollbackTransaction];
    }
    @finally
    {
        
    }
    
    return result;
    
}

// 列表
+(NSMutableArray *)detailsArray:(NSString*)billFormName
{
    
    NSMutableArray *ticketOrderArray = [NSMutableArray array];
    
    @try {
//        @"SELECT O.EB_PEOPLE_NAME peopleName,  O.EB_PEOPLE_ID peopleId FROM EB_PEOPLE_FORM O ORDER BY O.EB_PEOPLE_ID ASC";
        
        NSString *sql = [NSString stringWithFormat:@"SELECT O.EB_E_NAME detailsEvent,  O.EB_D_E_NAME_ID detailsEventId,  O.EB_D_P_NAME detailsPeople,  O.EB_D_P_NAME_ID detailsPeopleId,  O.EB_D_MONEY detailsMoney,  O.EB_D_DATE detailsDate,  O.EB_D_EXPLAIN detailsExPlain, O.EB_D_ID detailsId FROM %@ O ORDER BY O.EB_D_ID DESC",billFormName];
        
        PLSqliteDatabase *db = [EBDetailsDbManager openDatabase];
        
        id<PLResultSet> resultSet = [db executeQuery: sql];
        
        while ([resultSet next])
        {
            EBBillDetailsModel *model = [[EBBillDetailsModel alloc] init];
            model.detailsEvent = [resultSet stringForColumn: @"detailsEvent"];
            model.detailsEventId = [resultSet stringForColumn: @"detailsEventId"];
            
            model.detailsPeople = [resultSet stringForColumn: @"detailsPeople"];
            model.detailsPeopleId = [resultSet stringForColumn: @"detailsPeopleId"];
            
            model.detailsMoney = [resultSet stringForColumn: @"detailsMoney"];
            model.detailsDate = [resultSet stringForColumn: @"detailsDate"];
            model.detailsExPlain = [resultSet stringForColumn: @"detailsExPlain"];
            model.detailsId = [resultSet stringForColumn: @"detailsId"];
            [ticketOrderArray addObject: model];
        }
        [resultSet close];
    }
    @catch (NSException *exception)
    {
        //        ALog(@"%@", exception.debugDescription);
    }
    @finally {
        
    }
    return ticketOrderArray;
}

// 删除 
+(BOOL)deletedetails:(NSString *) peopleId tableName:(NSString*)billFormName
{
    
    BOOL result = NO;
    
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@  WHERE EB_D_ID = ?",billFormName];
        PLSqliteDatabase *db = [EBDetailsDbManager openDatabase];
        
        result = [db executeUpdate: sql, peopleId];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception.debugDescription)
    }
    @finally {
        
    }
    
    return result;
}

//查找到不重复的人 （去重）
+(NSMutableArray*) detailsNameDistinct:(NSString*)billFormName
{
    NSMutableArray *poepleArray = [[NSMutableArray array] init];
    
    NSString *sql = [NSString stringWithFormat:@"select distinct  O.EB_D_P_NAME detailsPeople from %@ O" ,billFormName];
    PLSqliteDatabase *db = [EBDetailsDbManager openDatabase];
    id<PLResultSet> resultSet = [db executeQuery: sql];
    while ([resultSet next])
    {
        EBPeopleModel *model = [[EBPeopleModel alloc] init];
        model.peopleName = [resultSet stringForColumn: @"detailsPeople"];
//        model.peopleId = [resultSet stringForColumn: @"detailsPeopleId"];
        [poepleArray addObject: model];
    }
    [resultSet close];
    
    return poepleArray;
}

//查找一个人的 账目
+(NSArray *)getPeopleDetailsModel:(NSString *)key tableName:(NSString*)billFormName
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT O.EB_E_NAME detailsEvent,  O.EB_D_E_NAME_ID detailsEventId,  O.EB_D_P_NAME detailsPeople,  O.EB_D_P_NAME_ID detailsPeopleId,  O.EB_D_MONEY detailsMoney,  O.EB_D_DATE detailsDate,  O.EB_D_EXPLAIN detailsExPlain, O.EB_D_ID detailsId FROM %@ O WHERE O.EB_D_P_NAME = ?",billFormName];
    
    PLSqliteDatabase *db = [EBDetailsDbManager openDatabase];
    
    // 获取所有城市
    id<PLResultSet> resultSet = [db executeQuery: sql, key];
    
    while ([resultSet next])
    {
        EBBillDetailsModel *model = [[EBBillDetailsModel alloc] init];
        model.detailsEvent = [resultSet stringForColumn: @"detailsEvent"];
        model.detailsEventId = [resultSet stringForColumn: @"detailsEventId"];
        
        model.detailsPeople = [resultSet stringForColumn: @"detailsPeople"];
        model.detailsPeopleId = [resultSet stringForColumn: @"detailsPeopleId"];
        
        model.detailsMoney = [resultSet stringForColumn: @"detailsMoney"];
        model.detailsDate = [resultSet stringForColumn: @"detailsDate"];
        model.detailsExPlain = [resultSet stringForColumn: @"detailsExPlain"];
        model.detailsId = [resultSet stringForColumn: @"detailsId"];
        [array addObject: model];
        
    }
    [resultSet close];
    
    return array;
    
}



@end
