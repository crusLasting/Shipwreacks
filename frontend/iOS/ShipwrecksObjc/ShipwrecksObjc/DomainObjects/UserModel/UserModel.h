//
//  UserModel.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>


@interface UserModel : MTLModel  <MTLJSONSerializing>
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@end
