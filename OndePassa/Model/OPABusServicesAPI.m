//
//  OPABusServicesAPI.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/14/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "OPABusServicesAPI.h"
#import "OPABusRoutes.h"
#import "OPABusStop.h"
#import "OPABusDepartures.h"
@implementation OPABusServicesAPI

+ (OPABusServicesAPI *)instance {
    static OPABusServicesAPI *instance;
    
    if (instance == nil){
        instance = [[OPABusServicesAPI alloc] init];
    }
	
    return instance;
}

#pragma mark - Gets

-(void)getRoutes:(NSString*)routeName
{
	NSMutableArray* dataSource = [NSMutableArray new];
	[[AFHTTPRequestOperationManager AFRequest] POST:ROUTES
										 parameters:[self getParametersWithStopName:routeName]
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
												
												for(NSDictionary *routesJSON in responseObject[@"rows"])
												{
													OPABusRoutes *busRoute = [OPABusRoutes new];
													busRoute.agencyId = [routesJSON[@"agencyId"] integerValue];
													busRoute.identifier = [routesJSON[@"id"] integerValue];
													busRoute.lastModifiedDate = routesJSON[@"lastModifiedDate"];
													busRoute.longName = routesJSON[@"longName"];
													busRoute.shortName = routesJSON[@"shortName"];
													[dataSource addObject:busRoute];
												}
												[self performSelectorOnMainThread:@selector(successfulRoutesCallback:)
																	   withObject:dataSource waitUntilDone:NO];
												
											}
											failure:^(AFHTTPRequestOperation *operation, NSError *err) {

												[self performSelectorOnMainThread:@selector(failureCallback:)
																	   withObject:err waitUntilDone:NO];
											}
     ];
	
}

-(void)getStops:(int)routeId
{
	NSMutableArray *stopsDataSource = [NSMutableArray new];
	[[AFHTTPRequestOperationManager AFRequest] POST:STOPS
										 parameters:[self getParamteresWithRouteId:routeId]
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
												
												for(NSDictionary *stopJSON in responseObject[@"rows"])
												{
													OPABusStop* busStop = [OPABusStop new];
													busStop.identifier = [stopJSON[@"id"] integerValue];
													busStop.name = stopJSON[@"name"];
													busStop.sequence = [stopJSON[@"sequence"] integerValue];
													
													[stopsDataSource addObject:busStop];
												}
												
												[self performSelectorOnMainThread:@selector(successfulStopsCallback:)
																	   withObject:stopsDataSource waitUntilDone:NO];

											}
											failure:^(AFHTTPRequestOperation *operation, NSError *err) {
												[self performSelectorOnMainThread:@selector(failureCallback:)
																	   withObject:err waitUntilDone:NO];
											}
     ];
}

-(void)getDepartures:(int)routeId
{
	
	NSMutableArray* departuresDataSource = [NSMutableArray new];
    [[AFHTTPRequestOperationManager AFRequest] POST:DEPARTURES
										 parameters:[self getParamteresWithRouteId:routeId]
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
												
												for(NSDictionary *departureJSON in responseObject[@"rows"])
												{
													OPABusDepartures* busDeparture = [OPABusDepartures new];
													busDeparture.calendar = departureJSON[@"calendar"];
													busDeparture.identifier = [departureJSON[@"id"] integerValue];
													busDeparture.time = departureJSON[@"time"];
													
													[departuresDataSource addObject:busDeparture];
												}
												
												[self performSelectorOnMainThread:@selector(successfulDeparturesCallback:)
																	   withObject:departuresDataSource waitUntilDone:NO];

												
											}
											failure:^(AFHTTPRequestOperation *operation, NSError *err) {
												[self performSelectorOnMainThread:@selector(failureCallback:)
																	   withObject:err waitUntilDone:NO];
											}
     ];
}

#pragma mark - Get Parameters

-(NSDictionary*)getParametersWithStopName:(NSString*)stopName
{
	return @{@"params" : @{ @"stopName": [NSString stringWithFormat:@"%%%@%%",[stopName lowercaseString]]} };
}

-(NSDictionary*)getParamteresWithRouteId:(int)routeId
{
	return @{@"params" : @{ @"routeId": [NSString stringWithFormat:@"%d",routeId] } };
}

#pragma mark - Callbacks

- (void)successfulRoutesCallback:(NSMutableArray*)dataSource {
	
	if([_delegate conformsToProtocol:@protocol(OPABusServiceAPIDelegate)]) {
		[_delegate getRoutesSuccessful:dataSource];
	}
	
}

- (void)successfulStopsCallback:(NSMutableArray*)dataSource {
	
	if([_delegate conformsToProtocol:@protocol(OPABusServiceAPIDelegate)]) {
		[_delegate getStopsSuccessful:dataSource];
	}
	
}

- (void)successfulDeparturesCallback:(NSMutableArray*)dataSource {
	
	if([_delegate conformsToProtocol:@protocol(OPABusServiceAPIDelegate)]) {
		[_delegate getDeparturesSuccessful:dataSource];
	}
	
}

- (void)failureCallback:(NSString*)error {
	
	if([_delegate conformsToProtocol:@protocol(OPABusServiceAPIDelegate)]) {
		[_delegate opaBusServiceAPIFailure:error];
	}
	
}

@end
