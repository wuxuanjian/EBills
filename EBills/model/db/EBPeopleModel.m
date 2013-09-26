//
//  EBPeopleModel.m
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBPeopleModel.h"

@implementation EBPeopleModel
@synthesize peopleId,peopleName,money;


-(void)initEmptyValue
{
    if (!self.peopleId)
    {
        self.peopleId = @"";
    }
    if (!self.peopleName)
    {
        self.peopleName = @"";
    }
    if (!self.money)
    {
        self.money = @"";
    }
}

@end
