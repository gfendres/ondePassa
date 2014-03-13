//
//  OPAbusSearchViewController.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/13/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "OPAbusSearchViewController.h"
#import "OPAbusTableViewController.h"
@interface OPAbusSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation OPAbusSearchViewController

#pragma mark Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"busRoutes"])
    {
        OPAbusTableViewController *busRoutes = (OPAbusTableViewController *)segue.destinationViewController;
        busRoutes.routeName = _searchTextField.text;
		[_searchTextField resignFirstResponder];
    }
}

#pragma mark - Text handler

- (IBAction)cleanTextField:(UITextField *)sender {
	sender.text = @"";
}
- (IBAction)dismissKeyboardByTap:(id)sender {
	[_searchTextField resignFirstResponder];
}


@end
