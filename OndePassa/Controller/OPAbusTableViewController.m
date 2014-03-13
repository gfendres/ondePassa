//
//  OPAbusTableViewController.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/11/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "OPAbusTableViewController.h"
#import "OPARoutesCell.h"
#import "OPABusRoutes.h"
#import "OPAbusDetailViewController.h"

@interface OPAbusTableViewController ()
@property(nonatomic,strong)NSMutableArray* dataSource;
@end

@implementation OPAbusTableViewController

#pragma mark Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadData];
}

#pragma mark - Loads

-(void)loadData
{
	
	_dataSource = [NSMutableArray new];
    [[AFHTTPRequestOperationManager AFRequest] POST:ROUTES
										 parameters:[self getParametersWithStopName:_routeName]
											success:^(AFHTTPRequestOperation *operation, id responseObject) {
												
												for(NSDictionary *routesJSON in responseObject[@"rows"])
												{
													OPABusRoutes *busRoute = [OPABusRoutes new];
													busRoute.agencyId = [routesJSON[@"agencyId"] integerValue];
													busRoute.identifier = [routesJSON[@"id"] integerValue];
													busRoute.lastModifiedDate = routesJSON[@"lastModifiedDate"];
													busRoute.longName = routesJSON[@"longName"];
													busRoute.shortName = routesJSON[@"shortName"];
													[_dataSource addObject:busRoute];
												}
												self.dataSource = _dataSource;
												[self.tableView reloadData];
												
											}
											failure:^(AFHTTPRequestOperation *operation, NSError *err) {
												
												[UIAlertView showErrorWithMessage:err.domain];
											}
     ];
}

-(NSDictionary*)getParametersWithStopName:(NSString*)stopName
{
	return @{@"params" : @{ @"stopName": [NSString stringWithFormat:@"%%%@%%",[stopName lowercaseString]]} };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"busCell";
    OPARoutesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    OPABusRoutes *route = (OPABusRoutes*)[_dataSource objectAtIndex:indexPath.row];
	
	cell.shortName.text = route.shortName;
	cell.longName.text = route.longName;
    
    return cell;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"busDetail"])
    {
        OPAbusDetailViewController *busDetail = (OPAbusDetailViewController *)segue.destinationViewController;
        busDetail.route = [_dataSource objectAtIndex:[self.tableView indexPathForCell:sender].row];
    }
}


@end
