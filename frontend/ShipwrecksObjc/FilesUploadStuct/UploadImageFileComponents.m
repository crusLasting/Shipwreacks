//
//  UploadImageFileComponents.m
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import "UploadImageFileComponents.h"
#import <UIKit/UIKit.h>

@implementation UploadImageFileComponents
- (instancetype)initWithFileName:(NSString *)filename
{
    if (self = [super init]) {
        self.filename = filename;
        self.data = UIImageJPEGRepresentation([UIImage imageNamed:filename], 0);
        self.contentType = @"img/jpeg";
        self.parameterName = @"file";
    }
    return self;
}


+ (UploadImageFileComponents *)createUploadImageFileComponentsWithFileName:(NSString *)filename {
    return [[UploadImageFileComponents alloc] initWithFileName:filename];
}
@end
