//
//  OPAbusDetailViewController.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPABusRoutes.h"
#import "OPABusServicesAPI.h"

@interface OPAbusDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,OPABusServiceAPIDelegate>
@property(nonatomic,strong)OPABusRoutes* route;
@end
