//
//  ForgotPasswordViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LoginViewController;

@interface ForgotPasswordViewController : UIViewController{
    
    IBOutlet UIButton *loginButton;
    LoginViewController *loginViewCon;
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *resetButton;
    
}
@property (nonatomic ,retain) LoginViewController *loginViewCon;

-(IBAction)backButtonClicked:(id)sender;
-(IBAction)goToHomeButtonClicke:(id)sender;

@end
