//
//  AFHTTPRequestOperationManager+Get.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define ROOT_URL @"https://dashboard.appglu.com/v1/queries/"
#define ROUTES @"findRoutesByStopName/run"
#define STOPS @"findStopsByRouteId/run"
#define DEPARTURES @"findDeparturesByRouteId/run"

@interface AFHTTPRequestOperationManager (Get)
+(AFHTTPRequestOperationManager*)AFRequest;
@end
