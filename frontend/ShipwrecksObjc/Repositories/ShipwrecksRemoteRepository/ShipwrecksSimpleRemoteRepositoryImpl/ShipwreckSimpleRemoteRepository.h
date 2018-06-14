//
//  ShipwreckSimpleRemoteRepository.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//
/*
    This class defines server requests APIs meant for sending and receiving  "wrecks" to/from server.
    One specific thing about this class is that is uses directly iOS network libs,rahtern then AFNetworking.
    This is why we call it "Simple"
*/

#import <Foundation/Foundation.h>
#import "IShipwreckRemoteRepository.h"

@interface ShipwreckSimpleRemoteRepository : NSObject <IShipwreckRemoteRepository, NSURLSessionDelegate>
@property (nonatomic, strong, readonly) NSString *URL;

+ (ShipwreckSimpleRemoteRepository *)createShipwreckRemoteRepository;

@end
