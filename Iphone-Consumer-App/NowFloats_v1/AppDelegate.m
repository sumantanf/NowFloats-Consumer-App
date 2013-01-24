//
//  AppDelegate.m
//  NowFloats_v1
//
//  Created by pravasis on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "TempSplashViewController.h"
#import "ViewController.h"
#import "Parser.h"
#import "UrlInfo.h"
#import "EditController.h"
#import "MarqueeLabel.h"
#import "DealsViewController.h"
#import "DownloadData.h"
#import "DealsViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize isThoughtViewSelected;
@synthesize isEditButtonSelected;
@synthesize selectedDistance;
@synthesize distanceString;
@synthesize viewsArray;
@synthesize isNameViewSelected;
@synthesize bottomBarFrame;
@synthesize isSearchButtonSelected,dealsData,eventsData,storeFrontData,aroundData,radiusVal,locationArray,selectedArondValue,thoughtsOwnerDetails,thoughsTextFloats,thoughtsComments,commentVal,thoughsImageFloats,countingarray,countingdic;
@synthesize thoughtsViewArray;
@synthesize skipByValue;
@synthesize imgaethoughtOwnerDetails;
@synthesize bottomBarData;
@synthesize editViewArray;
@synthesize IsFromEditController;
@synthesize bottomBar;
@synthesize backupVC;
@synthesize isInternet;
@synthesize eventSortName;
@synthesize aroundResposeCode;
@synthesize  dealSortName,arraApp;
@synthesize thoughtsTab,imageScroll,didEnterBackgroundAfterErrorFlag,didEnterBackgrroundBeforeErrorFlag,eventCount,dealCount,textCount;
@synthesize dealRef,imageOwner;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    //[self.dealsData release];
   // [self.eventsData release];
    [self.thoughsTextFloats release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeApplication];
    
       
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (didEnterBackgroundAfterErrorFlag ) {
        didEnterBackgroundAfterErrorFlag = 0;
        [self initializeApplication];
    }
}

-(void) applicationDidEnterBackground:(UIApplication *)application{
    if(didEnterBackgroundAfterErrorFlag)
    {
        exit(0);
    }
}

-(void) initializeApplication{
    
    
    
    radiusVal=3.0;
    skipByValue=0;
    eventSortName=@"latest";
    dealSortName=@"nearest";
    commentVal=0;
    appStartTimestamp = [NSDate date];
    firstCallInitiated = 0;
    
    
    imgaethoughtOwnerDetails=[[NSMutableArray alloc]init];
    imageOwner=[[NSMutableArray alloc]init ];
    locationManager=[[CLLocationManager alloc] init];
    locationArray=[[NSMutableArray alloc] initWithCapacity:0];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = 1;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];    
    
    latitude=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
    [locationArray addObject:latitude];
    longitude=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    [locationArray addObject:longitude];
    
//        [locationArray addObject:@"17.42891"];//Banjara Hills
//        [locationArray addObject:@"78.429781"];
//    
        //Dilsukhnagar    17.369153,78.524602
    
    if ([CLLocationManager locationServicesEnabled])
    {
        [self performSelector:@selector(target) withObject:nil afterDelay:3];
    }
    else{
        [self performSelector:@selector(target) withObject:nil afterDelay:1];
    }
    
    self.viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.dealsData =[[NSMutableArray alloc] initWithCapacity:0];
    self.eventsData =[[NSMutableArray alloc] initWithCapacity:0];
    self.storeFrontData=[[NSMutableArray alloc] initWithCapacity:0];
    self.aroundData=[[NSMutableArray alloc] initWithCapacity:0];
    
    thoughtsOwnerDetails=[[NSMutableArray alloc] initWithCapacity:0];
    thoughsTextFloats=[[NSMutableArray alloc] initWithCapacity:0];
    thoughtsComments=[[NSMutableArray alloc] initWithCapacity:0];
    thoughsImageFloats=[[NSMutableArray alloc] initWithCapacity:0];
    thoughtsViewArray=[[NSMutableArray alloc] initWithCapacity:0];
    bottomBarData=[[NSMutableArray alloc] initWithCapacity:0];
    editViewArray=[[NSMutableArray alloc] initWithCapacity:1];
    [bottomBarData addObject:@"Near Location"];
    [bottomBarData addObject:@"3 KMS"];
    
    userDetails=[NSUserDefaults standardUserDefaults];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    backupVC=self.viewController;
    
    imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default@2x.png"]];
    [imageView setUserInteractionEnabled:NO];
    [imageView setFrame:self.viewController.view.bounds];
    
    imageBack=[[UIView alloc] initWithFrame:imageView.bounds];
    [imageBack addSubview:imageView];
    
    [self.viewController.view addSubview:imageBack];
    
    label=[[UILabel alloc] initWithFrame:CGRectMake(90, 410, 200, 44)];
        
    [label setTextColor:[UIColor whiteColor]];
    
    [label setFont:[UIFont fontWithName:@"Helvetica-light" size:14.0f]];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    [imageView addSubview:label];
    
    isAnimeForFirstTime=1;
    
    
    [self blinkAnimation:@"blinkAnimation" finished:YES target:label];
    
    
    [self.window makeKeyAndVisible];
    
}

-(void)target
{
    if ([CLLocationManager locationServicesEnabled])
    {
        
        int a=0;
        
        b++;
        
        if (aroundResposeCode==200)
        {
            blinkVal=6;
            a=1;
        }
        
        
        if(a!=1)
        {
            if (b<10)
            {
                [self performSelector:@selector(target) withObject:nil afterDelay:5];          
            
            }
            
            else
            {
                blinkVal=7;
                [self errorMessages];
            }
            
        }
        
        
    }
    
    else{                               
        blinkVal=7;
        [self errorMessages];
    }
    
    
    
}



- (void)blinkAnimation:(NSString *)animationID finished:(BOOL)finished target:(UIView *)target 
{
    if (blinkVal<4)
        
    {
                    int a;
        if (isAnimeForFirstTime==1) {

            a=1;
            //a++;
        }
        
        else if(isAnimeForFirstTime ==2)
        {
            a=2;
        }
        
        else if (isAnimeForFirstTime==3)
        {
            a=3;
        }
        
        else if (isAnimeForFirstTime==4)
        {
            a=4;
        }
        
        
        if (a==1) {
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(75, 410, 175, 26)];
            [imgView setImage:[UIImage imageNamed:@"Acquiring Location Icon.png"]];
            [imageView addSubview:imgView];
            isAnimeForFirstTime=2;

            //NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
            float speedFloat = 1.4;
            
            [UIView beginAnimations:animationID context:imgView];
            [UIView setAnimationDuration:speedFloat];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
            
            
            
            if ([imgView alpha]==1.0f) {
                [imgView   setAlpha:0.0f];
            }
            
            else{
                [imgView setAlpha:1.0f];
            }
            
            
            [UIView commitAnimations];
        
        }
        
        
        if (a==2) {
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(90, 410, 133, 26)];
            [imgView setImage:[UIImage imageNamed:@"Loading Event Icon.png"]];
            [imageView addSubview:imgView];

            
            //NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
            float speedFloat = 1.4;
            
            [UIView beginAnimations:animationID context:imgView];
            [UIView setAnimationDuration:speedFloat];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
            
            
            
            if ([imgView alpha]==1.0f) {
                [imgView   setAlpha:0.0f];
            }
            
            else{
                [imgView setAlpha:1.0f];
            }
            
            
            [UIView commitAnimations];
            
            
            isAnimeForFirstTime=3;
            
        }
        
        if (a==3) {
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(90, 410, 127, 26)];
            [imgView setImage:[UIImage imageNamed:@"Loading Offers Icon.png"]];
            [imageView addSubview:imgView];
            
            
            //NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
            float speedFloat = 1.4;
            
            [UIView beginAnimations:animationID context:imgView];
            [UIView setAnimationDuration:speedFloat];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
            
            
            
            if ([imgView alpha]==1.0f) {
                [imgView   setAlpha:0.0f];
            }
            
            else{
                [imgView setAlpha:1.0f];
            }
            
            
            [UIView commitAnimations];
        
            isAnimeForFirstTime=4;
            
        }

        
        if (a==4) {
            imgView=[[UIImageView alloc]initWithFrame:CGRectMake(90, 410, 150, 27)];
            [imgView setImage:[UIImage imageNamed:@"Loading THoughts Icon_1.png"]];
            [imageView addSubview:imgView];
            
            
           //NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
            float speedFloat = 1.4;
            
            [UIView beginAnimations:animationID context:imgView];
            [UIView setAnimationDuration:speedFloat];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(blinkAnimation:finished:target:)];
            
            if ([imgView alpha]==1.0f) {
                [imgView   setAlpha:0.0f];
            }
            
            else{
                [imgView setAlpha:1.0f];
            }
            
            
            [UIView commitAnimations];
            
            isAnimeForFirstTime=1;
            
        }

}
    
    else
    {
        [self performSelector:@selector(displayName) withObject:nil afterDelay:0.1];
    }
    
    
}


- (void)blinkAnimationText:(NSString *)animationID finished:(BOOL)finished target:(UIView *)target
{
    
   if(blinkVal<4)
   {
            NSString *selectedSpeed = [NSString stringWithFormat:@"0.1"];
            float speedFloat = (1.00 - [selectedSpeed floatValue]);
            
            [UIView beginAnimations:animationID context:(UIView *)target];
            [UIView setAnimationDuration:speedFloat];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(blinkAnimationText:finished:target:)];
            
            
            
            if ([target alpha]==1.0f) {
                [target   setAlpha:0.0f];
            }
            
            else{
                [target setAlpha:1.0f];
            }
            
            
            [UIView commitAnimations];
            
        }
        
        
          
    else
    {
        [self performSelector:@selector(displayName) withObject:nil afterDelay:0.1];
    }
    

    
    
}








-(void)errorMessages{
    
    if (isInternet || blinkVal==7) {
        
        int errorVal=[[userDetails objectForKey:@"errorVal"] intValue];
        UIImageView *errorImage=[[UIImageView alloc] initWithFrame:self.viewController.view.frame];

        if (errorVal==0) {
            [errorImage setImage:[UIImage imageNamed:@"err1.png"]];
            [userDetails setInteger:1 forKey:@"errorVal"];
            [userDetails synchronize];

        }
        else if (errorVal==1) {
            [errorImage setImage:[UIImage imageNamed:@"err2.png"]];
            [userDetails setInteger:2 forKey:@"errorVal"];
            [userDetails synchronize];
            
        }
        else  if (errorVal==2) {
            [errorImage setImage:[UIImage imageNamed:@"err3.png"]];
            [userDetails setInteger:0 forKey:@"errorVal"];
            [userDetails synchronize];
            
        }
        
        [self.window addSubview:errorImage];
        [self.window bringSubviewToFront:errorImage];
        
        didEnterBackgroundAfterErrorFlag = 1;
    
    }
}

-(void)displayName{
    [imageBack removeFromSuperview];
}

-(void)downloadData{
    if ([dealsData count]) {
        [dealsData removeAllObjects];
    }
//    if ([eventsData count]) {
//        [eventsData removeAllObjects];
//    }
    if ([aroundData count]) {
        [aroundData removeAllObjects];
    }
    if ([thoughtsOwnerDetails count]) {
        [thoughtsOwnerDetails removeAllObjects];
    }
    if ([thoughsImageFloats count]) {
        [thoughsImageFloats removeAllObjects];
    }

    if ([thoughsTextFloats count]) {
        [thoughsTextFloats removeAllObjects];
    }
    if ([thoughtsComments count]) {
        [thoughtsComments removeAllObjects];
    }
    
    

      [self performSelector:@selector(parseAroundData) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
//    [self performSelector:@selector(parseThoughtsImageData) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
      [self performSelector:@selector(parsecountdata) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];

    
}

-(void)setdistance:(float)distance
{
    int exponent = (int)distance;
    float mantissa = distance - exponent;

    if(mantissa>0.0f)
    {
        [self.viewController.distanceButton setTitle:[NSString stringWithFormat:@"%.1f KMS",distance] forState:UIControlStateNormal];  
        //distanceValue=[NSString stringWithFormat:@"%.1f KMS",distance];
        //[bottomBarData insertObject:[;
          
        [bottomBarData replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.1f KMS",distance]];
    }
    else 
    {
        [self.viewController.distanceButton setTitle:[NSString stringWithFormat:@"%d KMS",exponent] forState:UIControlStateNormal];
      //  distanceValue=[NSString stringWithFormat:@"%d KMS",exponent]; 
      // [bottomBarData insertObject:[NSString stringWithFormat:@"%d KMS",exponent] atIndex:1];
        [bottomBarData replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d KMS",exponent]];
    }
}

-(void)setLocation:(NSString*)Location
{
    [self.viewController.locationButton setTitle:Location forState:UIControlStateNormal];
}

-(void)clearArray
{
    [self.viewsArray removeAllObjects];
}

-(void)getData:(NSMutableArray *)dataarray
{
    dealsRefidArray=[[NSMutableArray alloc] initWithCapacity:1];
    
    if ([dealsData count]) {
        [dealsData removeAllObjects];
    }
    for (NSDictionary *dic in dataarray)
    {
        
        if ([dic objectForKey:@"ExternalSourceId"]!=[NSNull null]) {
            
            for (int i=0; i<[dealsRefidArray count]; i++) {
                if ([[dealsRefidArray objectAtIndex:i] isEqualToString:[dic objectForKey:@"ExternalSourceId"]]) {
                    isDeal=YES;
                    break;
                }
            }
            
            if (isDeal) {
                isDeal=NO;
                
            }
            else {
                
                [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"DealLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"DealLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                [dealsData addObject:dic];
                [dealsRefidArray addObject:[dic objectForKey:@"ExternalSourceId"]];
            }
            
        }
        else {
            [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"DealLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"DealLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
            [dealsData addObject:dic];
            
        }
        
        
        //NSLog(@"dealsdata:%@",dealsData);
        
       
        
            }


    
}
-(void)parseDealsData{
    
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:1]];
    [url release];
    
}

-(void)parseEventsData{
    
    
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:2]];
   
    [url release];
    
    
}

-(void)parseAroundData{
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:3]];
    [url release];
}

-(void)getEventData:(NSMutableArray *)dataarray
{
    if ([eventsData count]) {
        [eventsData removeAllObjects];
    }
  eventsRefidArray=[[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *dic in dataarray)
    {
        
        
    
        if ([dic objectForKey:@""]!=[NSNull null]) {
            
            
            for (int i=0; i<[eventsRefidArray count]; i++) {
                if ([[eventsRefidArray objectAtIndex:i] isEqualToString:[dic objectForKey:@"ExternalSourceId"]]) {
                    isEvent=YES;
                    break;
                }
            }
            
            if (isEvent) {
                isEvent=NO;
                
            }
            else {
                
                
                if ([dic objectForKey:@"Description"]!=[NSNull null]) {
                    NSString *st=[self convertToXMLEntities:[dic objectForKey:@"Description"]];
                    
                    [dic setValue:st forKey:@"Description"];           
                }
                
                
                [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"EventLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"EventLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                [eventsData addObject:dic];
                
                
                
                [eventsRefidArray addObject:[dic objectForKey:@"ExternalSourceId"]];
            }
        }
        else {

            if ([dic objectForKey:@"Description"]!=[NSNull null]) {
                NSString *st=[self convertToXMLEntities:[dic objectForKey:@"Description"]];
                
                [dic setValue:st forKey:@"Description"];           
            }
            
            
            [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"EventLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"EventLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
            [eventsData addObject:dic];
        }
            
    }
    
  
        [self.viewController.eventActivity stopAnimating];
        //[self.viewController.eventsCountLael setText:[NSString stringWithFormat:@"%d",[eventsData count]]];

}

-(void)getStoreFrontData:(NSMutableArray *)dataarray{
    
   
            
            
    for (NSDictionary *dic in dataarray){
//[dic setValue:[self calculteDistanceLatitude:[dic objectForKey:@"lat"]:[dic objectForKey:@"lng"]] forKey:@"CalculateRadius"];
        
        [storeFrontData addObject:dic];
            }
            
    //NSLog(@"Store Fornt data is: %@",storeFrontData);    
        
}

-(void)parseStoreFrontData{
   // NSMutableData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"floatingPoints" ofType:@"xml"]];
    Parser *m_parse = [[Parser alloc] init];
    [m_parse setSelectedView:3];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [m_parse setParent:del];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    [arr addObject:@"Name"];
  
}

-(void)getArrounData:(NSMutableArray *)dataarray
{
   [aroundData removeAllObjects];
    
    for (NSDictionary *dic in dataarray)
    {
        [dic setValue:[self calculteDistanceLatitude:[dic objectForKey:@"lat"]:[dic objectForKey:@"lng"]] forKey:@"CalculateRadius"];
    
        [aroundData addObject:dic];
        
    }
    
    NSLog(@"around data:%@",aroundData);
    
    
   if ([aroundData count]) {

    NSString *st=[[aroundData objectAtIndex:0] objectForKey:@"Name"];
    st=[st uppercaseString];
  

    
        [self.viewController.aroundYouLabel setText:st];
   
        selectedArondValue=0;
   
        [self.viewController.rightNowButton setUserInteractionEnabled:YES];
        NSString *subString=[[aroundData objectAtIndex:0] objectForKey:@"Address"];
       
            
       if ([subString isEqual:[NSNull null]])
       {
           [self.viewController.rightNowLabel setText:@""];
       }
       else
       {
       NSString *st1=[NSString stringWithFormat:@"%@",[[subString componentsSeparatedByString:@","] objectAtIndex:0]];
        st1=[st1 uppercaseString];
        [self.viewController.rightNowLabel setText:st1];
       }
       
       [bottomBarData replaceObjectAtIndex:0 withObject:st];
        [self.viewController.locationButton.titleLabel setText:st];
        //[self.viewController.locationButton setFrame:self.viewController.locationButton.frame];
        [self arrangeHomeBottomBar:bottomBar];


   }
}

-(void)parseThoughtsData{
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:4]];
    [url release];
}

-(void)getThoughData:(NSMutableArray *)dataarray
{
    if (IsFromEditController)
    {
        if([thoughtsOwnerDetails count])
        {
            [thoughtsOwnerDetails removeAllObjects];
        }
        //IsFromEditController=NO;
    }
    
    
    for (NSDictionary *dic in dataarray)
    {
       [thoughtsOwnerDetails addObject:dic];
        
    }
}

-(void)getThoughTextFloatData:(NSMutableArray *)dataarray
{
   
    if (IsFromEditController)
    {
        if ([thoughsTextFloats count])
        {
            [thoughsTextFloats removeAllObjects];
            [thoughtsComments removeAllObjects];
        }
        IsFromEditController=NO;

    }
    
    for (NSDictionary *dic in dataarray)
    {

        if ([[dic objectForKey:@"AirCount"] intValue])
        {
            BOOL isAired;
            isAired=NO;
           
            for (int i=0; i<[[dic objectForKey:@"AirUserIds"] count]; i++)
            {
            
                if ([[[dic objectForKey:@"AirUserIds"] objectAtIndex:i] isEqualToString:[userDetails stringForKey:@"_id"]]) {
                    isAired=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isAired] forKey:@"isAired"];
        }
        
        
        
        else
        {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isAired"];
        }
        if ([[dic objectForKey:@"SinkCount"] intValue]) {
            BOOL isSinked;
            isSinked=NO;
           
            for (int i=0; i<[[dic objectForKey:@"SinkUserIds"] count]; i++) {
                
                if ([[[dic objectForKey:@"SinkUserIds"] objectAtIndex:i] isEqualToString:[userDetails stringForKey:@"_id"]]) {
                    isSinked=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isSinked] forKey:@"isSinked"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isSinked"];
        }
        [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"FloatLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"FloatLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
        [thoughsTextFloats addObject:dic];
       
            
           
    [self performSelector:@selector(parseThoughtsCommentData:) onThread:[NSThread currentThread] withObject:dic waitUntilDone:YES];
       
    }
   
    [self.viewController.thoughtActivity stopAnimating];
    
//[self.viewController.thoughtsCountLabel setText:[NSString stringWithFormat:@"%d",[thoughsTextFloats count]]];
    
    
}

-(void)parseThoughtsCommentData:(NSMutableDictionary *)dic{
    
    UrlInfo *url=[[UrlInfo alloc] init];
    commentVal++;
    [url setDic:dic];
    //[url setDictionary:dic];
   
    
    [url parseData:[NSNumber numberWithInt:5]];
    [url setNumb:2];
    //[url setCommentVal:2];
    
    
    
    [url release];
    
}

-(void)getThoughtsComment:(NSMutableArray *)dataarray
{
   [thoughtsComments addObject:dataarray];
    
}

-(void)parseThoughtsImageData{
    
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:6]];
    [url release];
    
}

-(void)getThoughtsImageData:(NSMutableArray *)dataarray
{

    
//    if ([thoughsImageFloats count]) {
//        [thoughsImageFloats removeAllObjects];
//    }
   
    for (NSDictionary *dic in dataarray)
    {
        if ([[dic objectForKey:@"AirCount"] intValue]) {
            BOOL isAired;
            isAired=NO;
            for (int i=0; i<[[dic objectForKey:@"AirUserIds"] count]; i++) {
                
                if ([[[dic objectForKey:@"AirUserIds"] objectAtIndex:i] isEqualToString:[userDetails stringForKey:@"_id"]]) {
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
                
                if ([[[dic objectForKey:@"SinkUserIds"] objectAtIndex:i] isEqualToString:[userDetails stringForKey:@"_id"]]) {
                    isSinked=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isSinked] forKey:@"isSinked"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isSinked"];
        }
         [dic setValue:[self calculteDistanceLatitude:[[dic objectForKey:@"FloatLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"FloatLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
        [thoughsImageFloats addObject:dic];
       // [self performSelector:@selector(parseImageComments:) onThread:[NSThread currentThread] withObject:dic waitUntilDone:YES];
        
    }
    
   
    
    
}

-(void)getImageOwnerDetails:(NSMutableArray *)dataarray
{
    
    [imgaethoughtOwnerDetails addObjectsFromArray:dataarray];
    
}

-(NSString *)calculteDistanceLatitude:(NSString *)latitude2 :(NSString *)longitude2{
    CLLocationDistance distance = [self calculteDistanceFromCurrentLocation:latitude2 : longitude2];
    float dis=distance/1000;
    
    NSString *st=[NSString stringWithFormat:@"%f",dis];
    [st substringToIndex:3];
    return  st;
}

-(CLLocationDistance)calculteDistanceFromCurrentLocation:(NSString *)latitude2 :(NSString *)longitude2{
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[locationArray objectAtIndex:0] floatValue] longitude:[[locationArray objectAtIndex:1] floatValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[latitude2 floatValue]longitude:[longitude2 floatValue]];
    
    return [locA distanceFromLocation:locB];
}

-(NSString * )convertToXMLEntities:(NSString * )myString {
    NSMutableString * temp = [myString mutableCopy];
    
    [temp replaceOccurrencesOfString:@"&amp;"
                          withString:@"&"
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&lt;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&gt;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&quot;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&apos;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&nbsp;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"&rsquo;"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"<br />"
                          withString:@""
                             options:0
                               range:NSMakeRange(0, [temp length])];
   
     
    
    return [temp autorelease];
}

- (NSString *)plainHtmle:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

-(BOOL)reloadAfterErrorScreen;
{

    return YES;
}

-(EditController *)EditButtonClicked:(id)sender
{
  
    
    EditController *m_EditController;
    if(!isEditButtonSelected)
    {
        
        m_EditController = [[EditController alloc] initWithNibName:@"EditController" bundle:nil];
        
        [m_EditController.view setFrame:CGRectMake(0, 0, 320, 410)];
        
        
        if([viewsArray count]>0)
        {
            [self clearArray];
        }
        
        [viewsArray addObject:m_EditController.view];
       
        isEditButtonSelected = YES;
    }
     return m_EditController;
}

-(void)parsecountdata;
{
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:99]];
    [url release];
    
   
}

-(void)parsecdata:(NSMutableDictionary *)datadic;
{    
    countingdic=[datadic mutableCopy];
    [self.viewController.thoughtsCountLabel setText:[NSString stringWithFormat:@"%@",[countingdic objectForKey:@"Txt"]]];
    textCount=[[countingdic objectForKey:@"Txt"] intValue];
    [self.viewController.thoughtActivity stopAnimating]; 
    [self.viewController.eventsCountLael setText:[NSString stringWithFormat:@"%@",[countingdic objectForKey:@"Evt"]]];
    eventCount=[[countingdic objectForKey:@"Evt"] intValue];
    [self.viewController.eventActivity stopAnimating];
    [self.viewController.dealsCountlabel setText:[NSString stringWithFormat:@"%@",[countingdic objectForKey:@"Deal"]]];
    dealCount=[[countingdic objectForKey:@"Deal"] intValue];
    [self.viewController.dealActivity stopAnimating];
    
}

-(void)arrangeHomeBottomBar:(UIScrollView *)sc{
    UIFont *fontNa=[UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    UIButton *editButton=(UIButton *) [sc viewWithTag:1];
    UIView *radiusLine=[sc viewWithTag:2];
    UIButton *distanceButton=(UIButton *) [sc viewWithTag:3];
    [distanceButton.titleLabel setFont:fontNa];
    UIView *locationLine=[sc viewWithTag:4];
    
    UIButton *locationButton=(UIButton *) [sc viewWithTag:5];
    [locationButton.titleLabel setFont:fontNa];
    [distanceButton setTitle:[bottomBarData objectAtIndex:1] forState:UIControlStateNormal];
    [locationButton setTitle:[bottomBarData objectAtIndex:0] forState:UIControlStateNormal];
    
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
            
            for (UIView *v in sc.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]) {
                    [v removeFromSuperview];
                }
            }
            if ([locationButton.titleLabel.text length]<27) {
                [locationButton setFrame:CGRectMake(locationLine.frame.origin.x-205, 7, 200, 38)];
                
            }
            
            else{
                MarqueeLabel *continuousLabel2 ;
                [locationButton setHidden:YES];
                
                continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(locationLine.frame.origin.x-176, 16, 171, 20) rate:50.0f andFadeLength:10.0f];
                
                
                continuousLabel2.marqueeType = MLContinuous;
                // continuousLabel2.continuousMarqueeSeparator = @"  |SEPARATOR|  ";
                continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
                continuousLabel2.numberOfLines = 1;
                //continuousLabel2.opaque = YES;
                //continuousLabel2.enabled = YES;
                continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
                continuousLabel2.textAlignment = UITextAlignmentRight;
                continuousLabel2.textColor = [UIColor colorWithRed:255/255.0  green:165/255.0 blue:10/255.0 alpha:1.000];
                continuousLabel2.backgroundColor = [UIColor clearColor];
                continuousLabel2.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.000];
                continuousLabel2.text = locationButton.titleLabel.text;
                [sc addSubview:continuousLabel2];
            }

            
        }
    }
}

-(void)arrangeBottomButtons:(UIScrollView *)sc{
 
    UIFont *fontNa=[UIFont fontWithName:@"HelveticaNeue-Bold" size:10];

        UIButton *editButton=(UIButton *) [sc viewWithTag:1];
        UIView *radiusLine=[sc viewWithTag:2];
        UIButton *distanceButton=(UIButton *) [sc viewWithTag:3];
        UIView *locationLine=[sc viewWithTag:4];
        UIButton *locationButton=(UIButton *) [sc viewWithTag:5];
    [distanceButton.titleLabel setFont:fontNa];
    [locationButton.titleLabel setFont:fontNa];
        [distanceButton setTitle:[bottomBarData objectAtIndex:1] forState:UIControlStateNormal];
        [locationButton setTitle:[bottomBarData objectAtIndex:0] forState:UIControlStateNormal];
        
        for (int i1=0; i1<3; i1++) {
            if (i1==0) {
                [editButton setFrame:CGRectMake(540, 7, 29, 38)];
                [radiusLine setFrame:CGRectMake(editButton.frame.origin.x-6, 20, 1, 12)];
                [editButton removeFromSuperview];
                [radiusLine removeFromSuperview];
            }
            else if(i1==1){
                
                [distanceButton setFrame:CGRectMake(535, 7, 40, 38)];
                
                
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
                
              // [locationButton setFrame:CGRectMake(locationLine.frame.origin.x-205, 7, 200, 38)];
               
                for (UIView *v in sc.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]) {
                        [v removeFromSuperview];
                    }
                }
                if ([locationButton.titleLabel.text length]<32) {
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
                    //continuousLabel2.opaque = YES;
                    //continuousLabel2.enabled = YES;
                    continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
                    continuousLabel2.textAlignment = UITextAlignmentRight;
                    continuousLabel2.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
                    continuousLabel2.backgroundColor = [UIColor clearColor];
                    continuousLabel2.font = fontNa;
                    continuousLabel2.text = locationButton.titleLabel.text;
                    [sc addSubview:continuousLabel2];
                }
                
                
            }
        }
    
    
    
}

-(void)arrangeSettingsBottomButtons:(UIScrollView *)sc{
    
    UIButton *editButton=(UIButton *) [sc viewWithTag:11];
    UIView *radiusLine=[sc viewWithTag:12];
    UIButton *distanceButton=(UIButton *) [sc viewWithTag:13];
    UIView *locationLine=[sc viewWithTag:14];
    UIButton *locationButton=(UIButton *) [sc viewWithTag:15];
    [distanceButton setTitle:[bottomBarData objectAtIndex:1] forState:UIControlStateNormal];
    [locationButton setTitle:[bottomBarData objectAtIndex:0] forState:UIControlStateNormal];
    UIFont *fontNa=[UIFont fontWithName:@"HelveticaNeue-Bold" size:10];

    [distanceButton.titleLabel setFont:fontNa];
    [locationButton.titleLabel setFont:fontNa];
    [distanceButton setTitle:[bottomBarData objectAtIndex:1] forState:UIControlStateNormal];
    [locationButton setTitle:[bottomBarData objectAtIndex:0] forState:UIControlStateNormal];
    
    for (int i1=0; i1<3; i1++)
    {
        if (i1==0)
        {
            [editButton setFrame:CGRectMake(540, 7, 29, 38)];
            [radiusLine setFrame:CGRectMake(editButton.frame.origin.x-6, 20, 1, 12)];
            [editButton removeFromSuperview];
            [radiusLine removeFromSuperview];
        }
        else if(i1==1){
            
            [distanceButton setFrame:CGRectMake(535, 7, 40, 38)];
            
            
        }
        else if(i1==2)
        {
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
            
            // [locationButton setFrame:CGRectMake(locationLine.frame.origin.x-205, 7, 200, 38)];
            
            for (UIView *v in sc.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]) {
                    [v removeFromSuperview];
                }
            }
            if ([locationButton.titleLabel.text length]<32) {
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
                //continuousLabel2.opaque = YES;
                //continuousLabel2.enabled = YES;
                continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
                continuousLabel2.textAlignment = UITextAlignmentRight;
                continuousLabel2.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
                continuousLabel2.backgroundColor = [UIColor clearColor];
                continuousLabel2.font = fontNa;
                continuousLabel2.text = locationButton.titleLabel.text;
                [sc addSubview:continuousLabel2];
            }
            
            
        }
    }

}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;
{
    NSDate* locationDate = newLocation.timestamp;
    newlatitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    newlongitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    

  
  
    if(!self->firstCallInitiated && locationDate > self->appStartTimestamp)
    {
        self->firstCallInitiated = 1;
        [locationArray replaceObjectAtIndex:0 withObject:newlatitude];
        [locationArray replaceObjectAtIndex:1 withObject:newlongitude];

        //17.421142,78.447254
        
//        [locationArray replaceObjectAtIndex:0 withObject:@"17.421094"];
//        [locationArray replaceObjectAtIndex:1 withObject:@"78.447661"];

        
        //17.42495,78.43223 banjara hills
        //17.376853,78.299535 gandipet
        //42.037054,43.439529 georgia
        
        [self downloadData];
    }
    else if(locationDate > self->appStartTimestamp && [self calculteDistanceFromCurrentLocation:newlatitude :newlongitude] > 200)
    {
        
        [locationArray replaceObjectAtIndex:0 withObject:newlatitude];
        [locationArray replaceObjectAtIndex:1 withObject:newlongitude];

        
//        [locationArray replaceObjectAtIndex:0 withObject:@"17.421094"];
//        [locationArray replaceObjectAtIndex:1 withObject:@"78.447661"];

        
        [self downloadData];
        
    }
    
    
    [dealsData removeAllObjects];
    //[eventsData removeAllObjects];
    [thoughsTextFloats removeAllObjects];
}

//For DATE
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
@end
