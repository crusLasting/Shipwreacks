//
//  WreckModel.h
//  ShipwrecksObjc
//
//  Created by claudiu Rus on 05.06.18.
//  Copyright © 2018 claudiu Rus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface WreckModel : MTLModel <MTLJSONSerializing>
/*
 private Long id;
 private String name;
 private String description;
 private String condition;
 private Integer depth;
 private Double latitude;
 private Double longitude;
 private Integer yearDiscovered;
 */

@property (nonatomic, assign, readwrite) NSInteger   id;
@property (nonatomic, strong, readwrite) NSString    *name;
@property (nonatomic, strong, readwrite) NSString    *Description;
@property (nonatomic, strong, readwrite) NSString    *condition;

@property (nonatomic, assign, readwrite) NSInteger    depth;
@property (nonatomic, assign, readwrite) double       latitude;
@property (nonatomic, assign, readwrite) double       longitude;
@property (nonatomic, assign, readwrite) int           yearDiscovered;
@end
