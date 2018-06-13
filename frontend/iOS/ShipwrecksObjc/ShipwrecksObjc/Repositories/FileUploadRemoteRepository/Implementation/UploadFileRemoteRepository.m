//
//  UploadFileRemoteRepository.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "UploadFileRemoteRepository.h"
#import <ASIFormDataRequest.h>
#import "UserModel.h"

@implementation UploadFileRemoteRepository

+ (id)shared
{
    static dispatch_once_t onceToken;
    static UploadFileRemoteRepository *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [UploadFileRemoteRepository new];
    });
    return instance;
}


+ (id)createUploadFileRemoteRepository
{
    return [UploadFileRemoteRepository new];
}


- (void)uploadFiles:(NSArray <UploadFileComponents *> *)files withComplBlk:(void (^)(id response, NSError *error))complBlk
{
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/uploadFiles"];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    request.delegate = self;
    
    for (UploadFileComponents *file in files) {
        [request addData:file.data withFileName:file.filename andContentType:file.contentType forKey:file.parameterName];
    }
    
    //[request addPostValue:@"Programul Terra"   forKey:@"book"]; // Functioneaza!!
    
    [request setCompletionBlock:^{
        //  NSLog(@"%@",[[NSString alloc] initWithData:request.responseHeaders encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData: request.responseData options:0 error:nil]);
        complBlk([NSJSONSerialization JSONObjectWithData: request.responseData options:0 error:nil], nil);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        complBlk(nil, error);
    }];
    [request startSynchronous];
}
@end
