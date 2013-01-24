//
//  LoginViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ForgotPasswordViewController.h"
//#import "RegisterViewController.h"
@class RegisterViewController;

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    ForgotPasswordViewController *forgotpasswordViewCon;
    RegisterViewController *registerViewCon;
    
    IBOutlet UIView *loginView;
    IBOutlet UIView *changeAvatarView;
    IBOutlet UIView *logoutView;
    IBOutlet UILabel *userName;
    IBOutlet UIImageView    *avatarImageView;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *changeAvatarButton;
    
    IBOutlet UITextField *UserNameTextField;
    IBOutlet UITextField *passwordTextField;
    

    NSMutableData *receivedData;
    NSUserDefaults *userdetails;
    //User Details
    IBOutlet UILabel *profileName;
    IBOutlet UIImageView *profilePic;
    IBOutlet UILabel *avatarLabel;
    IBOutlet UIScrollView *bottomBar;

    IBOutlet UIImageView *avatarView1;
    
    IBOutlet UIButton *avatarView2;
    IBOutlet UIButton *avatarView3;
    IBOutlet UIButton *avatarView7;
    IBOutlet UIButton *avatarView4;
    IBOutlet UIButton *avatarView5;
    IBOutlet UIButton *avatarView6;
    IBOutlet UILabel *avatarHolderName;
    NSMutableArray *maleImageNames;
    NSMutableArray *femaleImageNames;
    
    IBOutlet UILabel *avatarLabel2;
    IBOutlet UILabel *avatarLabel3;
    IBOutlet UILabel *avatarLabel4;
    IBOutlet UILabel *avatarLabel5;
    IBOutlet UILabel *avatarLabel6;
    IBOutlet UILabel *avatarLabel7;
    int FromLogin;

    AppDelegate *appDelegate;
}
@property (nonatomic , retain ) IBOutlet UIView *loginView;
@property (nonatomic , retain ) IBOutlet UIView *logoutView;
@property (nonatomic , retain ) IBOutlet UILabel *profileName;
@property (nonatomic , retain ) IBOutlet UILabel *avatarLabel;
@property (nonatomic , retain ) IBOutlet UIImageView *profilePic;

-(IBAction)backButtonClicked:(id)sender;
-(IBAction)forgotPasswordButtonClicked:(id)sender;
-(IBAction)registrationButtonClicked:(id)sender;
-(IBAction)changeAvatarButtonClicked:(id)sender;
-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)avatarButtonClicked:(id)sender;
-(IBAction)goToHomePage:(id)sender;
-(IBAction)loginUserDetails:(id)sender;
-(IBAction)logoutButtonClicked:(id)sender;


@end
