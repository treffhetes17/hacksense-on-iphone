//
//  Hacksense_AppDelegate.m
//  Hacksense
//
//  Created by Marton Tamás on 3/23/10.
//  Copyright Tamás Com 2010. All rights reserved.
//

#import "Hacksense_AppDelegate.h"
#import "Hacksense_ViewController.h"

@implementation Hacksense_AppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
