//
//  SVShareViewController.h
//
//  Created by Sam Vermette on 17.04.11.
//  Copyright 2010 Sam Vermette. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SVShareType {
	SVShareTypeFacebook,
	SVShareTypeTwitter
};

typedef enum SVShareType SVShareType;

@protocol SVShareViewControllerDelegate;

@interface SVShareViewController : UIViewController <UIAlertViewDelegate, UITextViewDelegate> {
	IBOutlet UITextView *rTextView;
	IBOutlet UINavigationBar *navBar;
	IBOutlet UIToolbar *toolbar;
	IBOutlet UIImageView *logoView;
	IBOutlet UIBarButtonItem *logoutButton;
	IBOutlet UILabel *charLabel, *userLabel;
}

@property (nonatomic, unsafe_unretained) id<SVShareViewControllerDelegate> delegate;
@property (nonatomic, unsafe_unretained) NSString *userString;
@property (nonatomic, unsafe_unretained) NSString *defaultMessage;

- (SVShareViewController*)initWithShareType:(SVShareType)shareType;

- (IBAction)dismiss;
- (IBAction)logout;

@end


@protocol SVShareViewControllerDelegate <NSObject>

- (void)shareViewController:(SVShareViewController*)controller sendMessage:(NSString*)string forService:(SVShareType)shareType;
- (void)shareViewController:(SVShareViewController*)controller logoutFromService:(SVShareType)shareType;
@optional
- (void)shareViewControllerDidCancel:(SVShareViewController*)controller;

@end
