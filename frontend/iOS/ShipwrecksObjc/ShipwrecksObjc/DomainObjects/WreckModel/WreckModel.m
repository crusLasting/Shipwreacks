//
//  WreckModel.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "WreckModel.h"

@implementation WreckModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSLog(@"---");
    return @{
             @"id": @"id",
             @"name": @"name",
             @"Description": @"description",
             @"condition": @"condition",
             @"depth": @"depth",
             @"latitude": @"latitude",
             @"longitude": @"longitude",
             @"yearDiscovered": @"yearDiscovered"
             };
}

@end
