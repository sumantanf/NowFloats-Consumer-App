//
//  ExpandedNameViewViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandedNameViewViewController.h"

#import "StoreViewMap.h"
#import "JSON.h"

@implementation ExpandedNameViewViewController

@synthesize nameString;
@synthesize dic;
@synthesize thoughtsDic;

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
    [prograssBar stopAnimating];
    
    hideMessages=[[NSMutableArray alloc] initWithObjects:@"Personal attacks or alleged defamation",@"Parody or satire of individuals",@"Distasteful language",@"Political/Religious commentary", nil];

    
    if ([[thoughtsDic objectForKey:@"OwnerId"] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"_id"]]) {
        [deleteImage setHidden:NO];
        [deleteImage setFrame:CGRectMake(69, 6, 12, 16)];
        [deleteLabel setFrame:CGRectMake(90, 4, 126, 21)];

        [deleteLabel setText:@"DELETE THIS THOUGHT"];
    }
    else{
        //[deleteButton setHidden:YES];
        //[deleteImage setHidden:YES];
        [deleteImage setFrame:CGRectMake(34, 8, 20, 14)];
        [deleteLabel setFrame:CGRectMake(63, 4, 180, 21)];

        [deleteImage setImage:[UIImage imageNamed:@"iPhone Thoughts eye.png"]];
        [deleteLabel setText:@"REPORT INAPPORPRIATE CONTENT"];
    }
    
    [nameLabel setText:[dic objectForKey:@"OwnerTag"]];
    [placeLabel setText:[thoughtsDic objectForKey:@"NearByLocationName"]];
    //Image
    
    int avatarId;
    int isMale;
    
    
    avatarId=[[dic objectForKey:@"AvatarImageId"] intValue];
    
    if (avatarId > 6)
        avatarId = avatarId % 7;
    else if (avatarId < 0) {
        avatarId = 0;
    }
    
    isMale=[[dic objectForKey:@"IsMale"] intValue];
    if (isMale) {
        [profileImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
       
    } else {
 
        [profileImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
    }

    //Calculating Date
    
    NSDate *startdate ;
    NSString *dateString=[thoughtsDic objectForKey:@"CreatedOn"];
    
    
    startdate=[self getDateFromJSON:dateString];
    
    NSDate *toDate = [NSDate date]; 
    int k = [startdate timeIntervalSince1970];
    int j = [toDate timeIntervalSince1970];
    
    double X = j-k;
    
    int days = (int)((double)X/(3600*24.0));
    int hrs = (int)X%(3600*24);
    int hrstemp =  hrs/3600;
    
    
    
    if(days > 0)
    {
        if (days==1) {
            [daysLabel setText:[NSString stringWithFormat:@"%d day ago",days]];

        }
        else{
            [daysLabel setText:[NSString stringWithFormat:@"%d days ago",days]];

        }
    }
    else 
    {
        [daysLabel setText:[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
    }

    // Do any additional setup after loading the view from its nib.
    
    //Calculateing Distance
    
   appDelegate=[[UIApplication sharedApplication] delegate];
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[appDelegate.locationArray objectAtIndex:0] floatValue] longitude:[[appDelegate.locationArray objectAtIndex:1] floatValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"latitude"]floatValue]longitude:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"longitude"]floatValue]];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    float dis=distance/1000;
    
    
    
    NSString *st;
    if (dis<1.0) {
        st=@"Here";
        
        [distanceLabel setText:st];
    }
    else{
        st =[NSString stringWithFormat:@"%f",dis];
        
        [distanceLabel setText:[NSString stringWithFormat:@"%@ K.M",[st substringToIndex:3]]];
        
    }
    
    compass=[[CompassViewController alloc] init];
    [compass setCompassImage:pointerView];
    [compass setLat:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"latitude"]floatValue]];
    [compass setLng:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"longitude"]floatValue]];
    
    [compass rotateImage];
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

-(IBAction)goBack:(id)sender{
    
    [self deallocate];
    [self.view removeFromSuperview];

}
-(IBAction)mapKitButtonClicked:(id)sender{
    //[mapImage setHidden:YES];
    
    
    
    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"latitude"] floatValue],[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"longitude"] floatValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];
    
    //    StoreViewMap *storeView=[[StoreViewMap alloc] initWithNibName:@"StoreViewMap" bundle:nil];
    //    [storeView setLatitudeValue:[dictionary objectForKey:@"lat"]];
    //     [storeView setLongitudeValue:[dictionary objectForKey:@"lng"]];
    //    [self.view addSubview:storeView.view];
    
}
-(IBAction)DeleteButtonClicked:(id)sender{
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])
    {
    if ([[thoughtsDic objectForKey:@"OwnerId"] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"_id"]]) {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"OMG" message:@"Do you really want to remove this thought?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes,I do", nil];
    [alert show];
    [alert release];
    }
        else
        {
       
        [pickerView setHidden:NO];
        [[self.view superview] bringSubviewToFront:self.view];
        //[self.view bringSubviewToFront:pickerView];
        }
        
    }
    
     else{
     
         
         UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
         [alertView show];
         [alertView release];
     
     }
    
}
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

    CurrentVal=row;
}

-(IBAction)cancel:(id)sender
{

    
    
    [[self.view superview] bringSubviewToFront:appDelegate.bottomBar];

    [pickerView setHidden:YES];
}

-(IBAction)done:(id)sender
{
    [[self.view superview] bringSubviewToFront:appDelegate.bottomBar];

    [pickerView setHidden:YES];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
        isReport=2;
        //AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/reportabuse/text?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A"];
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc] initWithCapacity:1];
        [dic1 setValue:[thoughtsDic objectForKey:@"_id"] forKey:@"floatId"];
        [dic1 setValue:[hideMessages objectAtIndex:CurrentVal]  forKey:@"reason"];
       
        
        
        
        NSString *urlTo=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url=[NSURL URLWithString:urlTo];
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
    }
    else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==1 )
    {
        isReport=1;
        [prograssBar startAnimating];
        
        NSString *passWord=[NSString stringWithFormat:@"\"%@\"",[thoughtsDic objectForKey:@"_id"]];
        
        NSString *post = [[NSString alloc] initWithFormat:@"%@",passWord];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSString *UserNameString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/archive/text?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A"];
        
        
        NSURL *url = [NSURL URLWithString:UserNameString];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        [theRequest setHTTPMethod:@"PUT"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPBody:postData];
        NSURLConnection *conn;
        conn= [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];

        
    }
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
        if (code==200) {
            
            if (isReport==1)
            {
                [self deleteThought];
            }
            else{
                
                [self reportThought];
            }
           
            
        }
    }

-(void)deleteThought{
    
    [prograssBar stopAnimating];
    
    
    for (int j=0; j<[appDelegate.thoughsTextFloats count]; j++) {
        if ([[[appDelegate.thoughsTextFloats objectAtIndex:j] objectForKey:@"_id"] isEqualToString:[thoughtsDic objectForKey:@"_id"]]) {
            [appDelegate.thoughsTextFloats removeObjectAtIndex:j];
            break;
        }
    }
    [appDelegate.thoughtsTab reloadData];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
}
-(void)reportThought
{
    
    [prograssBar stopAnimating];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *hideVal=[NSString stringWithFormat:@"text_%@",[user objectForKey:@"_id"]];
    
    if ([user objectForKey:hideVal])
    {
        NSMutableArray *dealHideArray=[[user objectForKey:hideVal] mutableCopy];
        [dealHideArray addObject:[thoughtsDic objectForKey:@"_id"]];
        [user setObject:dealHideArray forKey:hideVal];
        [user synchronize];
    }
    
    else
    {
        NSMutableArray *dealHideArray=[[NSMutableArray alloc] initWithCapacity:1];
        [dealHideArray addObject:[thoughtsDic objectForKey:@"_id"]];
        [user setObject:dealHideArray forKey:hideVal];
        [user synchronize];
    }
    
    
    
    
    [appDelegate.thoughtsTab reloadData];
    
    
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
}





-(void)deallocate
{

    [compass release];

}

@end
