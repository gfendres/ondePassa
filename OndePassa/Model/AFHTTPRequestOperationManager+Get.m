//
//  AFHTTPRequestOperationManager+Get.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Get.h"
#define USERNAME @"WKD4N7YMA1uiM8V"
#define PASSWORD @"DtdTtzMLQlA0hk2C1Yi5pLyVIlAQ68"

@implementation AFHTTPRequestOperationManager (Get)
+ (AFHTTPRequestOperationManager*)AFRequest {
	NSURL *url = [NSURL URLWithString:ROOT_URL];
    AFHTTPRequestOperationManager *operation = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
	
	operation.requestSerializer = [AFJSONRequestSerializer serializer];
    [operation.requestSerializer setAuthorizationHeaderFieldWithUsername:USERNAME
																password:PASSWORD];

    [operation.requestSerializer setValue:@"staging" forHTTPHeaderField:@"X-AppGlu-Environment"];
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:(NSJSONReadingAllowFragments)];
	
	return operation;
}
@end
