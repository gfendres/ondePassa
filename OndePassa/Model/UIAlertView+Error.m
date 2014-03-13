//
//  UIAlertView+Error.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/13/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "UIAlertView+Error.h"

@implementation UIAlertView (Error)
+(void)showErrorWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}
@end
