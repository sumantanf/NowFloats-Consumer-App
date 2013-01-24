//
//  ViewController.m
//  NowFloats_v1
//
//  Created by pravasis on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StoreFrontViewController.h"

#import "QuartzCore/QuartzCore.h"
#import "SettingsViewCon.h"
#import "UIColor+HexaString.h"
#import "MarqueeLabel.h"
#import "DownloadData.h"
@implementation ViewController

@synthesize distanceButton;
@synthesize locationButton;
@synthesize aroundYouLabel;
@synthesize rightNowButton;
@synthesize rightNowLabel;
@synthesize dealsCountlabel;
@synthesize eventsCountLael;
@synthesize thoughtsCountLabel;
@synthesize backGroundImageView;
@synthesize dollarLabel;
@synthesize dayLabel;
@synthesize bottomBar;
@synthesize parentView;
@synthesize radiusLine;
@synthesize locationLine;
@synthesize editButton;
@synthesize bottomCreateFloat;
@synthesize dealActivity,eventActivity,thoughtActivity;
@synthesize homeButtonTag;
@synthesize dealbtn;
@synthesize eventbtn;
@synthesize thoughtsbtn;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
      
    [super viewDidLoad];

 
    [self arrangeBottomButtons];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.bottomBar=bottomBar;
    
   // NSLog(@"Random Number: %u",arc4random() );
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
    //[searchButton setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd"];
    
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];

    [dayLabel setText:currentDay];
    [dateFormatter release];
    //255 165 10  RGB Colors
    currentOffset = 0.0f;
    
    [self animateImages];
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    m_appDel.bottomBarFrame = bottomBar.frame;
    m_appDel.bottomBar=bottomBar;
    if([m_appDel.distanceString length]>0)
        [distanceButton setTitle:m_appDel.distanceString forState:UIControlStateNormal];
    
    locationManager = [[CLLocationManager alloc] init];
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 80.0f;
        [locationManager startUpdatingLocation];
    }
    
    color = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1];
    
    [profileButton.titleLabel setTextColor:color];
    [settingsButton.titleLabel setTextColor:color];
    [refreshButton.titleLabel setTextColor:color];
    [aroundYouLabel setFont:[UIFont fontWithName:@"Machi" size:50]];
    [rightNowLabel setFont:[UIFont fontWithName:@"Machi" size:50]];
  
    

    
    [aroundYouLabel setTransform:CGAffineTransformMakeRotation(4.71)];
    [rightNowLabel setTransform:CGAffineTransformMakeRotation(4.71)];
    [rightNowButton setTransform:CGAffineTransformMakeRotation(4.71)];
    
    //[bottomBar setContentSize:CGSizeMake(640, 40)];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];
    [bottomBar setBackgroundColor:[UIColor blackColor]];
    [dollarLabel setTextColor:[UIColor colorWithRed:5/255.0 green:0/255.0 blue:28/255.0f alpha:0.5f]];
    [dayLabel setTextColor:[UIColor colorWithRed:5/255.0 green:0/255.0 blue:28/255.0f alpha:0.5f]];
	
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ColorValue"] intValue]) {
        int colorVal=[[[NSUserDefaults standardUserDefaults] objectForKey:@"ColorValue"] intValue];
        if (colorVal==1) {
            [self.view setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
            [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[UIButton class]]) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"739db2"];
                    }
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"739db2"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
                    }
                }
            }
        }
        else if (colorVal==2) {
            
            [self.view setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
           [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"fff587"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[UIButton class]]) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"b2ab5e"];
                    }
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b2ab5e"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
                    }
                }
            }
        }
        
        
        else if (colorVal==3) {

            [self.view setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"ffa50a"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                        
                    }
                }
            }
        }
        
        
        
        else if (colorVal==4) {
            [self.view setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
            [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"202c66"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"202c66"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
                    }
                }
            }
        }
        else if (colorVal==5) {
            [self.view setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
            [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"b28cab"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b28cab"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
                    }
                }
            }
        }
        else if (colorVal==6) {
            [self.view setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
            [dayLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
            [dollarLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
            [parentView setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
            [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ff0000"] ];

            for (UIView *v in bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"b20000"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b20000"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[UIButton class]]){
                    
                    if (![v isKindOfClass:[UIImageView class]]) {
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
                    }
                    
                }
            }
        }
        
    }
    else {
        [dayLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
        [dollarLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
       [bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"] ];
    }
}

-(IBAction)searchButtonClicked:(id)sender
{
    m_searchController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [m_searchController.view setFrame:CGRectMake(0, 0, 320, 460)];
    
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if([m_appDel.viewsArray count]>0)
    {
        [m_appDel clearArray];
    }
    
    [m_appDel.viewsArray addObject:m_searchController.view];
    if(!m_appDel.isSearchButtonSelected)
    {
        [self.view addSubview:m_searchController.view];
        m_appDel.isSearchButtonSelected = YES;
    }
}

-(IBAction)createFloat:(id)sender
{

    NSUserDefaults *userdetails=[NSUserDefaults standardUserDefaults];
    if ([userdetails objectForKey:@"DisplayTag"]) {
        
        createFloatController = [[CreateFloatViewController alloc] initWithNibName:@"CreateFloatViewController" bundle:nil];
        AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if([m_appDel.viewsArray count]>0)
        {
            [m_appDel clearArray];
        }
        
        [m_appDel.viewsArray addObject:createFloatController.view];
        [self.view addSubview:createFloatController.view];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
        
    }
   
    
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
        LoginViewController *loginVi=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:loginVi.view];
        
    }
}

-(IBAction)EditButtonClicked:(id)sender
{
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
   
    
        if(!m_appDel.isEditButtonSelected)
        {
    
    m_EditController = [[EditController alloc] initWithNibName:@"EditController" bundle:nil];
    [m_EditController setViewCon:self];
    
    // [m_appDel.editViewArray addObject:m_
    [m_EditController setFromHome:1];
    [m_EditController.view setFrame:CGRectMake(0, 0, 320, 410)];
    
    
    if([m_appDel.viewsArray count]>0)
    {
        [m_appDel clearArray];
    }
    
    [m_appDel.viewsArray addObject:m_EditController.view];
    [self.view addSubview:m_EditController.view];
    m_appDel.isEditButtonSelected = YES;
    }
}

-(IBAction)EventsButtonClicked:(id)sender
{
     eventController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
 
    if([m_appDel.viewsArray count]>0)
    {
        [m_appDel clearArray];
    }

    [m_appDel.viewsArray addObject:eventController.view];
    [self.view addSubview:eventController.view];
}

-(IBAction)loadDealsController:(id)sender
{
       m_dealsController = [[DealsViewController alloc] initWithNibName:@"DealsViewController" bundle:nil];
    
    
        
    [m_dealsController readDealsInfo];
    
    AppDelegate *m_appDel =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if([m_appDel.viewsArray count]>0)
    {
        [m_appDel clearArray];
    }

    [m_appDel.viewsArray addObject:m_dealsController.view];
    [self.view addSubview:m_dealsController.view];
}

-(IBAction)loadThoughtsController:(id)sender
{
//    DownloadData *dd=[[DownloadData alloc]init];
//    [dd downloadData:thoughtsbtn.tag];
    
    
    m_thoughtsController = [[ThoughtsViewController alloc] initWithNibName:@"ThoughtsViewController" bundle:nil];
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    
    

    if([m_appDel.viewsArray count]>0)
    {
        [m_appDel clearArray];
    }

    [m_appDel.viewsArray addObject:m_thoughtsController.view];
    [self.view addSubview:m_thoughtsController.view];
}

- (void)viewDidUnload
{
    [self setDealbtn:nil];
    [self setEventbtn:nil];
    [self setThoughtsbtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma CLLocationManagerDelegate Methods

- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation
{

    
    
    NSString *lat = [[NSString alloc] initWithFormat:@"%g",
                     newLocation.coordinate.latitude];
    NSString *lng = [[NSString alloc] initWithFormat:@"%g",
                     newLocation.coordinate.longitude];
    NSString *acc = [[NSString alloc] initWithFormat:@"%g",
                     newLocation.horizontalAccuracy];
    
    //NSLog(@"lat is %@ \n  long is %@ \n accuracy is %@",lat,lng,acc);
    
    [acc release];
    [lat release];
    [lng release];
}


- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error
{
//    NSString *msg = [[NSString alloc]
//                     initWithString:@"Error obtaining location"];
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"Error"
//                          message:msg
//                          delegate:nil
//                          cancelButtonTitle: @"Done"
//                          otherButtonTitles:nil];
//    [alert show];
//    [msg release];
//    [alert release];
}


-(IBAction)profileButtonClicked:(id)sender
{
 /*   changeAvatarController = [[ChangeAvatarViewController alloc] initWithNibName:@"ChangeAvatarViewController" bundle:nil];
    [self.view addSubview:changeAvatarController.view];*/

    loginViewCon=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginViewCon.view setBounds:self.view.bounds];
    [self.view addSubview:loginViewCon.view];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}


-(IBAction)rightNowButtonClicked:(id)sender
{
    StoreFrontViewController *store=[[StoreFrontViewController alloc] initWithNibName:@"StoreFrontViewController" bundle:nil];
    [store setDictionary:(NSMutableDictionary *)[appDelegate.aroundData objectAtIndex:appDelegate.selectedArondValue]];
    [self.view addSubview:store.view];
    
}


-(IBAction)settingButtonClicked:(id)sender
{

    settingVi=[[SettingsViewCon alloc] initWithNibName:@"SettingsViewCon" bundle:nil];
    [settingVi setViewCon:self];
    [settingVi.view setBounds:self.view.bounds];
    [self.view addSubview:settingVi.view];
    
}


-(IBAction)refreshButtonClicked:(id)sender
{

     AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [m_appDel downloadData];
    [appDelegate setSkipByValue:0];
    [self.eventActivity startAnimating];
    [self.dealActivity startAnimating];
    [self.thoughtActivity startAnimating];
    [self.aroundYouLabel setText:@"AROUND YOU"];
    [self.rightNowLabel setText:@"RIGHT NOW"];
    [self.dealsCountlabel setText:@""];
    [self.eventsCountLael setText:@""];
    [self.thoughtsCountLabel setText:@""];
    
}


-(void)viewMoving
{
    
    if (timinngVal==10) {
        [self.view setFrame:CGRectMake(0, 20, 320, 460)];
        [timer invalidate];
    }
    else {
        int xval=320-timinngVal*32;
        [self.view setFrame:CGRectMake(xval, 20, 320, 460)];
        timinngVal++;
        
    }
}


-(void)arrangeBottomButtons
{
    for (int i1=0; i1<3; i1++) {
        if (i1==0) {
            [editButton setFrame:CGRectMake(550, 7, 29, 38)];
            [radiusLine setFrame:CGRectMake(editButton.frame.origin.x-6, 20, 1, 12)];
        }
        else if(i1==1){

            [distanceButton setFrame:CGRectMake(radiusLine.frame.origin.x-44, 7, 40, 38)];

            
        }
        else if(i1==2){
            NSString *radiusString;
            radiusString=[distanceButton.titleLabel text];
            if ([radiusString length]==5) {
                [locationLine setFrame:CGRectMake(distanceButton.frame.origin.x+3, 20, 1, 12)];
            }
            else if ([radiusString length]==6) {
                [locationLine setFrame:CGRectMake(distanceButton.frame.origin.x-2, 20, 1, 12)];
            }
            else if ([radiusString length]==7) {
                [locationLine setFrame:CGRectMake(distanceButton.frame.origin.x-5, 20, 1, 12)];
            }
            
            if ([locationButton.titleLabel.text length]<25) {
                [locationButton setFrame:CGRectMake(locationLine.frame.origin.x-205, 7, 200, 38)];
                
            }
            
            else{
                MarqueeLabel *continuousLabel2 ;
                [locationButton setHidden:YES];
                
                continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(locationLine.frame.origin.x-200, 16, 195, 20) rate:50.0f andFadeLength:10.0f];
                
                
                continuousLabel2.marqueeType = MLContinuous;
                // continuousLabel2.continuousMarqueeSeparator = @"  |SEPARATOR|  ";
                continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
                continuousLabel2.numberOfLines = 1;
                continuousLabel2.opaque = YES;
                continuousLabel2.enabled = YES;
                continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
                continuousLabel2.textAlignment = UITextAlignmentRight;
                continuousLabel2.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
                continuousLabel2.backgroundColor = [UIColor clearColor];
                continuousLabel2.font = [UIFont fontWithName:@"HelveticaNeue" size:10.000];
                continuousLabel2.text = locationButton.titleLabel.text;
                [bottomBar addSubview:continuousLabel2];
            }

            
        }
    }
}


- (void)dealloc
{
    [dealbtn release];
    [eventbtn release];
    [thoughtsbtn release];
    [super dealloc];
    
    
    [distanceButton release];
    [locationButton release];
    [aroundYouLabel release];
    [rightNowButton release];
    [rightNowLabel release];
    [dealsCountlabel release];
    [eventsCountLael release];
    [thoughtsCountLabel release];
    [backGroundImageView release];
    [dollarLabel release];
    [dayLabel release];
    [bottomBar release];
    [parentView release];
    [editButton release];
    [refreshButton release];
    [locationLine release];
    [radiusLine release];
    [bottomCreateFloat release];
    [dealActivity release];
    [eventActivity release];
    [thoughtActivity release];
    [dealbtn release];
    [eventbtn release];
    [thoughtsbtn release];
    [m_dealsController release];
    [m_searchController release];
    [m_thoughtsController release];
    [m_EditController release];
    [createFloatController release];
    [locationManager release];
    [img1 release];
    [img2 release];
    [img3 release];
    [img4 release];
    [settingVi release];
    [bottomCreateFloat release];
    [appDelegate release];
    [searchButton release];
    [bottomBar release];
    [settingsButton release];
    [profileButton release ];
    [timer1 release];
    [timer release];
    


    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction)HomeButtonClicked:(id)sender
{
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [bottomBar setContentOffset:CGPointMake(260, 0) animated:YES];
    if (appDelegate.isEditButtonSelected) {
        for (int i1=0; i1<[appDelegate.viewsArray count]; i1++) {
            [[appDelegate.viewsArray objectAtIndex:i1] removeFromSuperview];
            [appDelegate.viewsArray removeObjectAtIndex:i1];
            
        }
        appDelegate.isEditButtonSelected=NO;
        
    }
    
}


-(void)animateImages
{
    i = 0;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ColorValue"] intValue]) {
        int colorVal=[[[NSUserDefaults standardUserDefaults] objectForKey:@"ColorValue"] intValue];
        if (colorVal==1) {
            [img1 setImage:[UIImage imageNamed:@"b.png"]];
            [img2 setImage:[UIImage imageNamed:@"b.png"]];
            
            [img3 setImage:[UIImage imageNamed:@"b.png"]];
            
            [img4 setImage:[UIImage imageNamed:@"b.png"]];
            
        }
        else if (colorVal==2) {
            [img1 setImage:[UIImage imageNamed:@"c.png"]];
            [img2 setImage:[UIImage imageNamed:@"c.png"]];
            
            [img3 setImage:[UIImage imageNamed:@"c.png"]];
            
            [img4 setImage:[UIImage imageNamed:@"c.png"]];
            
        }
        else if (colorVal==3) {
            [img1 setImage:[UIImage imageNamed:@"t1_day.png"]];
            [img2 setImage:[UIImage imageNamed:@"t1_day.png"]];
            [img3 setImage:[UIImage imageNamed:@"t1_day.png"]];
            [img4 setImage:[UIImage imageNamed:@"t1_day.png"]];
        }
        else if (colorVal==4) {
            [img1 setImage:[UIImage imageNamed:@"m.png"]];
            [img2 setImage:[UIImage imageNamed:@"m.png"]];
            [img3 setImage:[UIImage imageNamed:@"m.png"]];
            [img4 setImage:[UIImage imageNamed:@"m.png"]];
        }
        else if (colorVal==5) {
            [img1 setImage:[UIImage imageNamed:@"p.png"]];
            [img2 setImage:[UIImage imageNamed:@"p.png"]];
            [img3 setImage:[UIImage imageNamed:@"p.png"]];
            [img4 setImage:[UIImage imageNamed:@"p.png"]];
        }
        else if (colorVal==6) {
            [img1 setImage:[UIImage imageNamed:@"r.png"]];
            [img2 setImage:[UIImage imageNamed:@"r.png"]];
            [img3 setImage:[UIImage imageNamed:@"r.png"]];
            [img4 setImage:[UIImage imageNamed:@"r.png"]];
        }
    }
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationImages:) userInfo:nil repeats:YES];
}


-(IBAction)animationImages:(id)sender
{
    ++i;
    if(i == 1)
    {
        [img1 setHidden:NO];
        [img1 setAlpha:1.0];
        [t1 setHidden:NO];
        [t1 setAlpha:1.0];
        
    }
    else if(i == 2)
    {
        [img2 setHidden:NO];
        [img2 setAlpha:0.75];
        [t2 setHidden:NO];
        [t2 setAlpha:0.75];
    }
    else if(i == 3)
    {
        [img3 setHidden:NO];
        [img3 setAlpha:0.50];
        [t3 setHidden:NO];
        [t3 setAlpha:0.50];
    }
    else if(i == 4)
    {
        [img4 setHidden:NO];
        [img4 setAlpha:0.35];
        [t4 setHidden:NO];
        [t4 setAlpha:0.35];
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
        [t1 setHidden:YES];
        [t2 setHidden:YES];
        [t3 setHidden:YES];
        [t4 setHidden:YES];
    }
    if(i == 1 && stoporNot2 && stoporNot1)
    {
        [timer1 invalidate];
        [img1 setHidden:YES];
        [img2 setHidden:YES];
        [img3 setHidden:YES];
        [img4 setHidden:YES];
        [t1 setHidden:YES];
        [t2 setHidden:YES];
        [t3 setHidden:YES];
        [t4 setHidden:YES];
    }
}

@end
