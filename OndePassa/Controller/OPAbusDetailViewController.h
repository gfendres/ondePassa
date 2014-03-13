//
//  OPAbusDetailViewController.h
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPABusRoutes.h"

@interface OPAbusDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)OPABusRoutes* route;
@end
