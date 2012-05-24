//
//  SVShareViewController Demo Project
//	AppDelegate.h
//
//  Created by Sam Vermette on 16.04.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewController *viewController;
}

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) IBOutlet ViewController *viewController;

@end

