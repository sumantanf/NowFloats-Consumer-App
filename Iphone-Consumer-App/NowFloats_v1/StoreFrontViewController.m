//
//  StoreFrontViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreFrontViewController.h"
#import "AppDelegate.h"
#import "StoreViewMap.h"
#import "UIImageView+WebCache.h"
#import "FbGraphFile.h"
#import "JSON.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "MarqueeLabel.h"
@interface StoreFrontViewController ()

@end

@implementation StoreFrontViewController
@synthesize scrolling;
@synthesize fbGraph;
@synthesize dictionary;

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
 
    [qualityCommentLabel setFont:[UIFont fontWithName:@"Machi" size:12.0]] ;
    
    [valueCommentLabel  setFont:[UIFont fontWithName:@"Machi" size:12.0]];
    
    [serviceCommentLabel    setFont:[UIFont fontWithName:@"Machi" size:12.0]];
    
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([[dictionary objectForKey:@"lat" ] floatValue], [[dictionary objectForKey:@"lng" ] floatValue]);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    
    [mapView setRegion:MKCoordinateRegionMake(coordinate, span)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:coordinate];
    [mapView addAnnotation:annotation];
    [UIView commitAnimations];
    [annotation release];
    
    MKCoordinateRegion region;
    //Set Zoom level using Span
    // MKCoordinateSpan span;
    region.center=mapView.region.center;
    
    span.latitudeDelta=mapView.region.span.latitudeDelta /2.0002;
    span.longitudeDelta=mapView.region.span.longitudeDelta /2.0002;
    region.span=span;
    [mapView setRegion:region animated:TRUE];

    profilePic=[[NSMutableArray alloc] initWithObjects:@"storefront_worst_woman.png",@"storefront_bad_women.png",@"storefront_ok_woman.png",@"storefront_good_man.png",@"storefront_great_lady.png", nil];
    commentsArray=[[NSMutableArray alloc] initWithObjects:@"THE\n\"WORST\"",@"OMG IT'S\n\"BAD\"",@"IT'S\n\"OK\"",@"IT'S\n\"GOOD\"",@"WOW\n\"GREAT\"", nil];
    user=[NSUserDefaults standardUserDefaults];
    [[ratingButton layer] setCornerRadius:4.0f];
    [[ratingButton layer] setMasksToBounds:YES];
    [[ratingButton layer] setBorderWidth:0.0f];
    
    
    [[yourRatingButton layer] setCornerRadius:4.0f];
    [[yourRatingButton layer] setMasksToBounds:YES];
    [[yourRatingButton layer] setBorderWidth:0.0f];
    
    [ratingButton setAlpha:0.5];
    [ratingButton setEnabled:YES];
    [yourRatingButton setAlpha:1.0];
    [yourRatingButton setEnabled:NO];
    
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    
    [self animateImages];
   
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    
    //compass view
    
    compass=[[CompassViewController alloc] init];
    [compass setCompassImage:pointerView];
    [compass setLat:[[dictionary objectForKey:@"lat"] floatValue]];
    [compass setLng:[[dictionary objectForKey:@"lng"] floatValue]];
    
    [compass rotateImage];

    // BOttom Bar Creation
   // UIColor *color = [UIColor colorWithRed:250/250.0f green:150/250.0f blue:0/250.0f alpha:1.0];
    
//    bottomBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)];
//    [bottomBar setShowsHorizontalScrollIndicator:NO];
//    [bottomBar setPagingEnabled:YES];
//    [bottomBar setContentSize:CGSizeMake(592, 50)];
//    [bottomBar setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:bottomBar];
    
    
    
    AppDelegate *m_appDel =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    [m_appDel arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1.000];
            break;
        }
        
    }

   // bottomBar.frame = m_appDel.bottomBarFrame;
    //dictionary=[m_appDel.aroundData objectAtIndex:m_appDel.selectedArondValue];
   
    if([dictionary objectForKey:@"Description"]!=[NSNull null])
    {
    [imageDescription setText:[dictionary objectForKey:@"Description"]];
    }
    if([dictionary objectForKey:@"Name"]!=[NSNull null]){

    [mainNameLabel setText:[[dictionary objectForKey:@"Name"] uppercaseString]];
    }

    NSString *mapImageUrl=@"http://maps.googleapis.com/maps/api/staticmap?center=&zoom=17&size=320x220&maptype=roadmap&markers=color:green%7Clabel:%7C";
    NSString *lat=[NSString stringWithFormat:@"%f,%f&sensor=false",[[dictionary objectForKey:@"lat"] floatValue],[[dictionary objectForKey:@"lng"] floatValue]];
    mapImageUrl=[NSString stringWithFormat:@"%@%@",mapImageUrl,lat];

    [mapImage setImageWithURL:[NSURL URLWithString:mapImageUrl]];


    if ([dictionary objectForKey:@"ImageUri"]!=[NSNull null])
    {
        NSString *shopUrl=[NSString stringWithFormat:@"https://api.withfloats.com%@",[dictionary objectForKey:@"ImageUri"]];
       
        [shopImage setImageWithURL:[NSURL URLWithString:shopUrl]];

    }
    
   
    //Rating Page
    serviceSlider.transform = CGAffineTransformRotate(serviceSlider.transform, 90.0/180*M_PI);
    [serviceSlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
     UIImage *sliderLeftTrackImage = [[UIImage imageNamed:@"emptySliderBG.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    
    [serviceSlider setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [serviceSlider setMaximumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [serviceSlider setValue:0.5];
    qualitySlider.transform = CGAffineTransformRotate(qualitySlider.transform, 90.0/180*M_PI);
    [qualitySlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    [qualitySlider setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [qualitySlider setMaximumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [qualitySlider setValue:0.5];
    valueslider.transform = CGAffineTransformRotate(valueslider.transform, 90.0/180*M_PI);
    [valueslider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    [valueslider setMinimumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [valueslider setMaximumTrackImage:sliderLeftTrackImage forState:UIControlStateNormal];
    [valueslider setValue:0.5];
    
    [ratingLing setHidden:YES];
    [ratingName setHidden:YES];
    [ratingProfile setHidden:YES];
    [ratingSubmit setHidden:YES];
    [ratingSubmitLine setHidden:YES];
    [ratingCancelLine setHidden:YES];
    [ratingCancelButton setHidden:YES];

    [self RatingViewButtonClicke:ratingButton];
    
    
    //Page 1
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[m_appDel.locationArray objectAtIndex:0] floatValue] longitude:[[m_appDel.locationArray objectAtIndex:1] floatValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[dictionary objectForKey:@"lat"]floatValue] longitude:[[dictionary objectForKey:@"lng"]floatValue]];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    float dis=distance/1000;
   
    NSString *st;//=[NSString stringWithFormat:@"%f",dis];
    
    
    //Tel Number
    
      ar=[dictionary objectForKey:@"Contacts"];
    
    if ([dictionary objectForKey:@"Contacts"]!=[NSNull null] && [ar count]) {
      
        NSString *details=@"";
        int y;
        if ([ar count]==1) {
            y=174;
        }
        else if([ar count]==2){
            y=164;
        }
        else{
            y=154;
 
        }
        for (int j=0; j<[ar count]; j++) {
           // NSString *contactName;
            
            NSString *tellNo=[[ar objectAtIndex:j] objectForKey:@"ContactNumber"];
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(38, y, 150, 25)];
            [label setText:tellNo];
            
            
            
            [label setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            
            [label setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTag:j+1];
            [page2 addSubview:label];
           
            
            UIButton *callButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [callButton setTitle:@"CALL" forState:UIControlStateNormal];
            [callButton setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [callButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] forState:UIControlStateNormal];
            [callButton setFrame:CGRectMake(180, y+10, 50, 10)];
            //[callButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [callButton setTag:j];
            [callButton addTarget:self action:@selector(callButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [page2 addSubview:callButton];
            UIView *lineVIew=[[UIView alloc] initWithFrame:CGRectMake(235, y+10, 2, 10)];
            [lineVIew setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
            [page2 addSubview:lineVIew];
            
            UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
            [saveButton setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [saveButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] forState:UIControlStateNormal];
            [saveButton setFrame:CGRectMake(242, y+10, 50, 10)];
            //[saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [saveButton setTag:j];
            [saveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

            [page2 addSubview:saveButton];
            
            
             y=y+19;
            //details=[NSString stringWithFormat:@"%@TEL     :%@\n",details,tellNo];
        }

        //[tellNumber setText:details];
        [contactNumber setText:details];
        //[tellNumber setText:[NSString stringWithFormat:@" TEL    : %@ \nNAME : NOT AVAILABLE",[[ar objectAtIndex:0] objectForKey:@"ContactNumber"]]];
    }
    

    
    
    //Distance in Meters
   // [distanceLaebl setText:[NSString stringWithFormat:@"%@ K.M",[st substringToIndex:3]]];
    
   // NSString *st;
    
    //Distance in Meters
    
    if (dis<1.0) {
        st=@"Here";
        
        [distanceLaebl setText:st];
    }
    else{
        st =[NSString stringWithFormat:@"%f",dis];
        
        [distanceLaebl setText:[NSString stringWithFormat:@"%@ K.M",[st substringToIndex:3]]];
        
    }
   // [locA release];
    
    //[locB release];
    
 
    
    //Second Page
    if ([dictionary objectForKey:@"Address"]!=(id)[NSNull null] )
    {
        NSString *addresString=[dictionary objectForKey:@"Address"];
        NSMutableArray *addressArray=[[NSMutableArray alloc] initWithCapacity:1];

     
        addressArray=(NSMutableArray *)[addresString componentsSeparatedByString:@","];
        
        NSString *empty=@"";
        NSString *addresString2=@"";

        for (NSString *ThisLine in addressArray){
            
            addresString2=[NSString stringWithFormat:@"%@%@\n",addresString2,ThisLine];
    }
        [addressDetails setText:addresString2];
       // [addressArray release];

    }
    if ([dictionary objectForKey:@"Timings"]!=[NSNull null]) {
        
        NSMutableArray *mutArrSkills=[dictionary objectForKey:@"Timings"];
        for(int i2=0;i2<[mutArrSkills count]; i2++)
        {
            if([mutArrSkills objectAtIndex:i2]==(id)[NSNull null])
            {
                [mutArrSkills removeObjectAtIndex:i2];  
            }
        }
        
    }

    if ([dictionary objectForKey:@"Timings"]==[NSNull null])
    {
        
        [openLabel setText:@"Not Available"];
        [openLbl2 setText:@"Not Available"];
        
    }

    
    if ([dictionary objectForKey:@"Timings"]!=[NSNull null] && [[dictionary objectForKey:@"Timings"] objectAtIndex:0]!=(id)[NSNull null]) {
        
    timmingString =@"";
    
        NSMutableArray *timmingArray=[dictionary objectForKey:@"Timings"];
        NSMutableArray *dayNames=[[NSMutableArray alloc] initWithCapacity:1];
        [dayNames addObject:@"SUN"];
        [dayNames addObject:@"MON"];
        [dayNames addObject:@"TUE"];
        [dayNames addObject:@"WED"];
        [dayNames addObject:@"THU"];
        [dayNames addObject:@"FRI"];
        [dayNames addObject:@"SAT"];
       
        NSDate *d=[NSDate date];
        NSDateFormatter *day=[[NSDateFormatter alloc] init];
        [day setDateFormat:@"eee"];
        for (int j=0; j<[timmingArray count]; j++) {
               
           
            if ([[[timmingArray objectAtIndex:j] objectForKey:@"From"] length]== 1&& [[[timmingArray objectAtIndex:j] objectForKey:@"To"] length]==1) {

                timmingString=[NSString stringWithFormat:@"%@Closed (%@)\n",timmingString,[dayNames objectAtIndex:j]];
            }
            else {
                if ([[[day stringFromDate:d] lowercaseString] isEqualToString:[[dayNames objectAtIndex:j] lowercaseString]]) {
                    currentTimmings=[NSString stringWithFormat:@"\n\n\n%@ - %@ (%@)",[[timmingArray objectAtIndex:j] objectForKey:@"From"],[[timmingArray objectAtIndex:j] objectForKey:@"To"],[dayNames objectAtIndex:j]];
                    
                }
                
                timmingString=[NSString stringWithFormat:@"%@%@ - %@ (%@)\n",timmingString,[[timmingArray objectAtIndex:j] objectForKey:@"From"],[[timmingArray objectAtIndex:j] objectForKey:@"To"],[dayNames objectAtIndex:j]];

            }
            
        
        }
        dayTimmings=[currentTimmings copy];
        allDaysTimmings=[timmingString copy];
        [tellNumber setText:currentTimmings];
        
        UIButton *showButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [showButton setTitle:@"Show all days" forState:UIControlStateNormal];
        [showButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];

        [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [showButton setTag:100];
        [showButton addTarget:self action:@selector(expandTimmings:) forControlEvents:UIControlEventTouchUpInside];
        [showButton setFrame:CGRectMake(77, 173, 120, 30)];
        [showButton setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:181.0f/255.0f blue:77.0f/255.0f alpha:1]];
        [tellNumber addSubview:showButton];
        

        
        NSDate *now = [NSDate date];
        
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"eee"];
        int currentDayVal;
        NSString *dayName=[formatter stringFromDate:now];
        if ([dayName isEqualToString:@"Sun"]) {
            currentDayVal=0;
        }
        else if ([dayName isEqualToString:@"Mon"]) {
            currentDayVal=1;
        }
        else if ([dayName isEqualToString:@"Tue"]) {
            currentDayVal=2;
        }
        else if ([dayName isEqualToString:@"Wed"]) {
            currentDayVal=3;
        }
        else if ([dayName isEqualToString:@"Thu"]) {
            currentDayVal=4;
        }
        else if ([dayName isEqualToString:@"Fri"]) {
            currentDayVal=5;
        }
        else if ([dayName isEqualToString:@"Sat"]) {
            currentDayVal=6;
        }
        
        [formatter setDateFormat:@"hh:mm a"];
        [formatter setDefaultDate:now];
        NSDate *theDate = [formatter dateFromString:[[timmingArray objectAtIndex:currentDayVal] objectForKey:@"From"]];
        NSComparisonResult theResult = [theDate compare:now];
        
        BOOL isAscending;
        if (theResult==NSOrderedAscending) {
            isAscending=YES;
        }
        else     if (theResult==NSOrderedDescending) {
            
            isAscending=NO;
        }
        else if(theResult==NSOrderedSame){
            isAscending=YES;
        }
        theDate = [formatter dateFromString:[[timmingArray objectAtIndex:currentDayVal] objectForKey:@"To"]];
 
        theResult = [theDate compare:now];
        BOOL isDscending;
        if (theResult==NSOrderedAscending) {
            isDscending=NO;
        }
        else     if (theResult==NSOrderedDescending) {
            
            isDscending=YES;
        }
        else if(theResult==NSOrderedSame){
            isDscending=YES;
        }
        
        if (isAscending & isDscending)
        {
            [openImage setImage:[UIImage imageNamed:@"open_light.png"]];
            [openLabel setText:@"Open"];
            [openImage2 setImage:[UIImage imageNamed:@"open_light.png"]];
            [openLbl2 setText:@"Open"];

            
        }
        
        
        
        else
        {
            [openImage setImage:[UIImage imageNamed:@"closed_light.png"]];
            [openLabel setText:@"Closed"];
            [openImage2 setImage:[UIImage imageNamed:@"closed_light.png"]];
            [openLbl2 setText:@"Closed"];
        }

        
        
        
       // [timmingArray release];
        //[dayNames release];
    }
    
        int xPosition = 0 ;
    
    //Ratings
    
    for (int j = 1; j<7 ; j++)
    {
        UIView *v;
        
        if (j==1)
        {
            v=page1;
        }
        else if (j==2) {
            
            
            v=page2;

        }
        else if (j==3) {
            v=page3;
        }
        else if (j==4)
        {
            v=page4;
            [page7 setFrame:CGRectMake(0, 40, 320, 234)];
            
            NSMutableArray *ratingArray=[dictionary objectForKey:@"Ratings"];
            if ([dictionary objectForKey:@"Ratings"]!=(id) [NSNull null] && [ratingArray count])
            {
                [page4 addSubview:page7];
                selectedRatingView=page7;
                
            }
            else
            {
                [page4 addSubview:oopsMessage];
                selectedRatingView=oopsMessage;
            }
            
            [yourRatingButton setAlpha:0.5];
            [yourRatingButton setEnabled:YES];
            [ratingButton setAlpha:1.0];
            [ratingButton setEnabled:NO];
        }
        else if (j==5) {
            v=page5;
        }
        else if (j==6) {
            v=page6;
        }

        v.frame = CGRectMake(xPosition, 0, 320, 255);
        
        [scrolling addSubview:v];
        
        xPosition  = xPosition + 320 ;
        
        
    }
    [scrolling setDelegate:self];
    [scrolling setContentSize:CGSizeMake(xPosition, 250)];
    [self.view addSubview:swipeTut];
    
    tap=[[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapButtonClicked)];
    [tap setNumberOfTapsRequired:1];
    [swipeTut addGestureRecognizer:tap];
    [tap release];
    
    swipGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtonClicked)];
    [swipGesture setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp)];

    [swipeTut addGestureRecognizer:swipGesture];
    
    //[scrolling setContentInset:<#(UIEdgeInsets)#>
    // Do any additional setup after loading the view from its nib.
}

-(void)tapButtonClicked
{
    
    [swipeTut removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (![scrollView isKindOfClass:[UITableView class]]) {
        int pageControlValue=[scrollView contentOffset].x;
        pageControlValue=pageControlValue/320;
        [pageControlle setCurrentPage:pageControlValue];
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
        [img2 setAlcomppha:0.75];
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

-(IBAction)goBack:(id)sender
{
    
    
    ViewController *vController=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [m_appDel downloadData];
    
    
    
    [m_appDel setSkipByValue:0];
    [vController.eventActivity startAnimating];
    [vController.dealActivity startAnimating];
    [vController.thoughtActivity startAnimating];
    [vController.aroundYouLabel setText:@"AROUND YOU"];
    [vController.rightNowLabel setText:@"RIGHT NOW"];
    [vController.dealsCountlabel setText:@""];
    [vController.eventsCountLael setText:@""];
    [vController.thoughtsCountLabel setText:@""];
    
    [self.view removeFromSuperview];
}

-(IBAction)serviceRating:(id)sender
{
    [ratingLing setHidden:NO];
    [ratingName setHidden:NO];
    [ratingProfile setHidden:NO];
    [ratingSubmit setHidden:NO];
    [ratingSubmitLine setHidden:NO];
    [ratingCancelLine setHidden:NO];
    [ratingCancelButton setHidden:NO];
    
    [serviceSlider setThumbImage:[UIImage imageNamed:@"newSliderwithshadow.png"] forState:UIControlStateNormal];

    [valueslider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];

    [qualitySlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];

    if (serviceSlider.value>0.0f && serviceSlider.value<=0.1f)
    {
        [ratingLing setImage:[UIImage imageNamed:@"5.png"]];
    }
    else if (serviceSlider.value>0.1f && serviceSlider.value<=0.35f)
    {
       [ratingLing setImage:[UIImage imageNamed:@"4.png"]];
    }
    else if (serviceSlider.value>0.3f && serviceSlider.value<=0.6f)
    {
      [ratingLing setImage:[UIImage imageNamed:@"3.png"]];
    }
    else if (serviceSlider.value>0.6f && serviceSlider.value<=0.88f)
    {
      [ratingLing setImage:[UIImage imageNamed:@"2.png"]];
    }
    else if(serviceSlider.value>0.85)
    {
      [ratingLing setImage:[UIImage imageNamed:@"1.png"]];
    }
    
    [groove1 setAlpha:1.0f];
    [markers1 setAlpha:1.0f];
    [groove2 setAlpha:0.4f];
    [markers2 setAlpha:0.4f];
    
    [groove3 setAlpha:0.4f];
    [markers3 setAlpha:0.4f];
    
    [self performSelector:@selector(addjustServiceRating) withObject:nil afterDelay:1.6];
}

-(void)addjustServiceRating
{
    
    //[groove1 setAlpha:0.4f];
    //[markers1 setAlpha:0.4f];
    if (serviceSlider.value>0.0f && serviceSlider.value<=0.1f) {
        [serviceSlider setValue:0.0];
    }
    else if (serviceSlider.value>0.1f && serviceSlider.value<=0.35f) {
        [serviceSlider setValue:0.25];
    }
    else if (serviceSlider.value>0.3f && serviceSlider.value<=0.6f) {
        [serviceSlider setValue:0.5];
    }
    else if (serviceSlider.value>0.6f && serviceSlider.value<=0.88f) {
        [serviceSlider setValue:0.75];
    }
    else if(serviceSlider.value>0.85) {
        [serviceSlider setValue:1.0];
    }
}

-(IBAction)qualityRating:(id)sender
{
    
    [ratingLing setHidden:NO];
    [ratingName setHidden:NO];
    [ratingProfile setHidden:NO];
    [ratingSubmit setHidden:NO];
    [ratingSubmitLine setHidden:NO];
    [ratingCancelLine setHidden:NO];
    [ratingCancelButton setHidden:NO];
    [groove1 setAlpha:0.4f];
    [markers1 setAlpha:0.4f];

    [groove2 setAlpha:1.0f];
    [markers2 setAlpha:1.0f];
    
    [groove3 setAlpha:0.4f];
    [markers3 setAlpha:0.4f];
    
    [qualitySlider setThumbImage:[UIImage imageNamed:@"newSliderwithshadow.png"] forState:UIControlStateNormal];
    
    [valueslider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    
    [serviceSlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    
    
    if (qualitySlider.value>0.0f && qualitySlider.value<=0.1f) {
        [ratingLing setImage:[UIImage imageNamed:@"5.png"]];
    }
    else if (qualitySlider.value>0.1f && qualitySlider.value<=0.35f) {
         [ratingLing setImage:[UIImage imageNamed:@"4.png"]];

    }
    else if (qualitySlider.value>0.3f && qualitySlider.value<=0.6f) {
       [ratingLing setImage:[UIImage imageNamed:@"3.png"]];

    }
    else if (qualitySlider.value>0.6f && qualitySlider.value<=0.88f) {
        [ratingLing setImage:[UIImage imageNamed:@"2.png"]];

    }
    else if(qualitySlider.value>0.85) {
        [ratingLing setImage:[UIImage imageNamed:@"1.png"]];

    }
    [self performSelector:@selector(addjustQualityRating) withObject:nil afterDelay:1.6];
    
}

-(void)addjustQualityRating
{

    //[groove2 setAlpha:0.4f];
    //[markers2 setAlpha:0.4f];
    if (qualitySlider.value>0.0f && qualitySlider.value<=0.1f) {
        [qualitySlider setValue:0.0];
    }
    else if (qualitySlider.value>0.1f && qualitySlider.value<=0.35f) {
        [qualitySlider setValue:0.25];
    }
    else if (qualitySlider.value>0.3f && qualitySlider.value<=0.6f) {
        [qualitySlider setValue:0.5];
    }
    else if (qualitySlider.value>0.6f && qualitySlider.value<=0.88f) {
        [qualitySlider setValue:0.75];
    }
    else if(qualitySlider.value>0.85) {
        [qualitySlider setValue:1.0];
    }

}

-(IBAction)valueRating:(id)sender
{
    [ratingLing setHidden:NO];
    [ratingName setHidden:NO];
    [ratingProfile setHidden:NO];
    [ratingSubmit setHidden:NO];
    [ratingSubmitLine setHidden:NO];
        [ratingCancelLine setHidden:NO];
     [ratingCancelButton setHidden:NO];
    
    
    [groove1 setAlpha:0.4f];
    [markers1 setAlpha:0.4f];
    
    
    
    [groove2 setAlpha:0.4f];
    [markers2 setAlpha:0.4f];
    [groove3 setAlpha:1.0f];
    [markers3 setAlpha:1.0f];
    [valueslider setThumbImage:[UIImage imageNamed:@"newSliderwithshadow.png"] forState:UIControlStateNormal];
    
    [serviceSlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    
    [qualitySlider setThumbImage:[UIImage imageNamed:@"slider_with_shadow.png"] forState:UIControlStateNormal];
    
    if (valueslider.value>0.0f && valueslider.value<=0.1f) {
         [ratingLing setImage:[UIImage imageNamed:@"5.png"]];
}
    else if (valueslider.value>0.1f && valueslider.value<=0.35f) {
       [ratingLing setImage:[UIImage imageNamed:@"4.png"]];

    }
    else if (valueslider.value>0.3f && valueslider.value<=0.6f) {
        [ratingLing setImage:[UIImage imageNamed:@"3.png"]];

    }
    else if (valueslider.value>0.6f && valueslider.value<=0.88f) {
        [ratingLing setImage:[UIImage imageNamed:@"2.png"]];

    }
    else if(valueslider.value>0.85) {
         [ratingLing setImage:[UIImage imageNamed:@"1.png"]];

    }
    
    [self performSelector:@selector(adjustValueRating) withObject:nil afterDelay:1.6];
    
}

-(void)adjustValueRating
{
  //  [groove3 setAlpha:0.4f];
  //  [markers3 setAlpha:0.4f];
    if (valueslider.value>0.0f && valueslider.value<=0.1f) {
        [valueslider setValue:0.0];
    }
    else if (valueslider.value>0.1f && valueslider.value<=0.35f) {
        [valueslider setValue:0.25];
    }
    else if (valueslider.value>0.3f && valueslider.value<=0.6f) {
        [valueslider setValue:0.5];
    }
    else if (valueslider.value>0.6f && valueslider.value<=0.88f) {
        [valueslider setValue:0.75];
    }
    else if(valueslider.value>0.85) {
        [valueslider setValue:1.0];
    }

    
}

-(IBAction)gotoHomePage:(id)sender
{
    [self.view removeFromSuperview];
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];
    
    [m_appDel downloadData];

    
}

-(IBAction)mapKitButtonClicked:(id)sender
{
    //[mapImage setHidden:YES];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *formattedGroceryAddress = [[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"Address"]] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],[[dictionary objectForKey:@"lat"] floatValue],[[dictionary objectForKey:@"lng"] floatValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];

//    StoreViewMap *storeView=[[StoreViewMap alloc] initWithNibName:@"StoreViewMap" bundle:nil];
//    [storeView setLatitudeValue:[dictionary objectForKey:@"lat"]];
//     [storeView setLongitudeValue:[dictionary objectForKey:@"lng"]];
//    [self.view addSubview:storeView.view];
        
}

//Social Network Button Clicked

-(IBAction)socialNetworkButtonsClicked:(id)sender
{
    UIButton *b=(UIButton *)sender;
    
    if (b.tag==1) {
        TWTweetComposeViewController *tweetSheet = 
        [[TWTweetComposeViewController alloc] init];
        NSString *message;
        if ([dictionary objectForKey:@"Tag"]!=[NSNull null]) {
            message=[NSString stringWithFormat:@"Hey! Found http://%@.nowfloats.com on NowFloats, think it's worth sharing.",[dictionary objectForKey:@"Tag"]];
            
        }
        else{
            message=[NSString stringWithFormat:@"Hey! Found %@ on NowFloats, think it's worth sharing. ",[dictionary objectForKey:@"Name"]];
            
        }
        [tweetSheet setInitialText:message];
        [tweetSheet addImage:mapImage.image];
        
    
        [self presentModalViewController:tweetSheet animated:YES];
    }
   else if (b.tag==2) {
      // NSString *client_id = @"172038482843979";
       NSString *client_id =@"193559690753525";
       
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

- (void)postInAppFacebook
{
	
	
	
	NSMutableDictionary *variables = [[NSMutableDictionary alloc] initWithCapacity:3];
		
	//create a FbGraphFile object insance and set the picture we wish to publish on it
	FbGraphFile *graph_file = [[FbGraphFile alloc] initWithImage:mapImage.image];
	
	
	//finally, set the FbGraphFileobject onto our variables dictionary....
	[variables setObject:graph_file forKey:@"file"];
    NSString *message;
    if ([dictionary objectForKey:@"Tag"]!=[NSNull null])
    {
        message=[NSString stringWithFormat:@"Hey! Found http://%@.nowfloats.com on NowFloats, think it's worth sharing.",[dictionary objectForKey:@"Tag"]];

    }
    
    else{
        message=[NSString stringWithFormat:@"Hey! Found %@ on NowFloats, think it's worth sharing. ",[dictionary objectForKey:@"Name"]];

    }
    
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
    NSData *myData = UIImageJPEGRepresentation(mapImage.image, 1.0);;
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"NOWFLoats.jpeg"];
	
	// Fill out the email body text
	 NSString *message=[NSString stringWithFormat:@"%@%@",[dictionary objectForKey:@"Name"],[dictionary objectForKey:@"Address"]];
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

-(IBAction)sendInAppSMS:(id) sender
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    
    if([MFMessageComposeViewController canSendText])
    {
        
        controller.body=[NSString stringWithFormat:@"Hey! I found %@",[dictionary objectForKey:@"Name"]]; 				
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    //[self presentModalViewController:controller animated:YES];
    
}

-(IBAction)ratingButtonClicked:(id)sender
{
    RatingValue=0;
    if ([user objectForKey:@"DisplayTag"]) {
        int sliderVal;
        if (serviceSlider.value==0.0) {
            sliderVal=5;
        }
        else if (serviceSlider.value==0.25) {
            sliderVal=4;
        }
        else if (serviceSlider.value==0.5) {
            sliderVal=3;
        }
        else if (serviceSlider.value==0.75) {
            sliderVal=2;
        }
        else if (serviceSlider.value==1) {
            sliderVal=1;
        }
        NSString *serviceVal=[NSString stringWithFormat:@"%d",sliderVal];
    
        NSMutableDictionary *di=[[NSMutableDictionary alloc] initWithCapacity:1];
        [di setValue:serviceVal forKey:@"value1"];
        [di setValue:@"Service" forKey:@"type1"];
      //  [self performSelector:@selector(submitRatings:) onThread:[NSThread currentThread] withObject:di waitUntilDone:YES];
        if (qualitySlider.value==0.0) {
            sliderVal=5;
        }
        else if (qualitySlider.value==0.25) {
            sliderVal=4;
        }
        else if (qualitySlider.value==0.5) {
            sliderVal=3;
        }
        else if (qualitySlider.value==0.75) {
            sliderVal=2;
        }
        else if (qualitySlider.value==1) {
            sliderVal=1;
        }
        serviceVal=[NSString stringWithFormat:@"%d",sliderVal];
       
        
      //  NSMutableDictionary *di2=[[NSMutableDictionary alloc] initWithCapacity:1];
        [di setValue:serviceVal forKey:@"value2"];
        [di setValue:@"Quality" forKey:@"type2"];
       // [self performSelector:@selector(submitRatings:) onThread:[NSThread currentThread] withObject:di2 waitUntilDone:YES];
        
        if (valueslider.value==0.0) {
            sliderVal=5;
        }
        else if (valueslider.value==0.25) {
            sliderVal=4;
        }
        else if (valueslider.value==0.5) {
            sliderVal=3;
        }
        else if (valueslider.value==0.75) {
            sliderVal=2;
        }
        else if (valueslider.value==1) {
            sliderVal=1;
        }
        serviceVal=[NSString stringWithFormat:@"%d",sliderVal];
        
        
       // NSMutableDictionary *di3=[[NSMutableDictionary alloc] initWithCapacity:1];
        [di setValue:serviceVal forKey:@"value3"];
        [di setValue:@"Value" forKey:@"type3"];
        [self performSelector:@selector(submitRatings:) onThread:[NSThread currentThread] withObject:di waitUntilDone:YES];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Login" message:@"Please Login" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
    
}

-(void)submitRatings:(NSMutableDictionary *)di
{
    
   
    
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
        [dic setValue:@"5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A" forKey:@"clientId"];
        
        [dic setValue:[dictionary objectForKey:@"_id"] forKey:@"fpId"];
        
        
        [dic setValue:[user objectForKey:@"_id"] forKey:@"userId"];
        
        
        
        [dic setValue:[NSNumber numberWithDouble:[[dictionary objectForKey:@"lat"] doubleValue]]   forKey:@"lat"];
        [dic setValue:[NSNumber numberWithDouble:[[dictionary objectForKey:@"lng"] doubleValue]] forKey:@"lng"];
        //[dic setValue:[di objectForKey:@"Ratings"] forKey:@"Type"];
    NSMutableArray *ratingArray=[[NSMutableArray alloc] initWithCapacity:1];
    for (int i3=0; i3<3; i3++)
    {
        if (i3==0)
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
            [dic setObject:[di objectForKey:@"type1"] forKey:@"Type"];
            [dic setObject:[di objectForKey:@"value1"] forKey:@"Value"];
            [ratingArray addObject:dic];
        }
        else if (i3==1)
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
            [dic setObject:[di objectForKey:@"type2"] forKey:@"Type"];
            [dic setObject:[di objectForKey:@"value2"] forKey:@"Value"];
            [ratingArray addObject:dic];
        }
        else if (i3==2)
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
            [dic setObject:[di objectForKey:@"type3"] forKey:@"Type"];
            [dic setObject:[di objectForKey:@"value3"] forKey:@"Value"];
            [ratingArray addObject:dic];
        }
    }
    [dic setObject:ratingArray forKey:@"Ratings"];
        
        double val=[[di objectForKey:@"value"] doubleValue];
        [dic setValue:[NSNumber numberWithDouble:val] forKey:@"Value"];
        
        
        NSString *newurlString=[dic JSONRepresentation];
   
        
        NSString *url=@"https://api.withfloats.com/Discover/v1/FloatingPoint/rating/create";
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

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
    if (code==200) {
       
            UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:@"Ratings" message:@"Ratings Sucessfully Posted" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertview show];
        
    }
    else {
       
    }
}

-(IBAction)RatingViewButtonClicke:(id)sender
{
     NSMutableArray *ratingArray=[dictionary objectForKey:@"Ratings"];
    if ([dictionary objectForKey:@"Ratings"]!=(id) [NSNull null] && [ratingArray count]) {
        //NSMutableArray *ratingArray=[dictionary objectForKey:@"Ratings"];
        int totalVal=[ratingArray count]/3;
        //Service Rating Value
        float serviceVal;
        
        float valueVal;
        float qualityVal;
        if (![ratingArray count]) {
            serviceVal=0;
            valueVal=0;
            qualityVal=0;
            
        }
        else{
            for (int i1=0; i1<[ratingArray count]; i1++) {
                if ([[[ratingArray objectAtIndex:i1] objectForKey:@"Type"] isEqualToString:@"Service"]) {
                    serviceVal+=[[[ratingArray objectAtIndex:i1] objectForKey:@"Value"] floatValue];    
                }
                else if ([[[ratingArray objectAtIndex:i1] objectForKey:@"Type"] isEqualToString:@"Value"]) {
                    valueVal+=[[[ratingArray objectAtIndex:i1] objectForKey:@"Value"] floatValue];    
                }
                else if ([[[ratingArray objectAtIndex:i1] objectForKey:@"Type"] isEqualToString:@"Quality"]) {
                    qualityVal+=[[[ratingArray objectAtIndex:i1] objectForKey:@"Value"] floatValue];    
                }
                
            }
            
            serviceVal=serviceVal/totalVal;
            valueVal=valueVal/totalVal;
            qualityVal=qualityVal/totalVal;
        }

        

        

        //NSString *serviceRating=[NSString stringWithFormat:@"%f",serviceVal];

        [serviceRating setText:[[NSString stringWithFormat:@"%f",serviceVal ] substringToIndex:3]];
        [valueRating setText:[[NSString stringWithFormat:@"%f",valueVal] substringToIndex:3]];
        [qualityRating setText:[[NSString stringWithFormat:@"%f",qualityVal] substringToIndex:3]];
        
        
        [serviceRatingImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[NSString stringWithFormat:@"%f",serviceVal] substringToIndex:1]]]];
        [valueRatingImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[NSString stringWithFormat:@"%f",valueVal] substringToIndex:1]]]];
        [qualityRatingImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[NSString stringWithFormat:@"%f",qualityVal] substringToIndex:1]]]];
        
        
        
        [serviceCommentLabel setText:[commentsArray objectAtIndex:[[[NSString stringWithFormat:@"%f",serviceVal] substringToIndex:1] intValue]-1]];

        [valueCommentLabel setText:[commentsArray objectAtIndex:[[[NSString stringWithFormat:@"%f",valueVal] substringToIndex:1] intValue]-1]];

        [qualityCommentLabel setText:[commentsArray objectAtIndex:[[[NSString stringWithFormat:@"%f",qualityVal] substringToIndex:1] intValue]-1]];

        
//        [serviceImage setImage:[UIImage imageNamed:[profilePic objectAtIndex:[[[NSString stringWithFormat:@"%f",serviceVal] substringToIndex:1] intValue]]]];
//        [valueImage setImage:[UIImage imageNamed:[profilePic objectAtIndex:[[[NSString stringWithFormat:@"%f",valueVal] substringToIndex:1] intValue]]]];
//
//        [qualityImage setImage:[UIImage imageNamed:[profilePic objectAtIndex:[[[NSString stringWithFormat:@"%f",qualityVal] substringToIndex:1] intValue]]]];
        float totalValue=serviceVal+valueVal+qualityVal;
        totalValue=totalValue/3;
       
        int overallRating = floor(totalValue + 0.5);
      

        for (int i1=0; i1<overallRating; i1++) {
            if (i1==0) {
                [starImage1 setImage:[UIImage imageNamed:@"star.png"]];
            }
            else if (i1==1) {
                [starImage2 setImage:[UIImage imageNamed:@"star.png"]];
            }
            else if (i1==2) {
                [starImage3 setImage:[UIImage imageNamed:@"star.png"]];
            }

            else if (i1==3) {
                [starImage4 setImage:[UIImage imageNamed:@"star.png"]];
            }

            else if (i1==4) {
                [starImage5 setImage:[UIImage imageNamed:@"star.png"]];
            }

        }
        //NSLog(@"Service value is: %f : %@ and Value : %f and Qualityvalue: %f",serviceVal,[serviceRating substringToIndex:3],valueVal,qualityVal);
        selectedRatingView=page7;
        

        [page7 setFrame:CGRectMake(0, 40, 320, 234)];
        [page4 addSubview:page7];


    }
    else {
        selectedRatingView=oopsMessage;

        [oopsMessage setFrame:CGRectMake(0, 40, 320, 234)];
        [page4 addSubview:oopsMessage];

    }
    [yourRatingButton setAlpha:0.5];
    [yourRatingButton setEnabled:YES];
    [ratingButton setAlpha:1.0];
    [ratingButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:150/255.0f blue:0/255.0f alpha:1]];
    [ratingButton setEnabled:NO];
    }

-(IBAction)yourRatingButtonClicked:(id)sender
{
    [ratingButton setAlpha:0.5];
    [ratingButton setEnabled:YES];
    [yourRatingButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:150/255.0f blue:0/255.0f alpha:1]];
    [yourRatingButton setAlpha:1.0];
    [yourRatingButton setEnabled:NO];
    [selectedRatingView removeFromSuperview];
}

-(void)callButtonClicked:(id)sender
{

    UIButton *b=(UIButton *)sender;
    callVal=b.tag;
    NSString *tellNo=[[ar objectAtIndex:b.tag] objectForKey:@"ContactNumber"];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Call %@",tellNo] delegate:self cancelButtonTitle:@"CALL" otherButtonTitles:@"CANCEL", nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1) {
        
        if (buttonIndex==0) {
          
            [serviceSlider setValue:0.5];
            
            [qualitySlider setValue:0.5];
           
            [valueslider setValue:0.5];
            
            [ratingLing setHidden:YES];
            [ratingName setHidden:YES];
            [ratingProfile setHidden:YES];
            [ratingSubmit setHidden:YES];
            [ratingSubmitLine setHidden:YES];
            [ratingCancelLine setHidden:YES];
            [ratingCancelButton setHidden:YES];
            
            
            [page7 setFrame:CGRectMake(0, 40, 320, 234)];
            [page4 addSubview:page7];
            selectedRatingView=page7;
            [yourRatingButton setAlpha:0.5];
            [yourRatingButton setEnabled:YES];
            [ratingButton setAlpha:1.0];
            [ratingButton setEnabled:NO];
        }
    }
    else {
        if (buttonIndex==0) {
            
            UIDevice *device = [UIDevice currentDevice];
            if ([[device model] isEqualToString:@"iPhone"] ) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[ar objectAtIndex:callVal] objectForKey:@"ContactNumber"]]]];
            } else {
                UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [Notpermitted show];
                [Notpermitted release];
            }
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[ar objectAtIndex:callVal] objectForKey:@"ContactNumber"]]]];
           // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"TEL: %@",[[ar objectAtIndex:callVal] objectForKey:@"ContactNumber"]]]];
        }
    }
    
}

-(void)saveButtonClicked:(id)sender
{
    
    UIButton *b=(UIButton *)sender;
    callVal=b.tag;
    NSString *tellNo=[[ar objectAtIndex:b.tag] objectForKey:@"ContactNumber"];
    CFStringRef fname =(CFStringRef)[dictionary objectForKey:@"Name"] ;
    //CFStringRef lname =(CFStringRef) @"N" ;
    
    CFErrorRef error = NULL; 
    ABRecordRef newPerson = ABPersonCreate();
    
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, fname , &error);
   // ABRecordSetValue(newPerson, kABPersonLastNameProperty, lname, &error);
    

    //NSString *phone = @"040-555666";
    NSString *mobile=tellNo; 
   
    
    ABMutableMultiValueRef phoneNumberMultiValue =
    ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    //ABMultiValueAddValueAndLabel(phoneNumberMultiValue ,phone,kABPersonPhoneMainLabel, NULL);
    ABMultiValueAddValueAndLabel(phoneNumberMultiValue ,mobile,kABPersonPhoneMobileLabel, NULL);
    
    
    
    
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, phoneNumberMultiValue, &error);
    
    ABNewPersonViewController *picker = [[[ABNewPersonViewController alloc] init] autorelease];
    [picker.view setFrame:CGRectMake(0, 0, 320, 410)];
    
    picker.addressBook = ABAddressBookCreate();
    [picker setDisplayedPerson:newPerson];
    picker.newPersonViewDelegate = self ;
    
    UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:picker];
    [self presentModalViewController:navigation animated:YES];
    
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person;
{
    // NSLog(@"didCompleteWithNewPerson") ;
    //[self.navigationController popViewControllerAnimated:YES];
    
    if(nil != person) 
    {
        
        [self dismissModalViewControllerAnimated:YES];
        
    }
    else{
        [self dismissModalViewControllerAnimated:YES];

    }
}

-(void)expandTimmings:(id)sender
{
    
    UIButton *expandButton=(UIButton *)sender;
    if (expandButton.tag==100) {
        [expandButton setTitle:@"Show today" forState:UIControlStateNormal];
        [expandButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];

        [expandButton setTag:200];
        [expandButton setFrame:CGRectMake(77, 173, 120, 30)];

        [tellNumber setText:timmingString];
        
        
    }
    else {
        [expandButton setTitle:@"Show all days" forState:UIControlStateNormal];
        [expandButton setTag:100];
        [expandButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [expandButton setFrame:CGRectMake(77, 173, 120, 30)];

        [tellNumber setText:currentTimmings];
    }
}

-(IBAction)cancelButtonClicked:(id)sender
{
    

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Your ratings help others choose better. Are you sure?"  delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1];
    [alert show];
    [alert release];
}

-(IBAction)StoreFrontImageButtonClicked:(id)sender
{
  
    StoreFrontImageDetailView *storeFront=[[StoreFrontImageDetailView alloc] initWithNibName:@"StoreFrontImageDetailView" bundle:nil];
    [storeFront setImg:shopImage.image];
    
    [storeFront.view setFrame:self.view.bounds];
    [self.view addSubview:storeFront.view];

    
}

-(void)deallocate;
{

    [compass release];
    [page1 release];
    [page2 release] ;
    [page3 release];
    [page4 release];
    [page5 release];
    [page6 release];
    [page7 release];
    [sliderImage1 release];
    [sliderImage2 release];
    [sliderImage3 release];
    [sliderShadow1 release];
    [sliderShadow2 release];
    [sliderShadow3 release];
    [groove1 release];
    [groove2 release];
    [groove3 release];
    [markers1 release];
    [markers2 release];
    [markers3 release];
    [serviceSlider release];
    [qualitySlider release];
    [valueslider release];
    [distanceLaebl release];
    [pointerView release];
    [addressDetails release];
    [mainNameLabel  release];
    [ratingButton release];
    [oopsMessage  release];
    [tellNumber release];
    [serviceRating release];
    [qualityRating release];
    [valueRating release];
    [starImage1 release];
    [starImage2  release];
    [starImage3 release];
    [starImage4 release];
    [starImage5 release];
    [shopImage release];
    [openImage release];
    [openLabel release];
    [imageDescription release];
    [ratingLing release];
    [ratingName release];
    [ratingSubmit release];
    [ratingSubmitLine release];
    [ratingCancelLine release];
    [ratingCancelLine release];
    [serviceRatingImg release];
    [valueRatingImg release];
    [qualityRatingImg release];
    [openImage2 release];
    [openLbl2 release];
    [mapView release];
    [scrolling release];
    [fbGraph release];
    
}

@end
