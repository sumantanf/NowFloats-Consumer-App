//
//  RegisterViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LoginViewController;
#import "LoginViewController.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIScrollView *avatharsScrollView;
    NSMutableArray *femaleImageNames;
    NSMutableArray *maleImageNames;
    IBOutlet UIButton *loginButton;
    LoginViewController *loginViewCon;
  
    //Date of Birth
    IBOutlet UIView *dateView;
    NSDate *dateofBirth;
    IBOutlet UIDatePicker *datepicker;
    IBOutlet  UIButton *dateButton;
    
    NSString *fullName;
    NSString *displayName;
    NSString *emailAdress;
    NSString *password;
    NSString *dataofbirthString;
    int avatarId;
    BOOL isMale;
    
    
    NSMutableData *receivedData;
    
    IBOutlet UITextField *userNameTF;
    IBOutlet UITextField *displayNameTF;
    IBOutlet UITextField *emailTF;
    IBOutlet UITextField *passwordTF;
    IBOutlet UITextField *confirmationTF;
    NSString *dateOfBirthString;
    NSDateFormatter *dateFormatter;
    int selectedAvatarId;
    UILabel *avatarLbl;
    
    IBOutlet UIButton *femaleButton;
    IBOutlet UIButton *maleButton;
    IBOutlet UIButton *floatButton;
    IBOutlet UIButton *setButton;
    IBOutlet UIButton *cancelButton;
    
    NSMutableDictionary *dic;
}
@property (nonatomic ,retain) LoginViewController *loginViewCon;
-(IBAction)backButtonClicked:(id)sender;
-(IBAction)femaleButtonClicked:(id)sender;
-(IBAction)maleButtonClikced:(id)sender;
-(void)maleIconSelected:(id)sender;
-(void)femaleIconSelected:(id)sender;
-(IBAction)goToHomeButtonClicke:(id)sender;
-(void)textFieldButonClicked:(id)sender;
-(IBAction)dateofBirthButtonClicked:(id)sender;
-(IBAction)setButtonClicked:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;
-(IBAction)registrationButtonClicked:(id)sender;
-(void)checkAllFields;
-(BOOL) validEmail:(NSString*) emailString ;
-(void)checkEmail;
-(void)checkPassword;

@end
