//
//  OPABusServicesAPI.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/14/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OPABusServiceAPIDelegate <NSObject>

@optional
- (void)getRoutesSuccessful:(NSMutableArray*)dataSource;
- (void)getStopsSuccessful:(NSMutableArray*)dataSource;
- (void)getDeparturesSuccessful:(NSMutableArray*)dataSource;
- (void)opaBusServiceAPIFailure:(NSString*)error;
@end

@interface OPABusServicesAPI : NSObject

@property (nonatomic, weak) NSObject<OPABusServiceAPIDelegate> *delegate;

+ (OPABusServicesAPI *)instance;
- (void)getRoutes:(NSString*)routeName;
- (void)getStops:(int)routeId;
- (void)getDepartures:(int)routeId;

@end
