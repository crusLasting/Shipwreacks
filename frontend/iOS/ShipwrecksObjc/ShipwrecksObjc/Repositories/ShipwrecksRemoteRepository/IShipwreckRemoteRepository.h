//
//  IShipwreckRemoteRepository.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShipwreckSimpleRemoteRepository;
@class WreckModel;
@protocol IShipwreckRemoteRepository <NSObject>

+ (ShipwreckSimpleRemoteRepository *)createShipwreckRemoteRepository;
- (void)getAllWithCompleationBlock:(void(^)(NSArray *result, NSError *error))complBlock;
- (void)getWithID:(long)ID complBlock:(void(^)(id result, NSError *error))complBlock;
- (void)replaceShipWrackWithID:(long)ID withObject:(id)object;
- (void)deleteshipwrackWithID:(long)ID;
- (void)deleteAllWithComplBlock:(void(^)(id result, NSError *error))complBlock;
- (void)createShipwreck:(WreckModel *)shipwreck complBlock:(void(^)(WreckModel *result, NSError *error))complBlock;

@end
