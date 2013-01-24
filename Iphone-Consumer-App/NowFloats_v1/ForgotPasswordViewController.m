//
//  ForgotPasswordViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MarqueeLabel.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize loginViewCon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [resetButton.layer setCornerRadius:5];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)backButtonClicked:(id)sender
{
    [self.view removeFromSuperview];
}
-(IBAction)goToHomeButtonClicke:(id)sender{
    
    [self.view removeFromSuperview];
    [loginViewCon.view removeFromSuperview];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
