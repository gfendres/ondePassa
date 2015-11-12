//
//  OPAbusDetailViewController.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/12/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "OPAbusDetailViewController.h"
#import "OPABusStop.h"
#import "OPABusDepartures.h"
#define CELL_STOP_NAME 1

@interface OPAbusDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *stopsTableView;
@property (nonatomic,strong)NSMutableArray* stops;
@property (weak, nonatomic) IBOutlet UILabel *weekDepartures;
@property (weak, nonatomic) IBOutlet UILabel *sundayDepartures;
@property (weak, nonatomic) IBOutlet UILabel *saturdayDepartures;
@property (weak, nonatomic) IBOutlet UIScrollView *departuresScrollView;
@property(nonatomic,strong)NSMutableArray* departures;

@end

@implementation OPAbusDetailViewController


#pragma mark Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[OPABusServicesAPI instance].delegate = self;
	[self loadData];
	self.title = _route.longName;
}

#pragma Load methods

-(void)loadData
{
	[self loadStops];
	[self loadDepartures];
}

-(void)loadStops
{
	_stops = [NSMutableArray new];
	[[OPABusServicesAPI instance] getStops:_route.identifier];
}

-(void)loadDepartures
{
	_departures = [NSMutableArray new];
	[[OPABusServicesAPI instance] getDepartures:_route.identifier];
}

-(void)organizeDepartures
{
	[self initDepartureLabel:_weekDepartures withDayType:@"WEEKDAY"];
	[self initDepartureLabel:_saturdayDepartures withDayType:@"SATURDAY"];
	[self initDepartureLabel:_sundayDepartures withDayType:@"SUNDAY"];
}

-(void)initDepartureLabel:(UILabel*)departureLabel withDayType:(NSString*)dayType
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"calendar = '%@'",dayType]];
	for (OPABusDepartures* departures in [_departures filteredArrayUsingPredicate:predicate]) {
		departureLabel.text = [NSString stringWithFormat:@"%@ %@ %@",
							   departureLabel.text,
							   [departureLabel.text  isEqual: @""] ? @"" : @"-",
							   departures.time];
	}
	
	if ([departureLabel.text isEqualToString:@""]) {
		departureLabel.text = @"No Departures";
	}
	
	[departureLabel sizeToFit];
	[self organizeDepartureScrollViewBasedOnLabel:departureLabel];
}

#define SCROLL_MARGIN_RIGHT 30
-(void)organizeDepartureScrollViewBasedOnLabel:(UILabel*)label
{
	if(_departuresScrollView.contentSize.width < label.frame.size.width){
		[_departuresScrollView setContentSize:CGSizeMake(label.frame.size.width + SCROLL_MARGIN_RIGHT,
														 _departuresScrollView.frame.size.height)];
	}
}

#pragma mark - OPABusServices Delegates

-(void)getStopsSuccessful:(NSMutableArray *)dataSource{
	_stops = dataSource;
	[_stopsTableView reloadData];
}

-(void)getDeparturesSuccessful:(NSMutableArray *)dataSource{
	_departures = dataSource;
	[self organizeDepartures];
}

-(void)opaBusServiceAPIFailure:(NSString *)error{
	[UIAlertView showErrorWithMessage:error];
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
    return _stops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    OPABusStop *stop = (OPABusStop*)[_stops objectAtIndex:indexPath.row];
	
	UILabel* stopName = (UILabel*)[cell viewWithTag:CELL_STOP_NAME];
	stopName.text = stop.name;
    return cell;
}



@end
