//
//  EEMLParser.h
//  Hacksense for IPhone
//
//  Created by Marton Tamás on 3/24/10.
//  Copyright 2010 Tamás Com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EEMLParser : UITableViewCell {
	NSXMLParser *theParser;
	
	NSMutableArray *data;
	
	
	// a temporary item; added to the "data" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString *feedLastUpdated, *feedTitle, *feed, *status, *description, *iconURLString, *websiteURLString,
	*locationName, *locationLAT, *locationLON, *locationELE;
	NSMutableString * currentValue, *currentTags;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) NSXMLParser *theParser;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableDictionary * item;
@property (nonatomic, retain) NSString * currentElement;
@property (nonatomic, retain) NSMutableString *feedLastUpdated, *feedTitle, *feed, *status, *description, *iconURLString, *websiteURLString,
							  *locationName, *locationLAT, *locationLON, *locationELE;
@property (nonatomic, retain) NSMutableString * currentValue, *currentTags;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

-(int) getStatus ;
-(NSString *) getSince ;
-(NSString *) getLocationName ;
-(NSString *) getLon ;
-(NSString *) getLat ;
-(NSString *) getElevation ;
- (void)parseXMLFileAtURL:(NSString *)URL;


@end
