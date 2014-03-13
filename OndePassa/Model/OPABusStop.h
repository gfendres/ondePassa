//
//  OPABusStop.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPABusStop : NSObject
@property(nonatomic)int identifier;
@property(nonatomic,strong)NSString* name;
@property(nonatomic)int sequence;
@end
