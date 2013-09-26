//
//  EBPeopleModel.h
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBPeopleModel : NSObject

@property (nonatomic,strong) NSString* peopleName; //人名
@property (nonatomic,strong) NSString* peopleId;
@property (nonatomic,strong) NSString* money;  //对结算使用
-(void)initEmptyValue;
@end
