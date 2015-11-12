//
//  OPAbusTableViewController.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/11/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPABusServicesAPI.h"
@interface OPAbusTableViewController : UITableViewController <OPABusServiceAPIDelegate>
@property(nonatomic,strong)NSString* routeName;
@end
