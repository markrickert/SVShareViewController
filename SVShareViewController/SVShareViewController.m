//
//  SVShareViewController.m
//
//  Created by Sam Vermette on 17.04.11.
//  Copyright 2010 Sam Vermette. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SVShareViewController.h"

#define kSWNavTintFacebook [UIColor colorWithRed:0.108 green:0.323 blue:0.552 alpha:1.000]
#define kSWNavTintTwitter [UIColor colorWithRed:0.179 green:0.591 blue:0.728 alpha:1.000]

@interface SVShareViewController ()

@property (readwrite) SVShareType shareType;

- (void)updateCharCount;

@end

@implementation SVShareViewController

@synthesize userString, defaultMessage;
@synthesize delegate, shareType;

#pragma mark -
#pragma mark View Life Cycle


- (void)dealloc {
    [super dealloc];
}


- (SVShareViewController*)initWithShareType:(SVShareType)sType {
	
	if(self = [super initWithNibName:@"SVShareViewController" bundle:[NSBundle mainBundle]]) {
		self.shareType = sType;
		logoView.hidden = YES;
		
		if(shareType == SVShareTypeFacebook && self.view) {
			navBar.tintColor = toolbar.tintColor = kSWNavTintFacebook;
			logoView.image = [UIImage imageNamed:@"SVShareViewController.bundle/facebookLogo.png"];
			charLabel.hidden = YES;
		}
		
		else if(self.view) {
			navBar.tintColor = toolbar.tintColor = kSWNavTintTwitter;
			logoView.image = [UIImage imageNamed:@"SVShareViewController.bundle/twitterLogo.png"];
			charLabel.hidden = NO;
			[self updateCharCount];
		}
		
	}
  
  self.modalPresentationStyle = UIModalPresentationFormSheet;
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
  [rTextView becomeFirstResponder];
}


#pragma mark -
#pragma mark UI Setters

- (void)setUserString:(NSString *)aString {
	userLabel.text = aString;
}

- (void)setDefaultMessage:(NSString *)aString {
	rTextView.text = aString;
}

#pragma mark -
#pragma mark Actions

- (void)dismiss {
	
    if (delegate != nil && [delegate respondsToSelector:@selector(shareViewControllerDidCancel:)])
        [delegate shareViewControllerDidCancel:self];
    else
      [self dismissModalViewControllerAnimated:YES];
}


- (void)logout {
	NSString *service;
	
	if(self.shareType == SVShareTypeFacebook)
		service = @"Facebook";
	else
		service = @"Twitter";
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Logout %@", service] 
														message:[NSString stringWithFormat:@"Are you sure you want to logout from %@?", service] 
													   delegate:self 
											  cancelButtonTitle:@"Cancel" 
											  otherButtonTitles:@"Logout", nil];
	
	alertView.transform = CGAffineTransformTranslate(alertView.transform, 0.0, 35);
	
	[alertView show];
	[alertView release];
}


#pragma mark -
#pragma mark UIAlertViewDelegate (for logout action)

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	if(buttonIndex == 1)
		[delegate shareViewController:self logoutFromService:self.shareType];
}



#pragma mark -
#pragma mark UITextView Delegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

	if([text isEqualToString:@"\n"]) {
		[delegate shareViewController:self sendMessage:textView.text forService:self.shareType];
		return NO;
	} else if ([textView.text length] >= 140)
        return NO;
	
	return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
	
	[self updateCharCount];
}
			 
- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
  
  if (rTextView.inputAccessoryView == nil) {
    NSLog(@"Creating kbd accessory");
    if(toolbar == nil)toolbar = [[UIToolbar alloc] init];
    
    [rTextView setInputAccessoryView:toolbar];
  }
  
  return YES;
}
			 
			 
- (void)updateCharCount {
	
	charLabel.text = [NSString stringWithFormat:@"%i", 140-[rTextView.text length]];;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {    

  return YES;
}

#pragma mark -
#pragma mark Memory Methods


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
