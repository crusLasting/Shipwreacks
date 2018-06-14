//
//  HTTPClientSimpleImpl.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 08.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "HTTPClientSimpleImpl.h"

@implementation HTTPClientSimpleImpl
- (instancetype)initWithBaseURLString:(NSString *)URLString {
    self = [super init];
    _baseURLString = [URLString copy];
    return self;
}

- (id<IHTTPClient>)createHTTPClientWithBaseURLString:(NSString *)URLString {
    return [[[self class] alloc] initWithBaseURLString:URLString];
}

- (void)GETPayload:(id)payload toEndPoint:(NSString *)endpoint cmplBlk:(void (^)(id, NSError *))cmplBlk {
    
}


- (void)POSTPayload:(id)payload toEndPoint:(NSString *)endpoint cmplBlk:(void (^)(id, NSError *))cmplBlk {
    
}


@end
