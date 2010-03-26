//
//  EEMLParser.m
//  Hacksense for IPhone
//
//  Created by Marton Tamás on 3/24/10.
//  Copyright 2010 Tamás Com. All rights reserved.
//

#import "EEMLParser.h"


@implementation EEMLParser

@synthesize theParser,data, item,currentElement,feedLastUpdated, feedTitle, feed, status, description,
			iconURLString, websiteURLString, locationName, locationLAT, locationLON, locationELE,
			currentValue,currentTags;
@synthesize activityIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (int) getStatus {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"value"];
		
		int result=[value intValue];
		NSLog(@"Result: %i",result);
		[anItem release];
		[value release];
		return result;
		
	}	
	NSLog(@"The value data was empty");
	return  -1;
}

- (NSString *) getSince {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"updated"];
		[anItem release];
		NSLog(@"Updated: %s", value);
		return value;
		
	}	
	NSLog(@"The updated data was empty");
	return  @"Updated:N/A";
}

- (NSString *) getLocationName {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"name"];
		[anItem release];
		NSLog(@"Updated: %s", value);
		return value;
		
	}	
	NSLog(@"The locationname data was empty");
	return  @"N/A";
}


- (NSString *) getLon {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"lon"];
		[anItem release];
		NSLog(@"Updated: %s", value);
		return value;
		
	}	
	NSLog(@"The lon data was empty");
	return  @"N/A";
}

- (NSString *) getLat {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"lat"];
		[anItem release];
		NSLog(@"Updated: %s", value);
		return value;
		
	}	
	NSLog(@"The lat data was empty");
	return  @"N/A";
}

- (NSString *) getElevation {
	if ([self.data count]>0) {
		NSDictionary *anItem=[self.data objectAtIndex:0];
		if (anItem!=NULL) {
			
		} else {
			NSLog(@"The feed was empty");
		}
		NSString *value = [anItem objectForKey:@"ele"];
		[anItem release];
		NSLog(@"elev: %s", value);
		return value;
		
	}	
	NSLog(@"The elev data was empty");
	return  @"N/A";
}



- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	data = [[NSMutableArray alloc] init];
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    theParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [theParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [theParser setShouldProcessNamespaces:NO];
    [theParser setShouldReportNamespacePrefixes:NO];
    [theParser setShouldResolveExternalEntities:NO];
	
    [theParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download data feed from web site (Error code %i )",
							  [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self
												cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    //NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"environment"]) {
		// clear out our feed item caches...
		item = [[NSMutableDictionary alloc] init];
		feedLastUpdated= [[NSMutableString alloc] init];
		feedTitle= [[NSMutableString alloc] init];
		feed= [[NSMutableString alloc] init];
		status= [[NSMutableString alloc] init];
		description= [[NSMutableString alloc] init];
		iconURLString= [[NSMutableString alloc] init];
		websiteURLString= [[NSMutableString alloc] init];
		locationName= [[NSMutableString alloc] init];
		locationLAT= [[NSMutableString alloc] init];
		locationLON= [[NSMutableString alloc] init];
		locationELE= [[NSMutableString alloc] init];
		currentValue= [[NSMutableString alloc] init];
		currentTags= [[NSMutableString alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"environment"]) {
		// save values to an item, then store that item into the array...
		[item setObject:feedTitle forKey:@"title"];
		[item setObject:feed forKey:@"feed"];
		[item setObject:status forKey:@"status"];
		[item setObject:feedLastUpdated forKey:@"updated"];
		[item setObject:description forKey:@"description"];
		[item setObject:iconURLString forKey:@"icon"];
		[item setObject:websiteURLString forKey:@"website"];
		[item setObject:locationName forKey:@"name"];
		[item setObject:locationLAT forKey:@"lat"];
		[item setObject:locationLON forKey:@"lon"];
		[item setObject:locationELE forKey:@"ele"];
		[item setObject:currentValue forKey:@"value"];
		[data addObject:[item copy]];
		NSLog(@"adding environment: %@", feedTitle);
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[feedTitle appendString:string];
	} else if ([currentElement isEqualToString:@"feed"]) {
		[feed appendString:string];
	} else if ([currentElement isEqualToString:@"status"]) {
		[status appendString:string];
	} else if ([currentElement isEqualToString:@"updated"]) {
		[feedLastUpdated appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[description appendString:string];
	} else if ([currentElement isEqualToString:@"icon"]) {
		[iconURLString appendString:string];
	} else if ([currentElement isEqualToString:@"website"]) {
		[websiteURLString appendString:string];
	} else if ([currentElement isEqualToString:@"name"]) {
		[locationName appendString:string];
	} else if ([currentElement isEqualToString:@"lat"]) {
		[locationLAT appendString:string];
	} else if ([currentElement isEqualToString:@"lon"]) {
		[locationLON appendString:string];
	} else if ([currentElement isEqualToString:@"ele"]) {
		[locationELE appendString:string];
	} else if ([currentElement isEqualToString:@"value"]) {
		[currentValue appendString:string];
	} 
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	NSLog(@"all done!");
	NSLog(@"data array has %d items", [data count]);
	
	/*[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"data array has %d items", [stories count]);
	[newsTable reloadData];
	 */
}


- (void)dealloc {
	[theParser release]; 
	[data release];
	[item release]; 
	[currentElement release]; 
	[feedLastUpdated release]; 
	[feedTitle release]; 
	[feed release]; 
	[status release]; 
	[description release]; 
	[iconURLString release]; 
	[websiteURLString release]; 
	[locationName release];
	[locationLAT release]; 
	[locationLON release];
	[locationELE release]; 
	[currentValue release]; 
	[currentTags release];
	
    [super dealloc];
}


@end
