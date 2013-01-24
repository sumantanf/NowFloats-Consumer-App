//
//  DetailImageGridViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailImageGridViewController.h"
#import "ImageGridViewController.h"
//#import "DetailImageFloatsViewController.h"
@interface DetailImageGridViewController ()

@end

@implementation DetailImageGridViewController
@synthesize imageGrid;
@synthesize selectedAvatar,ownerandText;
@synthesize v;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)AirButtonClicked:(id)sender
{   
    
    air=1;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
        if ([[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]==0 && [[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isSinked"] boolValue]==0) {
            [[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithBool:YES] forKey:@"isAired"];
            airVal++;
            [[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithInt:airVal] forKey:@"AirCount"];
            
            [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
            
            NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/air/image/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"_id"]];
            
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
            [sinkButton setAlpha:0.1f];
            [expandButton setAlpha:0.1f];
            
            [airNumLabel setHidden:YES];
            NSTimer *timer;
            timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addAirImage:) userInfo:nil repeats:YES];
        }
        else {
            //NSLog(@"Already Aired / sinked");
            if([[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"UH-OH"
                                      message: @"Really like a picture? Grab it. But you can’t air it twice."
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];

            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"UH-OH"
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
        
        [airedview setFrame:CGRectMake(17, 365, 287, 37)];
        [airedLabelView setText:@"Please Login"];
        [imageGrid.view addSubview:airedview];      
        [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
    }
    
    
}
-(void)removeairedView{
    [airedview removeFromSuperview];
    //[imageGrid.airBackgroundView setFrame:CGRectMake(-300, 368, 284, 37)];
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
        [expandButton setAlpha:0.6f];
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
        [expandButton setAlpha:0.6f];
        sinkingVal=0;
        [timer invalidate];
        
        
    }
}
-(IBAction)SinkButtonClicked:(id)sender
{
    sink=1;
    
     if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
    
    if ([[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]==0 && [[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isSinked"] boolValue]==0) {
        [[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithBool:YES] forKey:@"isSinked"];
        airVal++;
        [[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithInt:sinkVal] forKey:@"SinkCount"];
        
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkVal]];
        
        NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/sink/image/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"_id"]];
        
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
        
        [airButton setAlpha:0.1f];
        [sinkButton setAlpha:0.9f];
        [expandButton setAlpha:0.1f];
        
        [sinkNumLabel setHidden:YES];
        NSTimer *timer;
        timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addSinkImage:) userInfo:nil repeats:YES];
    }
    else
    {
        if([[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"UH-OH"
                                  message: @"Really like a picture? Grab it. But you can’t air it twice."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"UH-OH"
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
         
         [airedview setFrame:CGRectMake(17, 365, 287, 37)];
         [airedLabelView setText:@"Please Login"];
         [imageGrid.view addSubview:airedview];      
         [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
     }
    
}

-(void)animateImages
{
    i = 0;
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationImages:) userInfo:nil repeats:YES];
}

-(IBAction)animationImages:(id)sender
{
    ++i;
    if(i == 1)
    {
        [img1 setHidden:NO];
        [img1 setAlpha:1.0];
    }
    else if(i == 2)
    {
        [img2 setHidden:NO];
        [img2 setAlpha:0.75];
    }
    else if(i == 3)
    {
        [img3 setHidden:NO];
        [img3 setAlpha:0.50];
    }
    else if(i == 4)
    {
        [img4 setHidden:NO];
        [img4 setAlpha:0.35];
        if(stoporNot1)
        {
            stoporNot2 = YES;
        }
    }
    else if(i == 5)
    {
        i = 0;
        stoporNot1 = YES;
        [img1 setHidden:YES];
        [img2 setHidden:YES];
        [img3 setHidden:YES];
        [img4 setHidden:YES];
    }
    if(i == 1 && stoporNot2 && stoporNot1)
    {
        [timer1 invalidate];
        [img1 setHidden:YES];
        [img2 setHidden:YES];
        [img3 setHidden:YES];
        [img4 setHidden:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    timerVal=0;
    
    
    sinkingVal=[[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"SinkCount"] intValue];
    airVal=[[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"AirCount"] intValue];
    
    if(sinkVal<10)
    {
        [sinkNumLabel setText:[NSString stringWithFormat:@"0%d",sinkVal]];
    }
    else
    {
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkVal]];
    }
    
    if(airVal<10)
    {
        [airNumLabel setText:[NSString stringWithFormat:@"0%d",airVal]];
    }
    else
    {
        [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
    }
    
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    
    [self animateImages];
    
    
    
    color = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    //NSLog(@"code is : %d",code);
    if (code==200) {
        
        if(air==1){
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"PICTURE PERFECT"
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
-(IBAction)ExpandButtonClicked:(id)sender{
//    NSLog(@"Selected Button is: %@",[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar]);
//    DetailImageFloatsViewController *detail=[[DetailImageFloatsViewController alloc] initWithNibName:@"DetailImageFloatsViewController" bundle:nil];
//    [detail setDic:[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar]];
//    [self.view addSubview:detail.view];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
   
    
    detailViewCon=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [detailViewCon setSelectedAvatar:selectedAvatar];
    [detailViewCon setDic:[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar]];
    for (int i1=0; i1<[appDelegate.thoughtsOwnerDetails count]; i1++) 
    {
        if ([[[appDelegate.thoughtsOwnerDetails objectAtIndex:i1] objectForKey:@"_id"] isEqualToString:[[appDelegate.thoughsImageFloats objectAtIndex:selectedAvatar] objectForKey:@"OwnerId"]]) {
            [detailViewCon setOwnerDic:[appDelegate.thoughtsOwnerDetails objectAtIndex:i1]];
            break;
        }
    }
    
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] addSubview:detailViewCon.view];
}
@end
