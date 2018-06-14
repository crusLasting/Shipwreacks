//
//  ShipwreckASIHTTPRequestRemoteRepository.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 06.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "ShipwreckASIHTTPRequestRemoteRepository.h"
#import <ASIHTTPRequest.h>

@implementation ShipwreckASIHTTPRequestRemoteRepository

- (void)createShipwreck:(WreckModel *)shipwreck complBlock:(void (^)(WreckModel *, NSError *))complBlock {
    
}


+ (id <IShipwreckRemoteRepository>)createShipwreckRemoteRepository
{
    return [[ShipwreckASIHTTPRequestRemoteRepository alloc] init];
}


- (void)deleteshipwrackWithID:(long)ID {
    
}

- (void)getAllWithCompleationBlock:(void (^)(NSArray *, NSError *))complBlock {
    
}

- (id)getWithID:(long)ID {
    return nil;
}

- (void)replaceShipWrackWithID:(long)ID withObject:(id)object {
    
}

@end
