//
//  UploadImageFileComponents.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadFileComponents.h"

@interface UploadImageFileComponents : UploadFileComponents
- (instancetype)initWithFileName:(NSString *)filename;
+ (UploadImageFileComponents *)createUploadImageFileComponentsWithFileName:(NSString *)filename;
@end
