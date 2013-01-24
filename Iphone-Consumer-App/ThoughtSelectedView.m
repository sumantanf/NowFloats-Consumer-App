//
//  ThoughtSelectedView.m
//  NowFloats_v1
//
//  Created by pravasis on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThoughtSelectedView.h"
#import "MarqueeLabel.h"
@implementation ThoughtSelectedView

@synthesize messageImageView;
@synthesize m_thoughtController;
@synthesize displayImageView;
@synthesize ownerDetails;

@synthesize selectedAvatar,ownerandText,thoughtsRef;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)ExpandButtonClicked:(id)sender
{
   
    [appDelegate arrangeBottomButtons:bottomBar];
    expandedView = [[ThoughtsExpandedView alloc] initWithNibName:@"ThoughtsExpandedView" bundle:nil];
    [expandedView setOwnerDetails:ownerDetails];
    [expandedView setSelectedAvatar:1];
  
    [expandedView setSelectedView:self];
    [expandedView setM_thoughtController:m_thoughtController];
    NSMutableArray *textFloats=[[NSMutableArray alloc] initWithCapacity:1];
    int Num;
    Num=0;
    
    for (int i1=selectedAvatar; i1<[thoughtsRef count]; i1++)
    {
        
        if (Num==8) {
            Num=0;
            break;
        }
        else {
            
            
            NSString *nameString;
            
            for (int i2=0; i2<[appDelegate.thoughtsOwnerDetails count]; i2++)
            {
                
                if ([[[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"_id"] isEqualToString:[[thoughtsRef objectAtIndex:i1] objectForKey:@"OwnerId"]]) {
                    
                    NSString *personString = [[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"OwnerTag"];
                    
                    nameString=[NSString stringWithFormat:@"%@  |",personString];
                    
                                       
                  
                    
                    NSDate *startdate ;
                    NSString *dateString=[[thoughtsRef objectAtIndex:i1] objectForKey:@"CreatedOn"];
                    
                    
                    startdate=[self  getDateFromJSON:dateString];
                    
                    NSDate *toDate = [NSDate date];
                    int k = [startdate timeIntervalSince1970];
                    int j = [toDate timeIntervalSince1970];
                    
                    double X = j-k;
                    
                    int days = (int)((double)X/(3600*24.0));
                    int hrs = (int)X%(3600*24);
                    int hrstemp =  hrs/3600;
                    
                    
                    
                    if(days > 0)
                    {
                        // [timeLabel setText:[NSString stringWithFormat:@"%d days ago",days]];
                        if (days==1) {
                            nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d day ago",days]];
                        }
                        else{
                            nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d days ago",days]];
                            
                        }
                        
                        
                    }
                    else
                    {
                        nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
                        
                        // [timeLabel setText:[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
                    }
                    
                    nameString=[NSString stringWithFormat:@"%@  %@",nameString,[[thoughtsRef objectAtIndex:i1] objectForKey:@"NearByLocationName"]];
                    
                    [[thoughtsRef objectAtIndex:i1] setObject:nameString forKey:@"namestring"];
                    break;
                }
                
                
            }

            
            [textFloats addObject:[thoughtsRef objectAtIndex:i1]];
            Num++;
        }
    }
    [expandedView setTextFloats:textFloats];
    [textFloats release];
    
    int second;
    second=0;
    NSMutableArray *owner=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i1=selectedAvatar; i1<[thoughtsRef count]; i1++) {
        
        if (second==8)
        {
            second=0;
            break;
        }
        else {
            
            for (int i2=0; i2<[appDelegate.thoughtsOwnerDetails count]; i2++) {
                if ([[[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"_id"] isEqualToString:[[thoughtsRef objectAtIndex:i1] objectForKey:@"OwnerId"]]) {
                    [owner addObject:[appDelegate.thoughtsOwnerDetails objectAtIndex:i2]];
                }
            }
            
            
            second++;
        }
    }
    [expandedView setOwnerandText:owner];
    
        [appDelegate.viewsArray addObject:expandedView.view];
    [self.view setFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:expandedView.view];    
    
}

-(IBAction)AirButtonClicked:(id)sender
{
    air=1;
    selectedVal=1;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
        if ([[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]==0 && [[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isSinked"] boolValue]==0) {
            [[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithBool:YES] forKey:@"isAired"];
            airVal++;
            [[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithInt:airVal] forKey:@"AirCount"];
            
            [airNumLabel setText:[NSString stringWithFormat:@"%d",airVal]];
            
            NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/air/text/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"_id"]];
            
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
            timer=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(addAirImage:) userInfo:nil repeats:YES];
        }
        else {
            //NSLog(@"Already Aired / sinked");
            if([[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]){
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
        [airedview setFrame:CGRectMake(18, 353, 284, 37)];
        [self.view bringSubviewToFront:airedview];

        [self performSelector:@selector(removeairedView) withObject:nil afterDelay:2.0];
    }
    
    
}
-(void)removeairedView{
    [airedview setFrame:CGRectMake(-300, 368, 284, 37)];
}
-(void)addAirImage:(NSTimer *)timer{
    if (timerVal<5) {
//        [airBackGroundImage setImage:[UIImage imageNamed:@"Up Arrow_1.png"]];
//        shouldContinueBlinking = YES;
//        [self blinkAnimation:@"blinkAnimation" finished:YES target:airBackGroundImage];
//        
        if (timerVal%2==0) {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:6];
            [airBackGroundImage setImage:nil];
            [UIView commitAnimations];
        }
        else {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:6];
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
    
    if (sinkVal<5) {
        
        if (sinkVal%2==0) {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            [sinkBackGroundImage setImage:nil];
            [UIView commitAnimations];
        }
        else {
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
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
        [expandButton setAlpha:0.6f];
        sinkVal=0;
        [timer invalidate];
        
        
    }
}
-(IBAction)SinkButtonClicked:(id)sender
{
    sink=1;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
    if ([[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]==0 && [[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isSinked"] boolValue]==0) {
        [[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithBool:YES] forKey:@"isSinked"];
        sinkingVal++;
        [[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] setValue:[NSNumber numberWithInt:sinkingVal] forKey:@"SinkCount"];
        
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
        
        NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/sink/text/%@?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"_id"]];
        
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
        NSTimer *timer;
        timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addSinkImage:) userInfo:nil repeats:YES];
    }
    else {
        if([[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"isAired"] boolValue]){
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
        [airedview setFrame:CGRectMake(18, 353, 287, 37)];
        [self.view bringSubviewToFront:airedview];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    [appDelegate.thoughtsViewArray addObject:self.view];

    timerVal=0;
    sinkVal=0;
   
    sinkingVal=[[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"SinkCount"] intValue];
    airVal=[[[appDelegate.thoughsTextFloats objectAtIndex:selectedAvatar] objectForKey:@"AirCount"] intValue];

    
    
    if(sinkingVal<10)
    {
        [sinkNumLabel setText:[NSString stringWithFormat:@"0%d",sinkingVal]];
    }
    else
    {
        [sinkNumLabel setText:[NSString stringWithFormat:@"%d",sinkingVal]];
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

   
    
    color = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1];
  }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setIsThoughtViewSelected:NO];
    [m_thoughtController loadcurrentView];
    [self.view removeFromSuperview];
}

-(IBAction)goBack:(id)sender
{
        [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
        [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    

}

-(IBAction)gotoHomePage:(id)sender
{
    appDelegate.isThoughtViewSelected = NO;
    
    
    for (int i1=0; i1<[appDelegate.thoughtsViewArray count]; i1++) {
        [[appDelegate.thoughtsViewArray objectAtIndex:i1] removeFromSuperview];
    }
    [appDelegate.thoughtsViewArray removeAllObjects];
    [appDelegate.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

    
}

- (void)viewDidUnload
{
     
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSDate*) getDateFromJSON:(NSString *)dateString
{
    
    NSDate *d;
    if (dateString == (id)[NSNull null] || dateString.length == 0 ) {
        d=nil;
    }
    else {
        int startPos = [dateString rangeOfString:@"("].location+1;
        int endPos = [dateString rangeOfString:@")"].location;
        
        NSRange range = NSMakeRange(startPos,endPos-startPos);
        
        dateString=[dateString substringWithRange:range];
        if ([dateString hasPrefix:@"-"]) {
            dateString=[dateString substringFromIndex:1];
            
        }
        unsigned long long milliseconds = [dateString longLongValue];
        
        NSTimeInterval interval = milliseconds/1000;
        d= [NSDate dateWithTimeIntervalSince1970:interval];
    }
    // Expect date in this format "/Date(1268123281843)/"
    return d;
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

- (void)blinkAnimation:(NSString *)animationId finished:(BOOL)finished target:(UIView *)target
{
    if (shouldContinueBlinking) {
        [UIView beginAnimations:animationId context:target];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
        if ([target alpha] == 1.0f)
            [target setAlpha:0.0f];
        else
            [target setAlpha:1.0f];
        [UIView commitAnimations];
    }
}
@end
