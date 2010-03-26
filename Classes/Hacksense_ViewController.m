//
//  Hacksense_ViewController.m
//  Hacksense
//
//  Created by Marton Tamás on 3/23/10.
//  Copyright Tamás Com 2010. All rights reserved.
//

#import "Hacksense_ViewController.h"

@implementation Hacksense_ViewController

@synthesize statusImageView, sinceLabel, nameLabel, indicatorView, statusView, creditsView, parser;
@synthesize mapView, map, mPlacemark;
//@synthesize mPlacemark;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		
    }
    return self;
	
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	[self.view addSubview:statusView];

}
 

- (IBAction)reloadStatus:(id)sender {
	[statusView bringSubviewToFront:indicatorView];
	[indicatorView startAnimating];
	//long rnd=random();
	//int status=rnd % 2;
	[self reloadInfo];
	[indicatorView stopAnimating];
	[statusView bringSubviewToFront:statusImageView];

}

- (void) reloadInfo {
	parser= [[EEMLParser alloc] init];
	parser.activityIndicator=indicatorView;
	[parser parseXMLFileAtURL:@"http://vsza.hu/hacksense/eeml_status.xml"];
	[self setStatus: [parser getStatus]];
	self.nameLabel.text=(@"Name:%s",[parser getLocationName]);
	
//	self.sinceLabel.text=(@"Since:%s",[parser getSince]);
	//[parser release];
	
}



//Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//	map = [[MKMapView alloc ]initWithFrame:mapView.frame];
//	sinceLabel.text=@"Nyitva már egy ideje";
	
	//Init Map View
	
	MKCoordinateRegion region;
	CLLocationCoordinate2D coordinate=map.userLocation.coordinate;
	coordinate.latitude=47.501192;
	coordinate.longitude=19.065088;
	
	// Set Map Viewport
	region.center=coordinate;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.002;
	span.longitudeDelta=.002;
	region.span=span;	
	[map setRegion:region animated:TRUE];
	[map regionThatFits:region];

	/*Geocoder Stuff*/
	
	geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
	geoCoder.delegate=self;
	[geoCoder start];
	
	
	
	[self reloadInfo];

}

- (void) setStatus:(int)status {
		
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:statusImageView cache:YES];
	if (status==0) {
		statusImageView.image=[UIImage imageNamed:@"close_portrait_big.jpg"];
	} else if (status==1) {
		statusImageView.image=[UIImage imageNamed:@"open_portrait_big.jpg"];
	} else {
		statusImageView.image=[UIImage imageNamed:@"outoforder.jpg"];
	}
	[UIView commitAnimations];
	NSLog(@"Status set");
	
	//images=nil;
	
}


-(IBAction)showInfo:(id)sender {
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationDelegate:self];
	if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
		
	
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
						   forView:self.view cache:YES];
	} else {
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
							   forView:self.view cache:YES];

	}
	[statusView removeFromSuperview];
	[self.view addSubview:creditsView];
	[UIView commitAnimations];
		NSLog(@"Info window showed");
	
}

-(IBAction)showStatus:(id)sender {
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
						   forView:self.view cache:YES];
	[creditsView removeFromSuperview];
	[self.view addSubview:statusView];
	[UIView commitAnimations];
		NSLog(@"Status window showed");
	
}

-(IBAction)showStatusFromMap:(id)sender {
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
						   forView:self.view cache:YES];
	[mapView removeFromSuperview];
	[self.view addSubview:statusView];
	[UIView commitAnimations];
	NSLog(@"Status window showed");
	
}

-(IBAction)showMap:(id)sender {		
	
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration: 1.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
						   forView:self.view cache:YES];
	[statusView removeFromSuperview];
	[self.view addSubview:mapView];
	[UIView commitAnimations];
	
		//[map release];
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"Reverse Geocoder Errored");
	
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
	[map addAnnotation:placemark];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
	return annView;
}


-(IBAction)showHomepage:(id)sender {
	[self openURLString:@"http://www.hspbp.org"];
		NSLog(@"Went to Homepage");
}

- (BOOL)openURL:(NSURL*)url
{
	// Launch the external app
	return [[UIApplication sharedApplication] openURL:url];
}


- (BOOL)openURLString:(NSString*)urlString
{
	if ([urlString length] > 0) {
		return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
	} else {
		return NO;
	}
}





// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	
	
	/*if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
		landscapeImageView.hidden=TRUE;
		portraitImageView.hidden=FALSE;
	} else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
		landscapeImageView.hidden=FALSE;
		portraitImageView.hidden=TRUE;
		return true;
	}
	//return TRUE;
	 */
    return (interfaceOrientation == UIInterfaceOrientationPortrait );
			// TODO: It doesn't rearrange the gui if it's in Landscape mode and checking the credits. So it's only Protrait mode
	        // || interfaceOrientation == UIInterfaceOrientationLandscapeLeft );
	
	 
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self.statusImageView release];
	[self.indicatorView release];
	[self.sinceLabel release];
	[self.statusView release];
	[self.creditsView release];
	[self.mapView release];
	[self.map release];

}


- (void)dealloc {
	[statusImageView release];
	[indicatorView release];	
	[sinceLabel release];	
	[statusView release];
	[creditsView release];
	[mapView release];
	[map release];
	[mPlacemark release];
    [super dealloc];
}





@end
