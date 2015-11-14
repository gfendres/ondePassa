//
//  OPABusRoutes.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPABusRoutes : NSObject
@property (nonatomic) int agencyId;
@property (nonatomic) int identifier;
@property (nonatomic,strong) NSString *lastModifiedDate;
@property (nonatomic,strong) NSString *longName;
@property (nonatomic,strong) NSString *shortName;
@end
