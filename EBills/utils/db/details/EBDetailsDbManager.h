//
//  EBDetailsDbManager.h
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlausibleDatabase.h"

@interface EBDetailsDbManager : NSObject

+(id<PLResultSet>) executeQueryWithSqlString: (NSString *) sqlString;

// 数据库文件是否存在
+(BOOL) dbExists;
+(void) copyDB;

+ (PLSqliteDatabase *)openDatabase;
+(void) closeDatabase;

+(void) lock;
+(void) unlock;

+(void) executeSqlWithSqlStrings: (NSString *) sqlStrings;


@end
