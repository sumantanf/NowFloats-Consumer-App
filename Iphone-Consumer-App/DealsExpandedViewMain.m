//
//  DealsExpandedViewMain.m
//  NowFloatsv1
//
//  Created by pravasis on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DealsExpandedViewMain.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "MarqueeLabel.h"
#import "JSON.h"
#import "DealsViewController.h"
#import "LoginViewController.h"

@implementation DealsExpandedViewMain

@synthesize dic;
@synthesize dealsTableview;


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

- (IBAction)saveButtonClicked:(id)sender {
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Uh-Oh!" message:@"Save your deal coming soon." delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}

-(IBAction)clickedOnDeals:(id)sender
{
    dealsImagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [dealsImagesArray addObject:[NSString stringWithFormat:@"https://api.withfloats.com%@",[dic objectForKey:@"TileImageUri"]]];
    [dealsImagesArray addObject:[NSString stringWithFormat:@"https://api.withfloats.com%@",[dic objectForKey:@"TileImageUri"]]];
    [dealsImagesArray addObject:[NSString stringWithFormat:@"https://api.withfloats.com%@",[dic objectForKey:@"TileImageUri"]]];
    
    m_dealsExpanded = [[DealsExpandedView alloc] initWithNibName:@"DealsExpandedView" bundle:nil];

    [m_dealsExpanded setDic:dic];
    [m_dealsExpanded setDealsTitleLabelText:[dic objectForKey:@"Title"]];
    [m_dealsExpanded setDealsTitleString:[dic objectForKey:@"MerchantName"]];
    [m_dealsExpanded setDealsImagesArray:dealsImagesArray];
    
    [self.view addSubview:m_dealsExpanded.view];

}

-(IBAction)removeView:(id)sender
{
    [imageHoldView removeFromSuperview];
}

-(IBAction)catchTheDeal:(id)sender;
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dic objectForKey:@"DealUri"]]];
}
-(IBAction)merchantNameButtonClicked:(id)sender;
{
   
    [self deallocateForStoreController];
    NSMutableDictionary *dealDic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dealDic setObject:[dic objectForKey:@"DealLocationName"] forKey:@"Address"];
    [dealDic setObject:[dic objectForKey:@"CalculateRadius"] forKey:@"CalculateRadius"];
    [dealDic setObject:[dic objectForKey:@"MerchantName"] forKey:@"Name"];
    [dealDic setObject:[NSNull null] forKey:@"Timings"];
    [dealDic setObject:[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"] forKey:@"lat"];
    [dealDic setObject:[[dic objectForKey:@"DealLocation"] objectForKey:@"longitude"] forKey:@"lng"];
    [dealDic setObject:[dic objectForKey:@"TileImageUri"] forKey:@"ImageUri"];
    //[dealDic setObject:[dic objectForKey:@"MerchantName"] forKey:@"imageVal"];
    
    storeViewController=[[StoreFrontViewController alloc] initWithNibName:@"StoreFrontViewController" bundle:nil];
    [storeViewController setDictionary:dealDic];
    [self.view addSubview:storeViewController.view];
    
    [dealDic release];
}
-(IBAction)mapButtonClicked:(id)sender{
    
    StoreViewMap *map=[[StoreViewMap alloc] initWithNibName:@"StoreViewMap" bundle:nil];
    [map setLatitudeValue:[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"]];
 
    [map setLatitudeValue:[[dic objectForKey:@"DealLocation"] objectForKey:@"longitude"]];
    [self.view addSubview:map.view];

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    hideMessages=[[NSMutableArray alloc] initWithObjects:@"Uninteresting",@"Misleading",@"Sexually explicit",@"Against my views",@"Offensive",@"Repetitive",@"Other", nil];
  


   appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate arrangeBottomButtons:bottomNewBar];
    for (UIView *v in bottomNewBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:0.686 green:0.764 blue:0.019 alpha:1.000];
            break;
        }
        
    }

    // Do any additional setup after loading the view from its nib.
    
 //   UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
    
    [bottomNewBar setContentSize:CGSizeMake(580, 50)];

    
    [dealsLocationLabel setText:[[NSString stringWithFormat:@"        %@",[dic objectForKey:@"MerchantName"]] uppercaseString]];
    

    [lbltitlebg.layer setCornerRadius:5];
    [dealsLocationLabel.layer setCornerRadius:5];
    [descriptionBackgroundLabel.layer setCornerRadius:5];
    [dealsCatchButton.layer setCornerRadius:5];
    [pointerBackground.layer setCornerRadius:5];
    [dealsTitleLabel setText:[dic objectForKey:@"Title"]];
    
    //Date Calculating
    NSDate *date1=[[NSDate alloc] init];
    NSDate *date2 ;
    NSString *dateString=[dic objectForKey:@"DealEndDate"];
   
    
    
    if ([dateString hasPrefix:@"/Date("])
    {
        dateString=[dateString substringFromIndex:6];
        dateString=[dateString substringToIndex:[dateString length]-8];
        date2=[NSDate dateWithTimeIntervalSinceNow:[dateString integerValue]];
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   
    
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int numberOfDays = secondsBetween / 86400;
    [dateLaebel setText:[NSString stringWithFormat:@"%d",numberOfDays]];
    
    compass=[[CompassViewController alloc] init];
    [compass setCompassImage:pointerView];
    [compass setLat:[[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"] floatValue]];
    [compass setLng:[[[dic objectForKey:@"DealLocation"]objectForKey:@"longitude"] floatValue]];
    
    [compass rotateImage];
    

    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[appDelegate.locationArray objectAtIndex:0] floatValue] longitude:[[appDelegate.locationArray objectAtIndex:1] floatValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"]floatValue]longitude:[[[dic objectForKey:@"DealLocation"] objectForKey:@"longitude"]floatValue]];
   
   CLLocationDistance distance = [locA distanceFromLocation:locB];
  
    float dis=distance/1000;
    
    NSString *st;
    
    //Distance in Meters
    
    if (dis<1) {
        st=@"Here";

        [distanceLabel setText:st];
    }
    else{
        st =[NSString stringWithFormat:@"%f",dis];

        [distanceLabel setText:[NSString stringWithFormat:@"%@ K.M",[st substringToIndex:3]]];

    }
    

}

-(IBAction)goBack:(id)sender
{
    
    AppDelegate *m_appDel =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    [[m_appDel.viewsArray objectAtIndex:[m_appDel.viewsArray count]-1] removeFromSuperview];
    [m_appDel.viewsArray removeObjectAtIndex:[m_appDel.viewsArray count]-1];
    [dealsTableview reloadData];
    [self deallocate];

}

-(IBAction)share:(id)sender
{
    if(!isShareButtonClicked)
    {
        shareView = [[UIView alloc] initWithFrame:CGRectMake(41, 171, 248,237)];
        [shareView setBackgroundColor:[UIColor blackColor]];
        isShareButtonClicked = YES;
        
        UIImageView *tweetimgView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 30, 50, 50)];
        [tweetimgView setImage:[UIImage imageNamed:@"tweet.png"]];
        [tweetimgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:tweetimgView];
        [tweetimgView release];
        
        UIImageView *centerLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(124, 0, 1, 237)];
        UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
        [centerLineImgView setBackgroundColor:color];
        [shareView addSubview:centerLineImgView];
        [centerLineImgView release];
        
        UIImageView *centerLineImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 118, 248, 1)];
        [centerLineImgView2 setBackgroundColor:color];
        [shareView addSubview:centerLineImgView2];
        [centerLineImgView2 release];
        
        UILabel *shareBackgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 104, 60, 28)];
        [shareBackgroundLabel setBackgroundColor:color];
        [shareView addSubview:shareBackgroundLabel];
        [shareBackgroundLabel release];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 102, 70, 28)];
        [shareLabel setText:@"share"];
        [shareLabel setFont:[UIFont systemFontOfSize:17]];
        [shareLabel setTextAlignment:UITextAlignmentCenter];
        [shareLabel setBackgroundColor:[UIColor clearColor]];
        [shareLabel setTextColor:[UIColor whiteColor]];
        [shareView addSubview:shareLabel];
        [shareLabel release];
        
        UIImageView *fbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(161, 30, 50, 50)];
        [fbImgView setImage:[UIImage imageNamed:@"fb.png"]];
        [fbImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:fbImgView];
        [fbImgView release];
        
        UIImageView *mailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 152, 43, 32)];
        [mailImgView setImage:[UIImage imageNamed:@"email.png"]];
        [mailImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:mailImgView];
        [mailImgView release];
        
        UIImageView *smslImgView = [[UIImageView alloc] initWithFrame:CGRectMake(161, 152, 50, 50)];
        [smslImgView setImage:[UIImage imageNamed:@"sms.png"]];
        [smslImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:smslImgView];
        [smslImgView release];
        
        [self.view addSubview:shareView];
    }
}

-(IBAction)gotoHomePage:(id)sender
{
    [self deallocate];
    [self.view removeFromSuperview];
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for(int i=0;i<[m_appDel.viewsArray count];i++)
    {
        [[m_appDel.viewsArray objectAtIndex:i] removeFromSuperview];
    }
    [m_appDel.viewsArray removeAllObjects];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

    
}

- (void)viewDidUnload
{
    [lbltitlebg release];
    lbltitlebg = nil;
    [lblday release];
    lblday = nil;
    [dayimg release];
    dayimg = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)hideButtonClicked:(id)sender{
    
  /*  NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:@"_id"]) {
        NSString *hideVal=[NSString stringWithFormat:@"hide_%@",[user objectForKey:@"_id"]];
        
    
        if ([user objectForKey:hideVal]) {
            
            
            NSMutableArray *dealHideArray=[[user objectForKey:hideVal] mutableCopy];
            [dealHideArray addObject:[dic objectForKey:@"_id"]];
            [user setObject:dealHideArray forKey:hideVal];
            [user synchronize];
        }
        else{
            NSMutableArray *dealHideArray=[[NSMutableArray alloc] initWithCapacity:1];
            [dealHideArray addObject:[dic objectForKey:@"_id"]];
            [user setObject:dealHideArray forKey:hideVal];
            [user synchronize];
        }
                
    }
    else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }*/
    
    [pickerView setHidden:NO];
   
}

-(IBAction)mapKitButtonClicked:(id)sender{
    
   // AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],[[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"] floatValue],[[[dic objectForKey:@"DealLocation"] objectForKey:@"longitude"] floatValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];
    
  
    
}
#pragma UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [hideMessages count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [hideMessages objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    [userDefaults setObject:[NSString stringWithFormat:@"%d",row] forKey:@"selectedIndex"];
    CurrentVal=row;
}

-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES];
}

-(IBAction)done:(id)sender
{
   [pickerView setHidden:YES];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
        
    //AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/reportabuse/deal?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A&uid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]];
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc] initWithCapacity:1];
    //[dic setValue:@"5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A" forKey:@"clientId"];
    [dic1 setValue:[dic objectForKey:@"_id"] forKey:@"floatId"];
    [dic1 setValue:[hideMessages objectAtIndex:CurrentVal]  forKey:@"reason"];
    [dic1 setValue:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:0] floatValue]] forKey:@"lat"];
    [dic1 setValue:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:1] floatValue]] forKey:@"lng"];
    
    
        NSString *urlTo=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:urlTo];
      //  NSLog(@"url is: %@",url);
    NSString *newurlString=[dic1 JSONRepresentation];
    NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
        
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
       

    NSURLConnection *theConnection;
    
    theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        [dic1 release];
        

        
    }
    else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }

    

    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex==1) {
        
        LoginViewController *loginVi=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:loginVi.view];
        
    }
}



- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    if (code==200)
    {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        
        
            NSString *hideVal=[NSString stringWithFormat:@"hide_%@",[user objectForKey:@"_id"]];
            
            
            if ([user objectForKey:hideVal]) {
                
                
                NSMutableArray *dealHideArray=[[user objectForKey:hideVal] mutableCopy];
                [dealHideArray addObject:[dic objectForKey:@"_id"]];
                [user setObject:dealHideArray forKey:hideVal];
                [user synchronize];
                [dealHideArray release];
            }
            else{
                NSMutableArray *dealHideArray=[[NSMutableArray alloc] initWithCapacity:1];
                [dealHideArray addObject:[dic objectForKey:@"_id"]];
                [user setObject:dealHideArray forKey:hideVal];
                [user synchronize];
                [dealHideArray release];
            }
        
        [appDelegate.dealRef readDealsInfo];
        [dealsTableview reloadData];
        
        
        
        [self goBack:self];
        [dealsTableview reloadData];

            
        }
    
}

-(void)deallocate
{

    [compass release];
    [lbltitlebg release];
    [lblday release];
    [dealsLocationLabel release];
    [descriptionBackgroundLabel release];
    [dealsTitleLabel release];
    [dealsCatchButton release];
    [pointerBackground release];
    [dealsImageViews release];
    [imageHoldView release];
    [shareView release];
    [m_dealsExpanded release];
    [dateLaebel release];
    [distanceLabel release];
    [pointerView release];
    //[storeViewController release];
    [hideMessages release];
    [pickerView release];
    [dic release];

    
}

- (void)dealloc {
    
    
    
    
    [compass release];
    [lbltitlebg release];
    [lblday release];
    [dealsLocationLabel release];
    [descriptionBackgroundLabel release];
    [dealsTitleLabel release];
    [dealsCatchButton release];
    [pointerBackground release];
    [dealsImageViews release];
    [imageHoldView release];
    [shareView release];
    [m_dealsExpanded release];
    [dateLaebel release];
    [distanceLabel release];
    [pointerView release];
    [storeViewController release];
    [hideMessages release];
    [pickerView release];
    [dic    release];
    [super dealloc];
}



-(void)deallocateForStoreController
{
      //[compass release];
//    [lbltitlebg release];
//    [lblday release];
//    [dealsLocationLabel release];
//    [descriptionBackgroundLabel release];
//    [dealsTitleLabel release];
//    [dealsCatchButton release];
//    [pointerBackground release];
//    [dealsImageViews release];
//    [imageHoldView release];
//    [shareView release];
//    [m_dealsExpanded release];
//    [dateLaebel release];
//    [distanceLabel release];
//    [pointerView release];
//    [hideMessages release];
//    [pickerView release];
//    [super dealloc];


}
@end
