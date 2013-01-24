//
//  LoginViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "MarqueeLabel.h"



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginView,logoutView,profileName,avatarLabel,profilePic;

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
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    FromLogin=1;
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    maleImageNames=[[NSMutableArray alloc] initWithObjects:@"BIG BHANU",@"CHE THE MAN",@"MASTER T",@"METROMAN",@"NINJA X",@"ORAN-DJINN",@"PBR SINGH", nil];
    femaleImageNames=[[NSMutableArray alloc] initWithObjects:@"HARAJUKU",@"BONY'S M",@"MISS X",@"NENE BERRY",@"NINJA Y",@"ORANJINA",@"USHA OOH", nil];

    //AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    userdetails=[NSUserDefaults standardUserDefaults];
    [super viewDidLoad];
   
    [loginButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
    [changeAvatarButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
    if ([userdetails objectForKey:@"DisplayTag"]) {
        
        int avatarId;
        
        avatarId=[[userdetails  objectForKey:@"AvatarImageId"] intValue];
        if (avatarId > 6)
            avatarId = avatarId % 7;
        else if (avatarId < 0) {
            avatarId = 0;
        }
        int isMale;
        isMale=[[userdetails objectForKey:@"IsMale"] intValue];
        if (isMale) {
            [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
        } else {
            [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
        }
        [self.view addSubview:logoutView];
        [profileName setText:[userdetails objectForKey:@"DisplayTag"]];
        [avatarLabel setText:[userdetails objectForKey:@"DisplayTag"]];
    }
   
     else
     {
        [ self.view addSubview:loginView];
     }
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)backButtonClicked:(id)sender
{
    [self.view removeFromSuperview];
}
-(IBAction)forgotPasswordButtonClicked:(id)sender{
    
    forgotpasswordViewCon=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [forgotpasswordViewCon setLoginViewCon:self];
    [self.view addSubview:forgotpasswordViewCon.view];
}
-(IBAction)registrationButtonClicked:(id)sender{
    
    registerViewCon=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [registerViewCon setLoginViewCon:self];
    [self.view addSubview:registerViewCon.view];
}
-(IBAction)changeAvatarButtonClicked:(id)sender
{
    FromLogin=2;
    [changeAvatarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
    if ([userdetails objectForKey:@"DisplayTag"])
    {
        
        [avatarHolderName setText:[userdetails objectForKey:@"DisplayTag"]];
        int avatarId;
        
        avatarId=[[userdetails  objectForKey:@"AvatarImageId"] intValue];
        if (avatarId > 6)
            avatarId = avatarId % 7;
        else if (avatarId < 0) {
            avatarId = 0;
        }
        int isMale;
        isMale=[[userdetails objectForKey:@"IsMale"] intValue];
        if (isMale) {
            int k;
            k=0;
            for (int i1=0; i1<7; i1++) {
                if (i1==avatarId) {
                    [avatarImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
                    
                }
                else {
                    if (k==0) {
                        [avatarView2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView2 setTag:i1];
                        [avatarLabel2 setText:[maleImageNames objectAtIndex:i1]];
                        //NSLog(@"avataar label 2:%@",avatarLabel2);
                        //[avatarView2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    else if (k==1) {
                        [avatarView3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView3 setTag:i1];
                        [avatarLabel3 setText:[maleImageNames objectAtIndex:i1]];
                       // NSLog(@"avataar label 3:%@",avatarLabel3);

                        // [avatarView3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    else if (k==2) {
                        [avatarView4 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView4 setTag:i1];
                        [avatarLabel4 setText:[maleImageNames objectAtIndex:i1]];
                       // NSLog(@"avataar label 4:%@",avatarLabel4);

                        //[avatarView4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==3) {
                        [avatarView5 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView5 setTag:i1];
                        [avatarLabel5 setText:[maleImageNames objectAtIndex:i1]];
                       // NSLog(@"avataar label 5:%@",avatarLabel5);

                        //[avatarView5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==4) {
                        [avatarView6 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView6 setTag:i1];
                        [avatarLabel6 setText:[maleImageNames objectAtIndex:i1]];
                        //NSLog(@"avataar label 6:%@",avatarLabel6);

                        //  [avatarView6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==5) {
                        
                        [avatarView7 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView7 setTag:i1];
                        [avatarLabel7 setText:[maleImageNames objectAtIndex:i1]];
                        //NSLog(@"avataar label 7:%@",avatarLabel7);

                        //[avatarView7 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    
                }
            }
        }
        else {
            int k;
            k=0;
            for (int i1=0; i1<7; i1++) {
                if (i1==avatarId) {
                    [avatarImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
                    
                }
                else {
                    if (k==0) {
                        [avatarView2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView2 setTag:i1];
                        //[avatarView2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    else if (k==1) {
                        [avatarView3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView3 setTag:i1];
                        
                        // [avatarView3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    else if (k==2) {
                        [avatarView4 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView4 setTag:i1];
                        //[avatarView4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==3) {
                        [avatarView5 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView5 setTag:i1];
                        
                        //[avatarView5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==4) {
                        [avatarView6 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView6 setTag:i1];
                        
                        //  [avatarView6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    else if (k==5) {
                        
                        [avatarView7 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",i1]] forState:UIControlStateNormal];
                        [avatarView7 setTag:i1];
                        
                        //[avatarView7 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",i1]]];
                        k++;
                    }
                    
                    
                }
            }
        }
        
//}
        
    [loginView removeFromSuperview];
    [loginButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
    [changeAvatarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:changeAvatarView];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Login" message:@"Please Login" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}
-(IBAction)loginButtonClicked:(id)sender
{
    FromLogin=1;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeAvatarButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
    if ([userdetails objectForKey:@"DisplayTag"]) {
        
        [profileName setText:[userdetails objectForKey:@"DisplayTag"]];
        [avatarLabel setText:[userdetails objectForKey:@"DisplayTag"]];
        
        int avatarId;
        
        avatarId=[[userdetails  objectForKey:@"AvatarImageId"] intValue];
        if (avatarId > 6)
            avatarId = avatarId % 7;
        else if (avatarId < 0) {
            avatarId = 0;
        }
        int isMale;
        isMale=[[userdetails objectForKey:@"IsMale"] intValue];
        if (isMale) {
            [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
        } else {
            [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
        }
        [self.view addSubview:logoutView];
        
        //[self getThoughTextFloatData:appDelegate.thoughsTextFloats];
        //[self getThoughtsImageData:appDelegate.thoughsImageFloats];
    }
    else {
        [changeAvatarButton setTitleColor:[UIColor colorWithRed:255/250.0f green:197/250.0f blue:5/250.0f alpha:1] forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeAvatarView removeFromSuperview];
        [self.view addSubview:loginView];
    }
    
}

-(IBAction)avatarButtonClicked:(id)sender
{
   // NSLog(@"tag:%d",avatarView2.tag);
    
    int avatarId;
    avatarId=[[userdetails  objectForKey:@"AvatarImageId"] intValue];
   // NSLog(@"avatar id:%d",avatarId);
    if (avatarId > 6)
        avatarId = avatarId % 7;
    else if (avatarId < 0) {
        avatarId = 0;
    }
    

    UIButton *btn = sender;

    float x=btn.frame.origin.x;
    float y=btn.frame.origin.y;
    if ([[userdetails objectForKey:@"IsMale"] intValue]) {
        if (x==30 && y==133) {
            [avatarLabel2 setText:[maleImageNames objectAtIndex:avatarId]];
        }
        else if (x==126 && y==133) {
            [avatarLabel3 setText:[maleImageNames objectAtIndex:avatarId]];
        }
        else if (x==224  && y==132) {
            [avatarLabel4 setText:[maleImageNames objectAtIndex:avatarId]];
        }
        else if (x==30 && y==256) {
            [avatarLabel5 setText:[maleImageNames objectAtIndex:avatarId]];
        }
        else if (x==127 && y==256) {
            [avatarLabel6 setText:[maleImageNames objectAtIndex:avatarId]];
        }
        else if (x==225 && y==256) {
            [avatarLabel7 setText:[maleImageNames objectAtIndex:avatarId]];
        }
    }
    else {
        if (x==30 && y==133) {
            [avatarLabel2 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
        else if (x==126 && y==133) {
            [avatarLabel3 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
        else if (x==224 && y==132) {
            [avatarLabel4 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
        else if (x==30 && y==256) {
            [avatarLabel5 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
        else if (x==127 && y==256) {
            [avatarLabel6 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
        else if (x==225 && y==256) {
            [avatarLabel7 setText:[femaleImageNames objectAtIndex:avatarId]];
        }
    }
    
    
    [userdetails setObject:[NSNumber numberWithInt:btn.tag] forKey:@"AvatarImageId"];


    [btn setTag:avatarId];
    UIImage *img = [btn currentBackgroundImage];
    [btn setBackgroundImage:[avatarImageView image] forState:UIControlStateNormal];
    [avatarImageView setImage:img];
    
    [userdetails synchronize];
    
    NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/float/user/update?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A"];
     NSString *urlTo=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:[NSNumber numberWithInt:[[userdetails objectForKey:@"AvatarImageId"] intValue]] forKey:@"AvatarImageId"];
  
    [dic setObject:newurlString forKey:@"_id"];
    NSString *jsonRequest=[dic JSONRepresentation];
    
    NSData *postData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlTo] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *theConnection;
    theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

-(IBAction)goToHomePage:(id)sender{
    
    [self.view removeFromSuperview];
}

-(IBAction)loginUserDetails:(id)sender{
    
    
    BOOL IsUserName;
    BOOL IsPassword;
    
    if ([UserNameTextField.text length]>3 && [UserNameTextField .text length]<20) {
        IsUserName=YES;
        if ([passwordTextField.text length]>4) {
            IsPassword=YES;
        }
        else {
            IsPassword=NO;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"PassWord" message:@"Please Enter Valid Password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        IsUserName=NO;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"UserName" message:@"Please Enter Valid User Name" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
    
   
    if (IsUserName && IsPassword) {
       // NSUserDefaults *userDetails=[NSUserDefaults standardUserDefaults];
        receivedData=[[NSMutableData alloc] initWithCapacity:1];
       // NSString *passWord=@"\"tedhh\"";
        NSString *passWord=[NSString stringWithFormat:@"\"%@\"",passwordTextField.text];
        
        NSString *post = [[NSString alloc] initWithFormat:@"%@",passWord];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];  
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
        
        NSString *UserNameString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/login/%@",UserNameTextField.text];
        
        
        NSURL *url = [NSURL URLWithString:UserNameString];
                
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        [theRequest setHTTPMethod:@"POST"];  
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];  
        [theRequest setHTTPBody:postData];
        NSURLConnection *conn;
        conn= [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
    if (FromLogin==1) {
        if (code==200)
        {
            
            
        }
        else {
            NSString *res=[response description];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Login" message:res delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UserNameTextField setText:@""];
    [passwordTextField setText:@""];

    if (FromLogin==1)
    {
        
        NSString* newStr = [[[NSString alloc] initWithData:receivedData
                                                  encoding:NSUTF8StringEncoding] autorelease];
        
        if ([newStr length]) {
            NSMutableDictionary *dic=[newStr JSONValue];
            [userdetails setInteger:[[dic objectForKey:@"AvatarId"] intValue] forKey:@"AvatarId"];
            [userdetails setObject:[dic objectForKey:@"DisplayTag"]  forKey:@"DisplayTag"];
            if ([dic objectForKey:@"ImageUri"]==(id)[NSNull null]) {
                [userdetails setObject:@""  forKey:@"ImageUri"];
            }
            else {
                [userdetails setObject:[dic objectForKey:@"ImageUri"]  forKey:@"ImageUri"];
            }
            
            [userdetails setInteger:[[dic objectForKey:@"IsMale"] intValue] forKey:@"IsMale"];
            [userdetails setInteger:[[dic objectForKey:@"IsPrivilleged"] intValue] forKey:@"IsPrivilleged"];
            [userdetails setObject:[dic objectForKey:@"_id"]  forKey:@"_id"];
            if ([dic objectForKey:@"reponseCode"]== (id)[NSNull null]) {
                [userdetails setObject:@""  forKey:@"reponseCode"];
            }
            else{
                [userdetails setObject:[dic objectForKey:@"reponseCode"]  forKey:@"reponseCode"];
            }
            [userdetails synchronize];
            [loginView removeFromSuperview];
            [self.view addSubview:logoutView];
            [profileName setText:[userdetails objectForKey:@"DisplayTag"]];
            [avatarLabel setText:[userdetails objectForKey:@"DisplayTag"]];
            int avatarId;
            
            avatarId=[[userdetails  objectForKey:@"AvatarImageId"] intValue];
            if (avatarId > 6)
                avatarId = avatarId % 7;
            else if (avatarId < 0) {
                avatarId = 0;
            }
            int isMale;
            isMale=[[userdetails objectForKey:@"IsMale"] intValue];
            if (isMale) {
                [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
            } else {
                [profilePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
            }
            [self getThoughTextFloatData];
            [self getThoughtsImageData];
        
        }
        else {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Login" message:@"Enter Valid User Name or Password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
  
    
   
}



-(IBAction)logoutButtonClicked:(id)sender{
    [userdetails removeObjectForKey:@"AvatarId"];
    [userdetails removeObjectForKey:@"DisplayTag"];
    [userdetails removeObjectForKey:@"ImageUri"];
    [userdetails removeObjectForKey:@"IsMale"];
    [userdetails removeObjectForKey:@"IsPrivilleged"];
    [userdetails removeObjectForKey:@"_id"];
    [userdetails removeObjectForKey:@"reponseCode"];
    [userdetails synchronize];
    [logoutView removeFromSuperview];
    [self.view addSubview:loginView];
}

-(void)getThoughTextFloatData//:(NSMutableArray *)dataarray
{
//NSLog(@"Before thoughts : %@",appDelegate.thoughsTextFloats);    
    for (NSDictionary *dic in appDelegate.thoughsTextFloats)
    {
        
        
        
        if ([[dic objectForKey:@"AirCount"] intValue]) {
            BOOL isAired;
            isAired=NO;
            for (int i=0; i<[[dic objectForKey:@"AirUserIds"] count]; i++) {
                
                //NSLog(@"air id: %@",[[dic objectForKey:@"AirUserIds"] objectAtIndex:i]);
                if ([[[dic objectForKey:@"AirUserIds"] objectAtIndex:i] isEqualToString:[userdetails stringForKey:@"_id"]]) {
                    
                    isAired=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isAired] forKey:@"isAired"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isAired"];
        }
        if ([[dic objectForKey:@"SinkCount"] intValue]) {
            BOOL isSinked;
            isSinked=NO;
            
            for (int i=0; i<[[dic objectForKey:@"SinkUserIds"] count]; i++) {
                //NSLog(@"sink id: %@",[[dic objectForKey:@"AirUserIds"] objectAtIndex:i]);

                if ([[[dic objectForKey:@"SinkUserIds"] objectAtIndex:i] isEqualToString:[userdetails stringForKey:@"_id"]]) {
                    isSinked=YES;
                    break;
                }
            }

            
            [dic setValue:[NSNumber numberWithBool:isSinked] forKey:@"isSinked"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isSinked"];
        }
    }
    
   // NSLog(@"After thoughts : %@",appDelegate.thoughsTextFloats);
}

-(void)getThoughtsImageData//:(NSMutableArray *)dataarray
{
    
    
    
    
    for (NSDictionary *dic in appDelegate.thoughsImageFloats)
    {
        
        
        
        if ([[dic objectForKey:@"AirCount"] intValue]) {
            BOOL isAired;
            isAired=NO;
            
            for (int i=0; i<[[dic objectForKey:@"AirUserIds"] count]; i++) {
                
                if ([[[dic objectForKey:@"AirUserIds"] objectAtIndex:i] isEqualToString:[userdetails stringForKey:@"_id"]]) {
                    isAired=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isAired] forKey:@"isAired"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isAired"];
        }
        if ([[dic objectForKey:@"SinkCount"] intValue]) {
            BOOL isSinked;
            isSinked=NO;
            
            for (int i=0; i<[[dic objectForKey:@"SinkUserIds"] count]; i++) {
                
                if ([[[dic objectForKey:@"SinkUserIds"] objectAtIndex:i] isEqualToString:[userdetails stringForKey:@"_id"]]) {
                    isSinked=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isSinked] forKey:@"isSinked"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isSinked"];
        }
    }
}
@end
