//
//  OPAbusSearchViewController.m
//  OndePassa
//
//  Created by Guilherme Endres on 3/13/14.
//  Copyright (c) 2014 Guilherme Endres. All rights reserved.
//

#import "OPAbusSearchViewController.h"
#import "OPAbusTableViewController.h"
#define LATITUDE -27.57899
#define LONGITUDE -48.533177

@interface OPAbusSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet MKMapView *searchMapView;
@property (strong,nonatomic) MKPointAnnotation *pointAnnotation;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

@end

@implementation OPAbusSearchViewController

#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.searchMapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[self navigationController] setNavigationBarHidden:YES animated:YES];
	[self setFloripaLocation];
	self.searchTextField.text = @"";
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"busRoutes"])
    {
        OPAbusTableViewController *busRoutes = (OPAbusTableViewController *)segue.destinationViewController;
        busRoutes.routeName = self.searchTextField.text;
		[self.searchTextField resignFirstResponder];
		[self showMap:NO];
    }
}

#pragma mark - Text handler

- (IBAction)cleanTextField:(UITextField *)sender {
	sender.text = @"";
}
- (IBAction)dismissKeyboardByTap:(id)sender {
	[self.searchTextField resignFirstResponder];
}

#pragma mark - Maps

- (IBAction)showMapClick:(UIButton *)sender {
	
	[self showMap:[self isMapInvisible]];
	
	CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2,
								sender.frame.origin.y + sender.frame.size.height);
	
    CLLocationCoordinate2D coordinate = [self.searchMapView convertPoint:point
												toCoordinateFromView:self.searchMapView.superview];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
													  longitude:coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *stopStreet = [placemarks objectAtIndex:0];
            self.searchTextField.text = stopStreet.thoroughfare;
		}
        else {
            self.searchTextField.text = @"";
        }
    }];

}

-(BOOL)isMapInvisible {
	return self.searchMapView.alpha == 1 ? NO : YES;
}

- (IBAction)setCurrentLocation:(UIButton *)sender {
	[self setUserLocation];
}

-(void)showMap:(BOOL)needShowMap {

	[UIView animateWithDuration:0.5
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 		 
						 self.searchMapView.alpha = needShowMap ? 1.0 : 0.0;
						 self.currentLocationButton.alpha = needShowMap ? 1.0 : 0.0;
						 
					 }
					 completion:^(BOOL finished) {
					 }];
}

-(void)setFloripaLocation {
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(LATITUDE, LONGITUDE), 2000, 2000);
    [self.searchMapView setRegion:region animated:YES];
	
}

-(void)setUserLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.searchMapView.userLocation.coordinate, 1000, 1000);
    [self.searchMapView setRegion:[self.searchMapView regionThatFits:region] animated:YES];
}

@end
