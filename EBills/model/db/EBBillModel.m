//
//  EBBillModel.m
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBBillModel.h"

@implementation EBBillModel
@synthesize billDate,billDetails,billId,billName,billPeople,billPeopleId,billDbName;

-(void)initEmptyValue
{
    if (!self.billDate)
    {
        self.billDate = @"";
    }
    
    if (!self.billDetails)
    {
        self.billDetails = @"";
    }
    
    if (!self.billId)
    {
        self.billId = @"";
    }
    
    if (!self.billName)
    {
        self.billName = @"";
    }
    
    if (!self.billPeople)
    {
        self.billPeople = @"";
    }
    
    if (!self.billPeopleId)
    {
        self.billPeopleId = @"";
    }
    
    if (!self.billDbName)
    {
        self.billDbName = @"";
    }
}

@end
