//
//  OPABusDepartures.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPABusDepartures : NSObject
@property (nonatomic,strong )NSString *calendar;
@property (nonatomic) int identifier;
@property (nonatomic,strong) NSString *time;
@end
