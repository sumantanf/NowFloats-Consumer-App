//
//  RegisterViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController
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
    avatarLbl=[[UILabel alloc] init];
    [floatButton.layer setCornerRadius:2];
    [setButton.layer setCornerRadius:4];
    [cancelButton.layer setCornerRadius:4];
    [avatarLbl setText:@"AVATAR"];
    [avatarLbl setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0 blue:5.0/255.0 alpha:1]];
    [avatarLbl setBackgroundColor:[UIColor clearColor]];
    [avatarLbl setFrame:CGRectMake(20, 10, 60, 40)];
    [dateButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    femaleImageNames=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<7; i++) {
        NSString *name=[NSString stringWithFormat:@"female_avatar_%d.png",i];
        [femaleImageNames addObject:name];
    }
    
    maleImageNames=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<7; i++) {
        NSString *name=[NSString stringWithFormat:@"male_avatar_%d.png",i];
        [maleImageNames addObject:name];
    }
    // Do any additional setup after loading the view from its nib.
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)backButtonClicked:(id)sender
{
    [self.view removeFromSuperview];
}

-(IBAction)goToHomeButtonClicke:(id)sender
{
    
    [self.view removeFromSuperview];
    [loginViewCon.view removeFromSuperview];
    
}

-(IBAction)femaleButtonClicked:(id)sender
{
    isMale=NO;
    [femaleButton setAlpha:1.0f];
    [maleButton setAlpha:0.5f];
    [avatharsScrollView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:5.0f/255.0f alpha:1]];
    for (UIView *v in avatharsScrollView.subviews) {
        [v removeFromSuperview];
        
    }
    int x=5;
    
    
    for (int i=0; i<[femaleImageNames count]; i++) {
        UIButton  *imageView=[UIButton buttonWithType:UIButtonTypeCustom];
        [imageView setImage:[UIImage imageNamed:[femaleImageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [imageView addTarget:self action:@selector(femaleIconSelected:) forControlEvents:UIControlEventTouchUpInside];
        [avatharsScrollView addSubview:imageView];
        [imageView setTag:i+1];
        [imageView setFrame:CGRectMake(10, 10, 40, 40)];
    }
    
    for (int i=0; i<[femaleImageNames count]; i++) {
        
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:1.5];
        UIButton *imageVi=(UIButton *)[avatharsScrollView viewWithTag:i+1];
        
        [imageVi setFrame:CGRectMake(x, 10, 40, 40)];
        
        
        x=x+45;
        
        [UIView commitAnimations];
    }    
    
}

-(IBAction)maleButtonClikced:(id)sender
{
    isMale=YES;
    [avatharsScrollView setBackgroundColor:[UIColor clearColor]];
    [femaleButton setAlpha:0.5f];
    [maleButton setAlpha:1.0f];
    [avatharsScrollView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:5.0f/255.0f alpha:1]];
    for (UIView *v in avatharsScrollView.subviews) {
        [v removeFromSuperview];
        
    }
    
    int x=5;
    
    
    for (int i=0; i<[maleImageNames count]; i++) {
        UIButton  *imageView=[UIButton buttonWithType:UIButtonTypeCustom];
        [imageView setImage:[UIImage imageNamed:[maleImageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [imageView addTarget:self action:@selector(maleIconSelected:) forControlEvents:UIControlEventTouchUpInside];
        [avatharsScrollView addSubview:imageView];
        [imageView setTag:i+1];
        [imageView setFrame:CGRectMake(10, 10, 40, 40)];
    }
    
    for (int i=0; i<[maleImageNames count]; i++) {
        
        [UIView beginAnimations:@"ToggleViews" context:nil];
        [UIView setAnimationDuration:1.5];
        UIButton *imageVi=(UIButton *)[avatharsScrollView viewWithTag:i+1];
        
        [imageVi setFrame:CGRectMake(x, 10, 40, 40)];
        
        
        x=x+45;
        
        [UIView commitAnimations];
    }
}

-(void)maleIconSelected:(id)sender
{
    [avatharsScrollView setBackgroundColor:[UIColor clearColor]];
    for (UIView *v in avatharsScrollView.subviews) {
        [v removeFromSuperview];
        
    }
    UIButton *b=(UIButton *)sender;
    
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[maleImageNames objectAtIndex:b.tag-1]]];
    [image setTag:b.tag-1];
    selectedAvatarId=b.tag;
    [image setFrame:CGRectMake(240, 10, 40, 40)];
    [avatharsScrollView addSubview:image];
    [avatarLbl setFont:[UIFont fontWithName:@"Helvetica" size:11]];

    [avatharsScrollView addSubview:avatarLbl];
}

-(void)femaleIconSelected:(id)sender
{
    [avatharsScrollView setBackgroundColor:[UIColor clearColor]];
    for (UIView *v in avatharsScrollView.subviews) {
        [v removeFromSuperview];
        
    }
    UIButton *b=(UIButton *)sender;
    
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[femaleImageNames objectAtIndex:b.tag-1]]];
    [image setTag:b.tag-1];
    selectedAvatarId=b.tag;

    [image setFrame:CGRectMake(132, 10, 40, 40)];
    [avatharsScrollView addSubview:image];
    [avatarLbl setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [avatharsScrollView addSubview:avatarLbl];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length]>0)
    {
        UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
        [b setTag:textField.tag+10];
        [b setFrame:CGRectMake(textField.frame.origin.x+3, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
        [b setFont:[UIFont systemFontOfSize:18]];
        
        if (textField.tag==4 || textField.tag==5) {
            NSString *starString=@"•";
            for (int i=0; i<[textField.text length]-1; i++) {
                starString=[NSString stringWithFormat:@"%@•",starString];
            }
            [b setTitle:starString forState:UIControlStateNormal];
            if (textField.tag==5) {
               // confirmationTF=textField;
               // [textField resignFirstResponder];
            }
        }
        else {
            [b setTitle:textField.text forState:UIControlStateNormal];
        }
        
        [self.view addSubview:b];
        [b addTarget:self action:@selector(textFieldButonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [b setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [textField setHidden:YES];
        
    }

    if (textField.tag==1)
    {
        
        if ([userNameTF.text isEqual:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Fullname cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        
        }

    }
    
    if (textField.tag==2)
    {
        if ([displayNameTF.text isEqual:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Display name cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            
            [alert show];
            
            
        }
        
        if ([displayNameTF.text length]<3)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Display name should be more than 3 characters" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            
            [alert show];

        }
        

    }
    
    if (textField.tag==3)
    {
    
        if ([emailTF.text isEqual:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Email ID cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            
        }
        
        if (emailTF.text)
        {
            [self checkEmail];
        }

    }
    
    if (textField.tag==4)
    {
        if([passwordTF.text isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Password cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }
    
    if (textField.tag==5)
    {

        if (![passwordTF.text isEqualToString: confirmationTF.text] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Password should match Confirm Password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            
        }

        
    }
    
        
    
}


-(void)textFieldButonClicked:(id)sender
{
    
    UIButton *b=(UIButton *)sender;

    UITextField *tf=(UITextField *)[self.view viewWithTag:b.tag-10];
    [tf setHidden:NO];
    [tf becomeFirstResponder];
    [b removeFromSuperview];
}


-(IBAction)dateofBirthButtonClicked:(id)sender
{
    [confirmationTF resignFirstResponder];
    [self.view addSubview:dateView];
    
}

-(IBAction)setButtonClicked:(id)sender
{
    
    dateofBirth=[datepicker date];

    
        dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
   


//    NSLog(@"date of birth: %@ and :%d",[dateFormatter stringFromDate:[datepicker date]],dataofbirthString.length);
    
    
    [dateButton setTitle:[dateFormatter stringFromDate:dateofBirth] forState:UIControlStateNormal];
    [dateButton setFrame:CGRectMake(dateButton.frame.origin.x-2, dateButton.frame.origin.y+12
                                    , dateButton.frame.size.width, dateButton.frame.size.height)];
    [dateButton setFont:[UIFont systemFontOfSize:18]];
    [dateView removeFromSuperview];
}


-(IBAction)cancelButtonClicked:(id)sender
{
    [dateView removeFromSuperview];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    

    
    if (code==200)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Registration" message:@"Registration sucessfully completed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        
        
        
        [alert show];
    }
    
    else {

        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Registration" message:@"Looks like your email id is in use with NowFloats" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
    }
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    

    NSString* newStr = [[[NSString alloc] initWithData:receivedData
                                              encoding:NSUTF8StringEncoding] autorelease];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.view removeFromSuperview];
}


-(IBAction)registrationButtonClicked:(id)sender
{
    
    dic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setValue:emailTF.text forKey:@"EmailAddress"];
    [dic setValue:[NSNumber  numberWithBool:isMale]  forKey:@"IsMale"];
    [dic setValue:[NSNumber  numberWithInt:selectedAvatarId-1] forKey:@"AvatarImageId"];
    
    NSLog(@"AvatarID:%@",[dic objectForKey:@"AvatarImageId"]);
    
    [dic setValue:displayNameTF.text forKey:@"OwnerTag"];
    
    if ([dateFormatter stringFromDate:dateofBirth]==NULL)
    {
        [dic setValue:@"" forKey:@"DOB"];
    }
    
    else
    {
        
        [dic setValue:[dateFormatter stringFromDate:dateofBirth] forKey:@"DOB"];
        
    }
    
    
    [dic setValue:userNameTF.text forKey:@"FullName"];
    [dic setValue:[passwordTF text] forKey:@"Password"];
    [dic  setValue:[NSNumber numberWithBool:0] forKey:@"IsPrivilleged"];
    [dic  setValue:@"" forKey:@"fbAccessId"];
    [dic  setValue:@"" forKey:@"fbId"];

    
    
    if ([[dic objectForKey:@"AvatarImageId"] intValue]==-1)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Please select Avatar Image" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
    }
    

    
    if ([[dic objectForKey:@"AvatarImageId"] intValue]!=-1 )
    {
                
        NSString *newurlString=[dic JSONRepresentation];
        
        NSString *url=@"https://api.withfloats.com/Discover/v1/float/user/create";
        NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
        
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        
        NSURLConnection *theConnection;
        theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
    }
    
    
}


-(void)checkAllFields;
{
    
    if ([userNameTF.text isEqual:@""] )
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Fullname cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
    }

    
   
    if ([displayNameTF.text isEqual:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Display name cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        [alert show];


    }
    
    if ([emailTF.text isEqual:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Email ID cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    
    }
    
    if (emailTF.text)
    {
        if (![self validEmail:emailTF.text])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Enter Valid Email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            
            
        }
    }
    
    if([passwordTF.text isEqualToString:@""] )
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Password cannot be empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    
    if (![passwordTF.text isEqualToString: confirmationTF.text] )
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Password should match Confirm Password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
        
    }
    
    if ([[dic objectForKey:@"AvatarImageId"] intValue]==-1)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Please select AvatarImage" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];

    }
    

}


-(void)checkPassword;
{

   
}


-(void)checkEmail
{

    
    if (emailTF.text)
        
    {
        if (![self validEmail:emailTF.text])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Enter Valid Email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            

        }
    }

}


-(BOOL) validEmail:(NSString*) emailString
{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];

    if (regExMatches == 0) {
        return NO;
    } else
        return YES;


}
@end
