//
//  ImageAirsinkVC.m
//  NowFloatsv1
//
//  Created by pravasis on 05/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageAirsinkVC.h"

@interface ImageAirsinkVC ()

@end

@implementation ImageAirsinkVC

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
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Really like a picture? Grab it. But you can’t air it twice."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];

                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Don’t like this picture? Slide to the next one. But you can’t sink it twice."
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
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Really like a picture? Grab it. But you can’t air it twice."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];

                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Don’t like this picture? Slide to the next one. But you can’t sink it twice."
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
-(void)addSinkImage:(NSTimer *)timer{
    
    if (sinkingVal<5) {
        
        if (sinkingVal%2==0) {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            [sinkBackGroundImage setImage:nil];
            [UIView commitAnimations];
        }
        else {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            [sinkBackGroundImage setImage:[UIImage imageNamed:@"Down Arrow_1.png"]];
            [UIView commitAnimations];
        }
        
        
        
        
        sinkingVal++;
    }
    else {
        
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
        [sinkNumLabel setHidden:NO];
        [airButton setAlpha:0.6f];
        [sinkButton setAlpha:0.6f];
        
        sinkingVal=0;
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
                sinkVal++;
                [dic setValue:[NSNumber numberWithInt:sinkingVal] forKey:@"SinkCount"];
                
                [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkVal]];
                
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
            }
            else {
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Really like a picture? Grab it. But you can’t air it twice."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Don’t like this picture? Slide to the next one. But you can’t sink it twice."
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
                
                [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkVal]];
                
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
            }
            else {
                if([[dic objectForKey:@"isAired"] boolValue]){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Really like a picture? Grab it. But you can’t air it twice."
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Uh-Oh!"
                                          message: @"Don’t like this picture? Slide to the next one. But you can’t sink it twice."
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
                                  initWithTitle: @"Picture Perfect"
                                  message: @"You aired this image. It’ll stay up longer."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
        else if(sink==1){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"TAKE IT DOWN"
                                  message: @"You sank this image. It’ll come down quicker."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Oops!!!"
                              message: @"U have to one more time" 
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
}
@end

