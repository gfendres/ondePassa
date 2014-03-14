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
@property (weak, nonatomic) IBOutlet UIView *errorView;

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
	[OPABusServicesAPI instance].delegate = self;
	[[OPABusServicesAPI instance] getRoutes:_routeName];
	
}

#pragma mark - OPABusServices Delegates

-(void)getRoutesSuccessful:(NSMutableArray *)dataSource{
	if (dataSource.count == 0) {
		[_errorView setHidden:NO];
	}else{
		_dataSource = dataSource;
		[self.tableView reloadData];
	}
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
