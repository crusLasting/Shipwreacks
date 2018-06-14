//
//  IUploadRemoteRepository.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IUploadRemoteRepository <NSObject>
- (void)uploadFiles:(NSArray <UploadFileComponents *> *)files withComplBlk:(void (^)(id response, NSError *error))complBlk;
@end
