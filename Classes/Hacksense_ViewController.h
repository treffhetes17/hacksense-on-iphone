//
//  Hacksense_ViewController.h
//  Hacksense
//
//  Created by Marton Tamás on 3/23/10.
//  Copyright Tamás Com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EEMLParser.h"
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>

@interface Hacksense_ViewController : UIViewController <MKMapViewDelegate,MKReverseGeocoderDelegate, CLLocationManagerDelegate>{
	IBOutlet UIImageView *statusImageView;
	IBOutlet UIView *creditsView;
	IBOutlet UIView *statusView;
	IBOutlet UILabel *sinceLabel;
	IBOutlet UILabel *nameLabel;
	IBOutlet UIView *mapView;
	IBOutlet UIActivityIndicatorView *indicatorView;
	IBOutlet MKMapView *map;
	MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
	EEMLParser *parser;	
	CLLocationCoordinate2D location;
}

@property (nonatomic, retain) UIImageView *statusImageView;
@property (nonatomic, retain) UIView *statusView;
@property (nonatomic, retain) UIView *creditsView;
@property (nonatomic, retain) UILabel *sinceLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;
@property (nonatomic, retain) EEMLParser *parser;
@property (nonatomic, retain) UIView *mapView;
@property (nonatomic, retain) MKMapView *map;
@property (nonatomic, retain) MKPlacemark *mPlacemark;


-(IBAction)reloadStatus:(id)sender ;
-(IBAction)showInfo:(id)sender ;
-(IBAction)showStatus:(id)sender ;
-(IBAction)showHomepage:(id)sender ;
-(IBAction)showMap:(id)sender ;
-(IBAction)showStatusFromMap:(id)sender ;

- (BOOL)openURL:(NSURL*)url;
- (BOOL)openURLString:(NSString*)urlString;
- (void) setStatus:(int)status;
- (void) reloadInfo;

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark;
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error;

@end



