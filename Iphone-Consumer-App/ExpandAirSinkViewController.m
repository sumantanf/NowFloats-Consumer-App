//
//  ExpandAirSinkViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandAirSinkViewController.h"

@interface ExpandAirSinkViewController ()

@end

@implementation ExpandAirSinkViewController
@synthesize dic;
@synthesize selectedVal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view removeFromSuperview];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    sinkVal=[[dic objectForKey:@"SinkCount"] intValue];
    airVal=[[dic objectForKey:@"AirCount"] intValue];
    [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
    [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkVal]];
   
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
-(IBAction)AirButtonClicked:(id)sender
{

    air=1;
    
    if (selectedVal==1) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
            if ([[dic objectForKey:@"isAired"] boolValue]==0 && [[dic objectForKey:@"isSinked"] boolValue]==0) {
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isAired"];
                airVal++;
                [dic setValue:[NSNumber numberWithInt:airVal] forKey:@"AirCount"];
                
                [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
                
                NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/air/text/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[dic objectForKey:@"_id"]];
                
                NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
                NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
                
                [request setHTTPMethod:@"PUT"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSURLConnection *theConnection;
                theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
                [airButton setAlpha:0.9f];
                [sinkButton setAlpha:0.2f];
                
                
                [airNumLabel setHidden:YES];
                NSTimer *timer;
                timer=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(addAirImage:) userInfo:nil repeats:YES];
            }
            else {
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"We appreciate your enthusiasm, but you already aired this thought."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"You really don’t like this thought? But you already sank this thought once."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];

                }
               
            }
        }
        
        else {
            [airedLabelView setText:@"Please Login"];
            [airedview setFrame:CGRectMake(25, 368, 284, 37)];
            [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
        }
    }
    else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
            if ([[dic objectForKey:@"isAired"] boolValue]==0 && [[dic objectForKey:@"isSinked"] boolValue]==0) {
                //[dic setValue:[NSNumber numberWithBool:YES] forKey:@"isAired"];
                airVal++;
                //[dic setValue:[NSNumber numberWithInt:airVal] forKey:@"AirCount"];
                
                [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
                
                NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/air/image/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[dic objectForKey:@"_id"]];
                
                NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
                NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
                
                [request setHTTPMethod:@"PUT"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSURLConnection *theConnection;
                theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
                [airButton setAlpha:0.9f];
                [sinkButton setAlpha:0.2f];
                
                
                [airNumLabel setHidden:YES];
                NSTimer *timer;
                timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addAirImage:) userInfo:nil repeats:YES];
            }
            else {
                //NSLog(@"Already Aired / sinked");
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"We appreciate your enthusiasm, but you already aired this thought."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"You really don’t like this thought? But you already sank this thought once."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
               
            }
        }
        
        else {
            [airedLabelView setText:@"Please Login"];
            [airedview setFrame:CGRectMake(25, 368, 284, 37)];
            [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
        }
    }
   
    
    
}
-(void)removeairedView{
    [airedview setFrame:CGRectMake(-300, 368, 284, 37)];
}
-(void)addAirImage:(NSTimer *)timer{
    if (timerVal<5) {

        
        if (timerVal%2==0) {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            [airBackGroundImage setImage:nil];
            [UIView commitAnimations];
        }
        else {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            [airBackGroundImage setImage:[UIImage imageNamed:@"Up Arrow_1.png"]];
            [UIView commitAnimations];
        }
        
        
        /*[UIView beginAnimations:nil context:nil];
         [UIView setAnimationDuration:0.1];
         [airBackGroundImage setImage:nil];
         [UIView commitAnimations];*/
        
        
        timerVal++;
    }
    else {
        
        [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
        [airNumLabel setHidden:NO];
        [airButton setAlpha:0.6f];
        [sinkButton setAlpha:0.6f];
       
        timerVal=0;
        [timer invalidate];
        
        
    }
    
}
- (void)blinkAnimation:(NSString *)animationID finished:(BOOL)finished target:(UIView *)target
{
        NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
        float speedFloat = (1.00 - [selectedSpeed floatValue]);
        
        [UIView beginAnimations:animationID context:target];
        [UIView setAnimationDuration:speedFloat];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
        
        if([target alpha] == 1.0f)
            [target setAlpha:0.0f];
        else
            [target setAlpha:1.0f];
        [UIView commitAnimations];
        
    
}
-(void)addSinkImage:(NSTimer *)timer{
    
    if (sinkVal<5) {
        

        if (sinkVal%2==0) {
            [ UIView beginAnimations:@"fadeIn" context:nil];
            [UIView setAnimationDuration:0.1];
            [sinkBackGroundImage setImage:nil];
            [UIView commitAnimations];
        }
        else {
            [ UIView beginAnimations:@"fadeout" context:nil];
            [UIView setAnimationDuration:0.1];
            [sinkBackGroundImage setImage:[UIImage imageNamed:@"Down Arrow_1.png"]];
            [UIView commitAnimations];
        }
        
        
        
        
        sinkVal++;
    }
    else {
        
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
        [sinkNumLabel setHidden:NO];
        [airButton setAlpha:0.6f];
        [sinkButton setAlpha:0.6f];
        
        sinkVal=0;
        [timer invalidate];
        
        
    }
}
-(IBAction)SinkButtonClicked:(id)sender
{
    sink=1;
    
    if (selectedVal==1) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
            
            if ([[dic objectForKey:@"isAired"] boolValue]==0 && [[dic objectForKey:@"isSinked"] boolValue]==0) {
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isSinked"];
                sinkingVal++;
                [dic setValue:[NSNumber numberWithInt:sinkingVal] forKey:@"SinkCount"];
                
                [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
                
                NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/sink/text/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[dic objectForKey:@"_id"]];
                
                NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
                NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
                
                [request setHTTPMethod:@"PUT"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSURLConnection *theConnection;
                theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
                
                [airButton setAlpha:0.2f];
                [sinkButton setAlpha:0.9f];
                
                
                [sinkNumLabel setHidden:YES];
                NSTimer *timer;
                timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addSinkImage:) userInfo:nil repeats:YES];
            }
            else {
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"We appreciate your enthusiasm, but you already aired this thought."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"You really don’t like this thought? But you already sank this thought once."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }

            }
        }
        else {
            [airedLabelView setText:@"Please Login"];
            [airedview setFrame:CGRectMake(25, 368, 284, 37)];
            [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
        }
    }
    else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
            
            if ([[dic objectForKey:@"isAired"] boolValue]==0 && [[dic objectForKey:@"isSinked"] boolValue]==0) {
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isSinked"];
                sinkVal++;
                [dic setValue:[NSNumber numberWithInt:sinkingVal] forKey:@"SinkCount"];
                
                [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
                
                NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/sink/image/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[dic objectForKey:@"_id"]];
                
                NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
                NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
                
                [request setHTTPMethod:@"PUT"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                NSURLConnection *theConnection;
                theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
                
                [airButton setAlpha:0.2f];
                [sinkButton setAlpha:0.9f];
                
                
                [sinkNumLabel setHidden:YES];
                NSTimer *timer;
                timer=[NSTimer scheduledTimerWithTimeInterval:0.3  target:self selector:@selector(addSinkImage:) userInfo:nil repeats:YES];
            }
            else {
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"We appreciate your enthusiasm, but you already aired this thought."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-oh!"
                                          message: @"You really don’t like this thought? But you already sank this thought once."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                
            }
        }
        else {
            [airedLabelView setText:@"Please Login"];
            [airedview setFrame:CGRectMake(25, 368, 284, 37)];
            [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    if (code==200) {
        
        if(air==1){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"It's Done"
                              message: @"You aired the thought. It’s gonna float a bit longer now."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        }
        
        
        else if(sink==1){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"It's Done"
                                  message: @"You sank the thought. It’s gonna float a little less longer."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Ooops"
                              message: @"U have to one more time" 
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
       
    }
}
@end
