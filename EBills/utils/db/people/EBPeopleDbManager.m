//
//  EBPeopleDbManager.m
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBPeopleDbManager.h"

@implementation EBPeopleDbManager
// g_plDatabase类型:类静态变量
PLSqliteDatabase *_plDatabase_People;
NSCondition *_condition_People;

+(NSString *) dbPath
{
    static NSString *dbPath = nil;
    
    if (!dbPath)
    {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
        
        dbPath = [documentPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.%@",EB_PEOPLE_DB, DB_FILE_TYPE]];
        
    }
    
    return dbPath;
}

+(BOOL) dbExists
{
    return [[NSFileManager defaultManager] fileExistsAtPath: [EBPeopleDbManager dbPath]];
}

// 从bundle中拷贝到documents中
+(void) copyDB
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource: EB_PEOPLE_DB ofType: DB_FILE_TYPE];
    NSString *destPath = [EBPeopleDbManager dbPath];
    
    [[NSFileManager defaultManager] copyItemAtPath: sourcePath toPath: destPath error: nil];
}

+ (PLSqliteDatabase *)openDatabase
{
    if(nil == _plDatabase_People)
    {
        
        //NSString *dbPath = @":memory:";
        _plDatabase_People = [[PLSqliteDatabase alloc] initWithPath: [EBPeopleDbManager dbPath]];
        BOOL bOpen = [_plDatabase_People open];
        
        DLog(@"dbPath = %@, bOpen = %d", [self dbPath], bOpen);
        
        if (bOpen)
        {
            DLog(@"Database opened OK!");
        }
        
        _condition_People = [[NSCondition alloc] init];
    }
    
    return _plDatabase_People;
}

+(void) closeDatabase
{
    //    [g_condition release];
    //    [g_plDatabase release];
    [_plDatabase_People close];
}

+(void) lock
{
    [_condition_People lock];
}

+(void) unlock
{
    [_condition_People unlock];
}

#pragma mark -

+(id<PLResultSet>) executeQueryWithSqlString: (NSString *) sqlString
{
    DLog(@"%s %d, sqlString = %@", __FUNCTION__, __LINE__, sqlString);
    
    if (nil == sqlString)
    {
        return nil;
    }
    
    id<PLResultSet> result = [_plDatabase_People executeQuery: sqlString];
    
    return result;
}

+(void) executeSqlWithSqlStrings: (NSString *) sqlStrings
{
    NSArray *sqlArray = [sqlStrings componentsSeparatedByString: @";"];
    
    for (NSString *sqlString in sqlArray)
    {
        NSString *sqlString1 = [sqlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([sqlString1 length] > 0)
        {
            DLog(@"--->\n%@", sqlString1);
            
            [self executeUpdateWithSqlString: sqlString1];
        }
    }
}

+(BOOL) executeUpdateWithSqlString: (NSString *) sqlString
{
    DLog(@"%s %d, sqlString = %@", __FUNCTION__, __LINE__, sqlString);
    
    [self lock];
    
    BOOL bResult = [_plDatabase_People executeUpdate: sqlString];
    
    [self unlock];
    
    if (!bResult)
    {
        DLog(@"executeUpdate: %@", bResult ? @"关闭" : @"Failed");
    }
    
    return bResult;
}

@end
