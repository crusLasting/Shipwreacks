//
//  HTTPClientSimpleImpl.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 08.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHTTPClient.h"
@interface HTTPClientSimpleImpl : NSObject <IHTTPClient>
@property (strong, nonatomic) NSString *baseURLString;
@property (nonatomic, strong, nullable) dispatch_queue_t completionQueue;

@end
