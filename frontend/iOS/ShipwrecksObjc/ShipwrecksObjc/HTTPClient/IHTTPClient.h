//
//  IHTTPClient.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 08.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IHTTPClient <NSObject>
- (void)POSTPayload:(id)payload toEndPoint:(NSString *)endpoint cmplBlk:(void(^)(id result, NSError *error))cmplBlk;
- (void)GETPayload:(id)payload toEndPoint:(NSString *)endpoint cmplBlk:(void(^)(id result, NSError *error))cmplBlk;
- (id<IHTTPClient>)createHTTPClientWithBaseURLString:(NSString *)URLString;
@property (nonatomic, strong, nullable) dispatch_queue_t completionQueue;
@end
