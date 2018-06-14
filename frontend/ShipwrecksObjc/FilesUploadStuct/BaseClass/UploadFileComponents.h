//
//  UploadFileComponents.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 13.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFileComponents : NSObject
@property (strong, nonatomic, nonnull) NSString *filename;
@property (strong, nonatomic, nonnull) NSData *data;
@property (strong, nonatomic, nonnull) NSString *contentType;   // e.g. "image/jpg
@property (strong, nonatomic, nonnull) NSString *parameterName;   // e.g. "file"
@end
