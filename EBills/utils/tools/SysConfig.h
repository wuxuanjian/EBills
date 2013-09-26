//
//  SysConfig.h
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#ifndef EBills_SysConfig_h
#define EBills_SysConfig_h

#ifdef DEBUG
#   define DLog(fmt, ...) { NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#define DB_FILE_TYPE         @"sqlite"   // 数据库类型
#define EB_PEOPLE_DB @"EB_PEOPLE_EVENT_DB"  //
#define EB_DETAILS_DB @"EB_DETAILS_DB"  //详情数据库


#endif
