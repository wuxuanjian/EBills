//
//  EBDetailsDbManager.m
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBDetailsDbManager.h"

@implementation EBDetailsDbManager
PLSqliteDatabase *_plDatabase_Details;
NSCondition *_condition_Details;

+(NSString *) dbPath
{
    static NSString *dbPath = nil;
    
    if (!dbPath)
    {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
        
        dbPath = [documentPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.%@",EB_DETAILS_DB, DB_FILE_TYPE]];
        
    }
    
    return dbPath;
}

+(BOOL) dbExists
{
    return [[NSFileManager defaultManager] fileExistsAtPath: [EBDetailsDbManager dbPath]];
}

// 从bundle中拷贝到documents中
+(void) copyDB
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource: EB_DETAILS_DB ofType: DB_FILE_TYPE];
    NSString *destPath = [EBDetailsDbManager dbPath];
    
    [[NSFileManager defaultManager] copyItemAtPath: sourcePath toPath: destPath error: nil];
}

+ (PLSqliteDatabase *)openDatabase
{
    if(nil == _plDatabase_Details)
    {
        
        //NSString *dbPath = @":memory:";
        _plDatabase_Details = [[PLSqliteDatabase alloc] initWithPath: [self dbPath]];
        BOOL bOpen = [_plDatabase_Details open];
        
        DLog(@"dbPath = %@, bOpen = %d", [self dbPath], bOpen);
        
        if (bOpen)
        {
            DLog(@"Database opened OK!");
        }
        
        _condition_Details = [[NSCondition alloc] init];
    }
    
    return _plDatabase_Details;
}

+(void) closeDatabase
{
    //    [g_condition release];
    //    [g_plDatabase release];
    [_plDatabase_Details close];
}

+(void) lock
{
    [_condition_Details lock];
}

+(void) unlock
{
    [_condition_Details unlock];
}

#pragma mark -

+(id<PLResultSet>) executeQueryWithSqlString: (NSString *) sqlString
{
    DLog(@"%s %d, sqlString = %@", __FUNCTION__, __LINE__, sqlString);
    
    if (nil == sqlString)
    {
        return nil;
    }
    
    id<PLResultSet> result = [_plDatabase_Details executeQuery: sqlString];
    
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
    
    BOOL bResult = [_plDatabase_Details executeUpdate: sqlString];
    
    [self unlock];
    
    if (!bResult)
    {
        DLog(@"executeUpdate: %@", bResult ? @"关闭" : @"Failed");
    }
    
    return bResult;
}

@end
