    //
//  ViewController.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "ViewController.h"
#import "WreckModel.h"
#import "ShipwreckSimpleRemoteRepository.h"
#import "IShipwreckRemoteRepository.h"
#import "UploadFileRemoteRepository.h"
#import "IUploadRemoteRepository.h"
#import <ASIHTTPRequest.h>
#import <ASIFormDataRequest.h>
#import <ASIProgressDelegate.h>
#import <MTLModel.h>
#import "UserModel.h"
#import "UploadImageFileComponents.h"


@interface ViewController () <ASIProgressDelegate>
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController
{
    id <IShipwreckRemoteRepository> shipwrecksRemoteRepo;
    id <IUploadRemoteRepository >   uploadFileRemoteRepository;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScheduler];
    [self createRepositories];

   // [self->remoteRepo deleteshipwrackWithID:3];
   // [self refresh];
}


- (void)createScheduler
{
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                  target:self
                                                selector:@selector(schedulerTasks)
                                                userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)schedulerTasks
{
    [self testShipwreack];
  //  [self testUploadEndpoint];
}

- (void)createRepositories
{
    self->shipwrecksRemoteRepo = [ShipwreckSimpleRemoteRepository createShipwreckRemoteRepository];
    self->uploadFileRemoteRepository = [UploadFileRemoteRepository createUploadFileRemoteRepository];
}

- (void)testUploadEndpoint
{
    [self->uploadFileRemoteRepository uploadFiles:@[[UploadImageFileComponents createUploadImageFileComponentsWithFileName:@"IMG_1803.jpg"],
                                                    [UploadImageFileComponents createUploadImageFileComponentsWithFileName:@"clau.jpg"]]
                                     withComplBlk:^(id response, NSError *error) {
                                         // Evaluate results
                                     }];
}


- (void)testShipwreack
{
    [self->shipwrecksRemoteRepo getAllWithCompleationBlock:^(NSArray *result, NSError *error) {
        if (error || result == nil) {
            return;
        }
        static int ID = 4;
        ID ++;
        WreckModel *obj = result[0];
        obj.name = [NSString stringWithFormat:@"Post Obj#%d", ID];
        obj.id = ID;
        [self->shipwrecksRemoteRepo createShipwreck:obj complBlock:^(WreckModel *result, NSError *error) {
            
        }];
    }];
}


- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    
}


/*
- (void)uploadFiles2:(NSArray <UploadFileComponents *> *)files withComplBlk:(void (^)(id response, NSError *error))complBlk
{
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/User"];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    
    for (UploadFileComponents *file in files) {
        [request addData:file.data withFileName:file.filename andContentType:file.contentType forKey:file.parameterName];
    }
    
    UserModel *user = [UserModel new];
    NSDictionary *JSONDictionary  = [MTLJSONAdapter JSONDictionaryFromModel:user error:nil];
    NSData *cacat = [NSJSONSerialization dataWithJSONObject:JSONDictionary options:kNilOptions error:nil];
    //[request addData:JSONDictionary withFileName:@"cacat" andContentType:@"application/json" forKey:@"user"];
    
    NSDictionary *UserDictionary = @{@"name" : @"clau",
                                     @"email" : @"claudiu0xff@.",
                                     @"password" : @"parolaDuHonnor",
                                     };
    // 1. Convert dictionary to NSData
    NSData *dicAsNSData = [NSKeyedArchiver archivedDataWithRootObject:UserDictionary];
    // 2. Create JSON object from NSData
    id JSON = [NSJSONSerialization JSONObjectWithData:dicAsNSData options:kNilOptions error:nil];
    id ceva = [NSJSONSerialization dataWithJSONObject:UserDictionary options:0 error:nil];
    
    //[request addPostValue:ceva forKey:@"user"];
    [request addData:ceva forKey:@"user"];

    
    [request setCompletionBlock:^{
         NSLog(@"%@",[NSJSONSerialization JSONObjectWithData: request.responseData options:0 error:nil]);
        complBlk([NSJSONSerialization JSONObjectWithData: request.responseData options:0 error:nil], nil);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        complBlk(nil, error);
    }];
    [request startSynchronous];
}
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

