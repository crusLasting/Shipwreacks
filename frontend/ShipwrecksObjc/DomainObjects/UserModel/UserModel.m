//
//  UserModel.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"email" : @"email",
             @"password" : @"password"
             };
}
@end
