//
//  EBBillDetailsModel.m
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBBillDetailsModel.h"

@implementation EBBillDetailsModel
@synthesize detailsDate,detailsEvent,detailsEventId,detailsExPlain,detailsMoney,detailsPeople,detailsPeopleId,detailsId;

-(void)initEmptyValue
{
    if (!self.detailsDate)
    {
        self.detailsDate = @"";
    }
    if (!self.detailsEvent)
    {
        self.detailsEvent = @"";
    }
    if (!self.detailsEventId)
    {
        self.detailsEventId = @"";
    }
    if (!self.detailsExPlain)
    {
        self.detailsExPlain = @"";
    }
    if (!self.detailsMoney)
    {
        self.detailsMoney = @"";
    }
    if (!self.detailsPeople)
    {
        self.detailsPeople = @"";
    }
    if (!self.detailsPeopleId)
    {
        self.detailsPeopleId = @"";
    }
    if (!self.detailsId)
    {
        self.detailsId = @"";
    }
}


@end
