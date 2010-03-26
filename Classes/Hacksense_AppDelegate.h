//
//  Hacksense_AppDelegate.h
//  Hacksense
//
//  Created by Marton Tamás on 3/23/10.
//  Copyright Tamás Com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hacksense_ViewController;

@interface Hacksense_AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Hacksense_ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Hacksense_ViewController *viewController;

@end

