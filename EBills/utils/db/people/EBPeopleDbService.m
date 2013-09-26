//
//  EBPeopleDbService.m
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBPeopleDbService.h"
#import "EBPeopleDbManager.h"

@implementation EBPeopleDbService

//---------------------------------------------------
//插入 姓名
+(BOOL)insertPeople:(EBPeopleModel *)model
{
    BOOL result = NO;
    PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
    
    @try {
        NSString *sql = @"INSERT INTO EB_PEOPLE_FORM(EB_PEOPLE_ID, EB_PEOPLE_NAME) VALUES (:peopleId, :peopleName)";
        
        // 关键路径开启事务
        [db beginTransaction];
        
        [model initEmptyValue];
        id<PLPreparedStatement> stmt = [db prepareStatement: sql];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity: 16];
        
        [parameters setObject: model.peopleName forKey: @"peopleName"];
        [parameters setObject: model.peopleId forKey: @"peopleId"];
        
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

// 删除 人
+(BOOL)deletePeople:(NSString *)peopleId
{
    
    BOOL result = NO;
    
    @try {
        NSString *sql = @"DELETE FROM EB_PEOPLE_FORM  WHERE EB_PEOPLE_ID = ?";
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        result = [db executeUpdate: sql, peopleId];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception.debugDescription)
    }
    @finally {
        
    }
    
    return result;
}

// 列表 人名 列表
+(NSMutableArray *)peopleArray
{
    
    NSMutableArray *ticketOrderArray = [NSMutableArray array];
    
    @try {
        NSString *sql = @"SELECT O.EB_PEOPLE_NAME peopleName,  O.EB_PEOPLE_ID peopleId FROM EB_PEOPLE_FORM O ORDER BY O.EB_PEOPLE_ID ASC";
        
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        // 获取所有常用人
        id<PLResultSet> resultSet = [db executeQuery: sql];
        
        while ([resultSet next])
        {
            EBPeopleModel *model = [[EBPeopleModel alloc] init];
            model.peopleName = [resultSet stringForColumn: @"peopleName"];
            model.peopleId = [resultSet stringForColumn: @"peopleId"];
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

//跟具 人名返回model
+(EBPeopleModel *)getPeopleModel:(NSString *)key
{
    EBPeopleModel *model = nil;
    
    NSString *sql = @"SELECT O.EB_PEOPLE_ID peopleId, O.EB_PEOPLE_NAME peopleName FROM EB_PEOPLE_FORM O WHERE O.EB_PEOPLE_NAME = ?";
    
    PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
    
    // 获取所有城市
    id<PLResultSet> resultSet = [db executeQuery: sql, key];
    
    if ([resultSet next])
    {
        model = [[EBPeopleModel alloc] init];
        model.peopleName = [resultSet stringForColumn: @"peopleName"];
        model.peopleId = [resultSet stringForColumn: @"peopleId"];
    }
    [resultSet close];
    
    return model;
    
}

//---------------------------------------------------
//插入事件
+(BOOL)insertEvent:(EBEventModel *)model
{
    BOOL result = NO;
    PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
    
    @try {
        NSString *sql = @"INSERT INTO EB_EVENT_FORM(EB_EVENT_NAME, EB_EVENT_ID) VALUES (:eventName, :eventid)";
        
        // 关键路径开启事务
        [db beginTransaction];
        
        [model initEmptyValue];
        id<PLPreparedStatement> stmt = [db prepareStatement: sql];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity: 16];
        
        [parameters setObject: model.eventName forKey: @"eventName"];
        [parameters setObject: model.eventId forKey: @"eventid"];
        
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

// 删除 事件
+(BOOL)deleteEvent:(NSString *)eventId
{
    
    BOOL result = NO;
    
    @try {
        NSString *sql = @"DELETE FROM EB_EVENT_FORM  WHERE EB_EVENT_ID = ?";
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        result = [db executeUpdate: sql, eventId];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception.debugDescription)
    }
    @finally {
        
    }
    
    return result;
}

// 列表 事件 列表
+(NSMutableArray *)eventArray
{
    
    NSMutableArray *orderArray = [NSMutableArray array];
    
    @try {
        NSString *sql = @"SELECT O.EB_EVENT_NAME eventName,  O.EB_EVENT_ID eventid FROM EB_EVENT_FORM O ORDER BY O.EB_EVENT_ID ASC";
        
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        // 获取所有常用人
        id<PLResultSet> resultSet = [db executeQuery: sql];
        
        while ([resultSet next])
        {
            EBEventModel *model = [[EBEventModel alloc] init];
            model.eventName = [resultSet stringForColumn: @"eventName"];
            model.eventId = [resultSet stringForColumn: @"eventid"];
            [orderArray addObject: model];
        }
        [resultSet close];
    }
    @catch (NSException *exception)
    {
        //        ALog(@"%@", exception.debugDescription);
    }
    @finally {
        
    }
    return orderArray;
}

// 根据 事件名返回model
+(EBEventModel*)getEventModel:(NSString*)key
{
    EBEventModel *model = nil;
    
    NSString *sql = @"SELECT O.EB_EVENT_NAME eventName,  O.EB_EVENT_ID eventid FROM EB_EVENT_FORM O WHERE O.EB_EVENT_NAME = ?";
    
    PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
    
    // 获取所有城市
    id<PLResultSet> resultSet = [db executeQuery: sql, key];
    
    if ([resultSet next])
    {
        model = [[EBEventModel alloc] init];
        model.eventName = [resultSet stringForColumn: @"eventName"];
        model.eventId = [resultSet stringForColumn: @"eventid"];
    }
    [resultSet close];
    
    return model;
}

//---------------------------------------------------
//插入账本名称
+(BOOL)insertBill:(EBBillModel *)model
{
    BOOL result = NO;
    PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
    
    @try {
        NSString *sql = @"INSERT INTO EB_DETAILS_TABLES (EB_DETAILS_NAME, EB_DETAILS_ID, EB_DETAILS_PEOPLE, EB_DETAILS_PEOPLE_ID, EB_DETAILS_DATE, EB_DETAILS_DETAIL, EB_DETAILS_DBNAME) VALUES (:billName, :billId, :billPeople, :billPeopleId, :billDate, :billDetails, :billDbName)";
        
        // 关键路径开启事务
        [db beginTransaction];
        
        [model initEmptyValue];
        id<PLPreparedStatement> stmt = [db prepareStatement: sql];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity: 16];
        
        [parameters setObject: model.billName forKey: @"billName"];
        [parameters setObject: model.billId forKey: @"billId"];
        [parameters setObject: model.billPeople forKey: @"billPeople"];
        [parameters setObject: model.billPeopleId forKey: @"billPeopleId"];
        [parameters setObject: model.billDate forKey: @"billDate"];
        [parameters setObject: model.billDetails forKey: @"billDetails"];
        [parameters setObject: model.billDbName forKey: @"billDbName"];
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

// 列表 账目名 列表
+(NSMutableArray *)billArray
{
    
    NSMutableArray *ticketOrderArray = [NSMutableArray array];
    
    @try {
        NSString *sql = @"SELECT O.EB_DETAILS_NAME billName,  O.EB_DETAILS_ID billId, O.EB_DETAILS_PEOPLE billPeople,  O.EB_DETAILS_PEOPLE_ID billPeopleId, O.EB_DETAILS_DATE billDate,  O.EB_DETAILS_DETAIL billDetails, O.EB_DETAILS_DBNAME billDbName FROM EB_DETAILS_TABLES O ORDER BY O.EB_DETAILS_ID ASC";
        
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        // 获取所有常用人
        id<PLResultSet> resultSet = [db executeQuery: sql];
        
        while ([resultSet next])
        {
            EBBillModel *model = [[EBBillModel alloc] init];
            model.billName = [resultSet stringForColumn: @"billName"];
            model.billId = [resultSet stringForColumn: @"billId"];
            model.billPeople = [resultSet stringForColumn: @"billPeople"];
            model.billPeopleId = [resultSet stringForColumn: @"billPeopleId"];
            model.billDate = [resultSet stringForColumn: @"billDate"];
            model.billDetails = [resultSet stringForColumn: @"billDetails"];
            model.billDbName = [resultSet stringForColumn: @"billDbName"];
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

// 删除 账目
+(BOOL)deletebill:(NSString *)billId
{
    BOOL result = NO;
    @try {
        NSString *sql = @"DELETE FROM EB_DETAILS_TABLES  WHERE EB_DETAILS_ID = ?";
        PLSqliteDatabase *db = [EBPeopleDbManager openDatabase];
        
        result = [db executeUpdate: sql, billId];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception.debugDescription)
    }
    @finally {
        
    }
    
    return result;
}

@end
