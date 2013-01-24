//
//  EventsExpandedView.m
//  NowFloatsv1
//
//  Created by pravasis on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventsExpandedView.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "JSON.h"
#import "MarqueeLabel.h"
#import <EventKit/EventKit.h>

@implementation EventsExpandedView
@synthesize img;


@synthesize dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)callPhone:(id)sender
{
    
    UIButton *btn = sender;    
    NSString *phoneFinalString = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneFinalString=[[phoneFinalString componentsSeparatedByString:@"TEL :"] objectAtIndex:1];
    phoneFinalString=[phoneFinalString stringByReplacingOccurrencesOfString:@" " withString:@""];

    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneFinalString]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        [Notpermitted release];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneFinalString]]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    accelerometer=[UIAccelerometer sharedAccelerometer];
    [accelerometer setDelegate:self];
    
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    
    [self animateImages];
    [belowView setFrame:CGRectMake(0, 100, belowView.frame.size.width, belowView.frame.size.height)];
    [self.view addSubview:belowView];
    

    color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    


    [eventImageView setImage:img];
    [eventTextLabel setText:[dic objectForKey:@"Title"]];
    [eventTextLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
    [eventTextLabel setTextColor:color];
    
    [eventTextView setText:[dic objectForKey:@"Title"]];
    [eventTextView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
    [eventTextView setTextColor:color];
    
    NSString *dateStringval=[dic objectForKey:@"StartDate"] ;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [dateFormatter setDateFormat:@"MMM"];
    if (dateStringval == (id)[NSNull null] || dateStringval.length == 0 ) {
        [monthLabel setText:@"T B D"];
        [dateLabel setText:@""];
        fullMonth=@"";
    }
    else {
        latestDate=[self getDateFromJSON:dateStringval];
        
    [monthLabel setText:[[dateFormatter stringFromDate:latestDate]uppercaseString]];
        [monthLabel setTextColor:color];
        [dateFormatter setDateFormat:@"dd"];
        [dateLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28.0f]];
        [dateLabel setText:[dateFormatter stringFromDate:latestDate]];
        [dateLabel setTextColor:color];
        [dateFormatter setDateFormat:@"MMMM"];
      fullMonth =[dateFormatter stringFromDate:latestDate];
       
  }
            
  
    [monthLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];

   
    [dateFormatter setDateFormat:@"dd"];
    NSString *sDate=[dateFormatter stringFromDate:latestDate];
    if (![sDate length]) {
        sDate=@"";
    }
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSString *sYear=[dateFormatter stringFromDate:latestDate];
    if (!sYear) {
        sYear=@"";
    }
    
    if ([dic objectForKey:@"Description"] ==[NSNull null])
    {
        [eventDescriptionText setText:@"Uh-oh!,No description available"];
    }

    else
    {
        [eventDescriptionText setText:[dic  objectForKey:@"Description"]];
    }
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *endDateString=[dic objectForKey:@"EndDate"] ;
    NSDate *endDate=[self getDateFromJSON:endDateString];
    [dateFormatter setDateFormat:@"dd"];
    NSString *eDate=[dateFormatter stringFromDate:endDate];
    if (![eDate length]) {
        eDate=@"";
    }
    
    if ([dic objectForKey:@"StartTime"] !=[NSNull null] && [dic objectForKey:@"EndTime"]!=[NSNull null] )
    {
        if ([[dic objectForKey:@"EndTime"] isEqualToString:@"Onwards"])
        {
            
            NSString *dateandTime=[NSString stringWithFormat:@"%@:00 AM - Onwards",[[[dic objectForKey:@"StartTime"] componentsSeparatedByString:@":"] objectAtIndex:0]];
            [dateandTimeValidityLabel setText:dateandTime];
            
        }
        else
        {
            
            NSString *dateandTime=[NSString stringWithFormat:@"%@:00 AM - %@:00 PM",[[[dic objectForKey:@"StartTime"] componentsSeparatedByString:@":"] objectAtIndex:0],[[[dic objectForKey:@"EndTime"] componentsSeparatedByString:@":"] objectAtIndex:0]];
            [dateandTimeValidityLabel setText:dateandTime];
        }
        
        
    }
    
    
    
    if ([dic objectForKey:@"StartTime"] ==[NSNull null] && [dic objectForKey:@"EndTime"]==[NSNull null] )
    {
        [dateandTimeValidityLabel setText:@"Timings Unavailable"];
    }
    
    
    if ([dic objectForKey:@"TicketType"]!=[NSNull null]) {
        [costLabel setText:[dic objectForKey:@"TicketType"]];

    }
    
    
    

   
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[appDelegate.locationArray objectAtIndex:0] floatValue] longitude:[[appDelegate.locationArray objectAtIndex:1] floatValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[[dic objectForKey:@"EventLocation"] objectForKey:@"latitude"]floatValue]longitude:[[[dic objectForKey:@"EventLocation"] objectForKey:@"longitude"]floatValue]];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
   
    float dis=distance/1000;
    
    NSString *st=[NSString stringWithFormat:@"%f",dis];
    
    [distanceLabel setText:[st substringToIndex:4]];
  
    
    
    [addressLabel setText:[dic objectForKey:@"FullAddress"]];
    
    compass=[[CompassViewController alloc] init];
    [compass setCompassImage:pointerView];
    [compass setLat:[[dic objectForKey:@"latitude"] floatValue]];
    [compass setLng:[[dic objectForKey:@"longitude"] floatValue]];
    
    [compass rotateImage];

    
    //[urlButton setTitle:[dic objectForKey:@"EventUri"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
mark.textColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1.000];            break;
        }
        
    }
}

-(IBAction)mapKitButtonClicked:(id)sender{
    //[mapImage setHidden:YES];
    
   // AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],[[[dic objectForKey:@"EventLocation"]objectForKey:@"latitude"] floatValue],[[[dic objectForKey:@"EventLocation"]objectForKey:@"longitude"] floatValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];
}

-(IBAction)goBack:(id)sender
{
    if (isShare) {
        
        [shareView removeFromSuperview];
        [belowView setHidden:NO];
        isShare=NO;
    }
    else
    {
    [self deallocate];
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[m_appDel.viewsArray objectAtIndex:[m_appDel.viewsArray count]-1] removeFromSuperview];
    [m_appDel.viewsArray removeObjectAtIndex:[m_appDel.viewsArray count]-1];
    }

}

-(IBAction)gotoHomePage:(id)sender
{
    
    [self deallocateForHome];
    AppDelegate *m_appDel =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    for(int j=0;j<[m_appDel.viewsArray count];j++)
    {
        [[m_appDel.viewsArray objectAtIndex:j] removeFromSuperview];
    }
    [m_appDel.viewsArray removeAllObjects];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)urlButtonClicked:(id)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dic objectForKey:@"EventUri"]]];
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
                unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
                
                NSTimeInterval interval = milliseconds/1000;
                d= [NSDate dateWithTimeIntervalSince1970:interval];
            }
            // Expect date in this format "/Date(1268123281843)/"
            return d;
        }

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    //pointerView.transform = CGAffineTransformMakeRotation(-atan2(acceleration.x, acceleration.y));
//     pointerView.transform = CGAffineTransformMakeRotation(azimutAngle-atan2(acceleration.x
//                                                                            , acceleration.y));
//    

}

-(IBAction)socialNetworkButtonsClicked:(id)sender{
    UIButton *b=(UIButton *)sender;
    
    if (b.tag==1) {
        TWTweetComposeViewController *tweetSheet = 
        [[TWTweetComposeViewController alloc] init];
        NSString *message=[NSString stringWithFormat:@"Hey! Just came across this event on NowFloats, and found its worth sharing\n %@ \nDownload the NowFloats app.",[dic objectForKey:@"EventUri"]];
        [tweetSheet setInitialText:message];
        [tweetSheet addImage:eventImageView.image];
        
        
        [self presentModalViewController:tweetSheet animated:YES];
    }
    else if (b.tag==2) {
       // NSString *client_id = @"172038482843979";
         NSString *client_id = @"193559690753525";
        fbGraph = [[FbGraph alloc] initWithFbClientID:client_id];
        
        [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(postInAppFacebook) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access" andSuperView:self.view];
    }
    else if(b.tag==3){
        
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (mailClass != nil)
        {
            // We must always check whether the current device is configured for sending emails
            if ([mailClass canSendMail])
            {
                [self displayComposerSheet];
            }
            else
            {
                [self launchMailAppOnDevice];
            }
        }
        else
        {
            [self launchMailAppOnDevice];
        }
        
    }
    
}

- (void)postInAppFacebook {
	
	
	
	NSMutableDictionary *variables = [[NSMutableDictionary alloc] initWithCapacity:3];
	
	
    
	//create a UIImage (you could use the picture album or camera too)
	//UIImage *picture=[[UIImage alloc] initWithData:dataImage];
	
	
	//create a FbGraphFile object insance and set the picture we wish to publish on it
	FbGraphFile *graph_file = [[FbGraphFile alloc] initWithImage:eventImageView.image];
	
	
	//finally, set the FbGraphFileobject onto our variables dictionary....
	[variables setObject:graph_file forKey:@"file"];
    NSString *message=[NSString stringWithFormat:@"%@ looked interesting to me. Thought i'd share. \n Click here for more details: %@",[dic objectForKey:@"Title"],[dic objectForKey:@"EventUri"]];
    
	[variables setObject:message forKey:@"message"];
	
	
	//the fbGraph object is smart enough to recognize the binary image data inside the FbGraphFile
	//object and treat that is such.....
	[fbGraph doGraphPost:@"me/photos" withPostVars:variables];
	
	//[self logOutButtonPressed];
}

-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@""];
	
	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:@""];
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"", @"", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@""]; 
	
	//[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
    NSData *myData = UIImageJPEGRepresentation(eventImageView.image, 1.0);;
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"NOWFLoats.jpeg"];
	
	// Fill out the email body text
    NSString *message=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"Title"],[dic objectForKey:@"FullAddress"]];
	[picker setMessageBody:message isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(IBAction) sendInAppSMS:(id) sender
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    
    if([MFMessageComposeViewController canSendText])
    {
        //[dic objectForKey:@"FullAddress"];
        controller.body = [NSString stringWithFormat:@" Hey! I found  		%@  on NowFloats. It's happening on %@ %@ and you can get more info from %@",[[dic objectForKey:@"FullAddress"] uppercaseString],monthLabel.text,dateLabel.text,[dic objectForKey:@"Contact"]];
        
        //controller.recipients = [NSArray arrayWithObjects:@"12345678", @"87654321", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissModalViewControllerAnimated:YES];
    //[self presentModalViewController:controller animated:YES];
    
}

-(IBAction)shareButtonClicked:(id)sender{
    isShare=YES;
    [belowView setHidden:YES];
    
    [shareView setFrame:CGRectMake(73, 100, 228, 228)];
    [self.view addSubview:shareView];
     AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    //[m_appDel.viewsArray addObject:shareView];
}

-(IBAction)addToCalendar:(id)sender{
    

    if ([self createEvent:[dic objectForKey:@"Title"] at:[dic objectForKey:@"ShortAddress"] starting:[appDelegate getDateFromJSON:[dic objectForKey:@"StartDate"]] ending:[appDelegate getDateFromJSON:[dic objectForKey:@"EndDate"]] withBody:nil andUrl:nil]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"It’s In" message:@"The event has been added to your calendar." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Uh-Ho!" message:@"The Event could not be added to your calendar.Try again later." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        [alert release];

        
    }
}

- (BOOL)createEvent:(NSString *)title
                 at:(NSString *)location
           starting:(NSDate *)startDate
             ending:(NSDate *)endDate
           withBody:(NSString *)body
             andUrl:(NSURL *)url
{
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = title;
    event.location  = location;
    event.startDate = startDate;
    if (endDate) {
        event.endDate   = endDate;

    }
    else{
        event.endDate=startDate;
    }
    
//    if ([body length]) {
//        event.notes     = body;
//
//    }
//    else{
//        event.notes=@"it is working";
//    }
    
    if (url)
        event.URL   = url;
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
    //    EKEventEditViewController *eventViewController = [[EKEventEditViewController alloc] init];
    //    eventViewController.event = event;
    //    eventViewController.eventStore = eventStore;
    //    eventViewController.editViewDelegate = self;
    //
    //    [_viewController presentModalViewController:eventViewController animated:YES];
    
    return TRUE;
}

-(void)deallocate
{
    [compass release];
    [monthLabel release];
    [dateLabel release];
    [eventTextLabel release];
    [eventImageView release];
    [eventDescriptionText release];
    [dateandTimeValidityLabel release];
    [costLabel release];
    [distanceLabel release];
    [phoneButton release];
    [distanceLabel release];
    [addressLabel release];
    [pointerView release];
    [urlButton release];
    [shareView release];
    [fbGraph release];
    [img release];

}


-(void)deallocateForHome
{

    [compass release];
    [monthLabel release];
    [dateLabel release];
    [eventTextLabel release];
    [eventImageView release];
    [eventDescriptionText release];
    [dateandTimeValidityLabel release];
    [costLabel release];
    [distanceLabel release];
    [phoneButton release];
    [distanceLabel release];
    [addressLabel release];
    [pointerView release];
    [urlButton release];
    [shareView release];
    [fbGraph release];
    [img release];

}
@end
