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

static const int kCellStopTag = 1;
static const int kScrollMarginRight = 30;

@interface OPAbusDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *stopsTableView;
@property (nonatomic,strong) NSMutableArray *stops;
@property (weak, nonatomic) IBOutlet UILabel *weekDepartures;
@property (weak, nonatomic) IBOutlet UILabel *sundayDepartures;
@property (weak, nonatomic) IBOutlet UILabel *saturdayDepartures;
@property (weak, nonatomic) IBOutlet UIScrollView *departuresScrollView;
@property (nonatomic,strong) NSMutableArray *departures;

@end

@implementation OPAbusDetailViewController


#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[OPABusServicesAPI instance].delegate = self;
	[self loadData];
	self.title = self.route.longName;
}

#pragma Load methods

- (void)loadData {
	[self loadStops];
	[self loadDepartures];
}

- (void)loadStops {
	self.stops = [NSMutableArray new];
	[[OPABusServicesAPI instance] getStops:self.route.identifier];
}

- (void)loadDepartures {
	self.departures = [NSMutableArray new];
	[[OPABusServicesAPI instance] getDepartures:self.route.identifier];
}

- (void)organizeDepartures {
	[self initDepartureLabel:self.weekDepartures withDayType:@"WEEKDAY"];
	[self initDepartureLabel:self.saturdayDepartures withDayType:@"SATURDAY"];
	[self initDepartureLabel:self.sundayDepartures withDayType:@"SUNDAY"];
}

- (void)initDepartureLabel:(UILabel*)departureLabel withDayType:(NSString*)dayType {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"calendar = '%@'",dayType]];
	for (OPABusDepartures* departures in [self.departures filteredArrayUsingPredicate:predicate]) {
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

-(void)organizeDepartureScrollViewBasedOnLabel:(UILabel*)label {
	if(self.departuresScrollView.contentSize.width < label.frame.size.width){
		[self.departuresScrollView setContentSize:CGSizeMake(label.frame.size.width + kScrollMarginRight,
                                                             self.departuresScrollView.frame.size.height)];
	}
}

#pragma mark - OPABusServices Delegates

- (void)getStopsSuccessful:(NSMutableArray *)dataSource{
	self.stops = dataSource;
	[self.stopsTableView reloadData];
}

- (void)getDeparturesSuccessful:(NSMutableArray *)dataSource{
	self.departures = dataSource;
	[self organizeDepartures];
}

- (void)opaBusServiceAPIFailure:(NSString *)error{
	[UIAlertView showErrorWithMessage:error];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"stopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    OPABusStop *stop = (OPABusStop*)[_stops objectAtIndex:indexPath.row];
	
	UILabel* stopName = (UILabel*)[cell viewWithTag:kCellStopTag];
	stopName.text = stop.name;
    return cell;
}



@end
