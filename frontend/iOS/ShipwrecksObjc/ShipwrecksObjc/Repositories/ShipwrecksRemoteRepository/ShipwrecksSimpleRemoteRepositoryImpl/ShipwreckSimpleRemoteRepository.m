//
//  ShipwreckRemoteRepository.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "ShipwreckSimpleRemoteRepository.h"
#import "WreckModel.h"
#import <Mantle.h>

NSURLSessionDataTask* task;
NSString *serverAddress = @"http://localhost";
NSString *serverPort = @"8080";
NSString *serverEndPoint = @"api/v1";

NSString *GetAllWracksEndPointOffset = @"shipwrecks";
NSURLSession *session;

NSString *GetServerAddress(void)
{
    return [NSString stringWithFormat:@"%@:%@/%@", serverAddress, serverPort, serverEndPoint];
}

@implementation ShipwreckSimpleRemoteRepository

- (instancetype)initWithBaseURL:(NSString *)baseURL
{
    if (self = [super init]) {
        _URL = baseURL;
    }
    return self;
}

+ (ShipwreckSimpleRemoteRepository *)createShipwreckRemoteRepository
{
    return [[ShipwreckSimpleRemoteRepository alloc] initWithBaseURL:GetServerAddress()];
}

#pragma mark- Server Endpoints APIs
/*
 Endpoint: http://localhost:8080/api/v1/shipwrecks
 Description:
   Retrieves all wrecks from server. It convertes from JSON response into WrackModel objects.
*/
- (void)getAllWithCompleationBlock:(void(^)(NSArray *result, NSError *error))complBlock
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@", self.URL, GetAllWracksEndPointOffset]]];
    [request setHTTPMethod:@"GET"];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:nil
                                                     delegateQueue:Nil];
    
    //create the task
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error){
                                                    NSLog(@"Error: %@",error);
                                                    complBlock(nil, error);
                                                } else {
                                                    NSError *jsonError;
                                                    // instantiate deserialization data into JSON type
                                                    id jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                               options:0
                                                                                                                 error:&jsonError];
                                                    
                                                    if (((NSArray*)jsonDictionaryOrArray).count == 0) {
                                                        complBlock(nil, nil);
                                                        return;
                                                    }
                                                    if ([jsonDictionaryOrArray isKindOfClass:[NSDictionary class]]  &&
                                                        [[jsonDictionaryOrArray valueForKey:@"status"] isEqualToNumber:@(404)]) {
                                                        // Resurce not found on the server side.
                                                        NSLog(@"json error : %@", [jsonError localizedDescription]);
                                                        complBlock(nil, error);
                                                        return;
                                                    }
                                                    if (jsonError) {
                                                        // check the error description
                                                        NSLog(@"json error : %@", [jsonError localizedDescription]);
                                                        complBlock(nil, error);
                                                    } else {
                                                        NSMutableArray <WreckModel *> *result = [@[] mutableCopy];
                                                        if ([jsonDictionaryOrArray isKindOfClass:[NSArray class]]) {
                                                            [jsonDictionaryOrArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                NSError *error = nil;
                                                                WreckModel *wreck = [[WreckModel alloc] initWithDictionary:obj
                                                                                                                     error:&error];
                                                                [result addObject:wreck];
                                                            }];
                                                        } else {
                                                            NSError *error = nil;
                                                            WreckModel *wreck = [[WreckModel alloc] initWithDictionary:jsonDictionaryOrArray
                                                                                                                 error:&error];
                                                            [result addObject:wreck];
                                                        }
                                                        complBlock(result, nil);
                                                    }                                                    }
                                            }];
    [task resume];
}

/*
 Endpoint: // link: http://localhost:8080/api/v1/shipwrecks/{id}
 Description:
 Retrieves a single wreck object from server which matches the ID parameter. It convertes from JSON response into WrackModel objects.
 */
- (void)getWithID:(long)ID complBlock:(void(^)(id result, NSError *error))complBlock
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:[NSString stringWithFormat:@"%@/%lu", GetServerAddress(), ID]]];
    [request setHTTPMethod:@"GET"];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:nil
                                                     delegateQueue:Nil];
    
    //create the task
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error){
                                                    NSLog(@"Error: %@",error);
                                                    complBlock(nil, error);
                                                } else {
                                                    NSError *jsonError;
                                                    // instantiate deserialization data into JSON type
                                                    id jsonDictionaryOrArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                               options:0
                                                                                                                 error:&jsonError];
                                                    if ([[jsonDictionaryOrArray valueForKey:@"status"] isEqualToNumber:@(404)]) {
                                                        complBlock(nil, error);
                                                        return;
                                                    }
                                                    if (jsonError) {
                                                        // check the error description
                                                        NSLog(@"json error : %@", [jsonError localizedDescription]);
                                                        complBlock(nil, error);
                                                    } else {
                                                            NSError *error = nil;
                                                            WreckModel *wreck = [[WreckModel alloc] initWithDictionary:jsonDictionaryOrArray
                                                                                                                 error:&error];
                                                        complBlock(wreck, nil);
                                                    }                                                    }
                                            }];
    [task resume];
}


- (void)createShipwreck:(WreckModel *)shipwreck complBlock:(void(^)(WreckModel *result, NSError *error))complBlock
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@", self.URL, GetAllWracksEndPointOffset]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *JSONDictionary  = [MTLJSONAdapter JSONDictionaryFromModel:shipwreck error:nil];
    NSData *wreackData = [NSJSONSerialization dataWithJSONObject:JSONDictionary options:kNilOptions error:nil];
    [request setValue:[NSString stringWithFormat:@"%lu", wreackData.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:wreackData];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                            delegate:nil
                                       delegateQueue:nil];
    //create the task
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSLog(@"%@", error);
    }] resume];
}


- (void)replaceShipWrackWithID:(long)ID withObject:(id)object
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@/%d", self.URL, GetAllWracksEndPointOffset, ID]]];
    [request setHTTPMethod:@"DELETE"];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                            delegate:self
                                       delegateQueue:nil];
    
    //create the task
    task = [session dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                          NSLog(@"%@", error);
                      }];
    [task resume];
}

- (void)deleteshipwrackWithID:(long)ID
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@/%d", self.URL, GetAllWracksEndPointOffset, ID]]];
    [request setHTTPMethod:@"DELETE"];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                          delegate:self
                                                     delegateQueue:nil];
    
    //create the task
    task = [session dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                          NSLog(@"%@", error);
                      }];
       [task resume];
                                  
}

- (void)deleteAllWithComplBlock:(void(^)(id result, NSError *error))complBlock
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@", self.URL, GetAllWracksEndPointOffset]]];
    [request setHTTPMethod:@"DELETE"];
    // Create Session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                            delegate:self
                                       delegateQueue:nil];
    
    //create the task
    task = [session dataTaskWithRequest:request
                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                          NSLog(@"%@", error);
                        //  id po = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
                          NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                      }];
    [task resume];
    
}


@end
