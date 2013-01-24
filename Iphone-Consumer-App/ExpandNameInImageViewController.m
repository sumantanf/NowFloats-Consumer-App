//
//  ExpandNameInImageViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandNameInImageViewController.h"
#import "CompassViewController.h"
#import "JSON.h"
@interface ExpandNameInImageViewController ()

@end

@implementation ExpandNameInImageViewController
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view removeFromSuperview];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"Thougths DIC:%@",thoughtsDic);
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [pickerView setHidden:YES];
    
    hideMessages=[[NSMutableArray alloc] initWithObjects:@"Personal attacks or alleged defamation",@"Parody or satire of individuals",@"Distasteful language",@"Political/Religious commentary", nil];
    
    
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
        [daysLabel setText:[NSString stringWithFormat:@"%d days ago",days,hrstemp]];
    }
    else 
    {
        [daysLabel setText:[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
    }
    
    // Do any additional setup after loading the view from its nib.
    
    //Calculateing Distance
    
    AppDelegate *appDelegate=(AppDelegate  *)[[UIApplication sharedApplication] delegate];
    
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
    
    
    CompassViewController *compass=[[CompassViewController alloc] init];
    [compass setCompassImage:pointerView];
    [compass setLat:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"latitude"]floatValue]];
    [compass setLng:[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"longitude"]floatValue]];
    
    [compass rotateImage];
    
    
    
    if ([[thoughtsDic objectForKey:@"OwnerId"] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"_id"]]) {
        [deleteImage setHidden:NO];
        [deleteImage setFrame:CGRectMake(69, 6, 12, 16)];
        [deleteLabel setFrame:CGRectMake(90, 4, 126, 21)];
        
        [deleteLabel setText:@"DELETE THIS THOUGHT"];
    }
    else{
        
        [deleteImage setFrame:CGRectMake(34, 8, 20, 14)];
        [deleteLabel setFrame:CGRectMake(63, 4, 180, 21)];
        
        [deleteImage setImage:[UIImage imageNamed:@"iPhone Thoughts eye.png"]];
        [deleteLabel setText:@"REPORT INAPPORPRIATE CONTENT"];
    }
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
-(IBAction)mapKitButtonClicked:(id)sender{
    //[mapImage setHidden:YES];
    
   appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"latitude"] floatValue],[[[thoughtsDic objectForKey:@"FloatLocation"] objectForKey:@"longitude"] floatValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];
    

    
}

-(IBAction)DeleteButtonClicked:(id)sender
{
    
    if ([[thoughtsDic objectForKey:@"OwnerId"] isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"_id"]])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"OMG" message:@"Do you really want to remove this image float?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes,I do", nil];
        alert.tag=1;
        [alert show];
        [alert release];
    }
    else{
        
        
        UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:@"OMG" message:@"Do you really want to report this image float?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes,I do", nil];
        alert1.tag=2;
        [alert1 show];
        [alert1 release];
        
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
    
    [[self.view superview] sendSubviewToBack:self.view];
    
    [pickerView setHidden:YES];
}

-(IBAction)done:(id)sender
{
    [[self.view superview] sendSubviewToBack:self.view];
    
    [pickerView setHidden:YES];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])
    {
        isReport=2;
        //AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/reportabuse/image?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A"];
        
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
        NSLog(@"thre req: %@",request);
        
        NSURLConnection *theConnection;
        
        theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else
    {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }
    
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) 
    {
        if(buttonIndex==1 )
        {
            isReport=1;

            NSString *passWord=[NSString stringWithFormat:@"\"%@\"",[thoughtsDic objectForKey:@"_id"]];
            
            NSString *post = [[NSString alloc] initWithFormat:@"%@",passWord];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSString *UserNameString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/archive/image?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A"];
            
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
        
        
        if (alertView.tag==2)
        {
            if(buttonIndex==1 )
            {
                [pickerView setHidden:NO];
                [[self.view superview] bringSubviewToFront:self.view];

            }
        }
    
   
        
    
    
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    NSLog(@"code is: %d",code);
    
    
    if (code==200)
    {
        
        if (isReport==1)
        {
            [self deleteImageThought];
        }
        else{
            
            [self reportImageThought];
        }

    }
}

-(void)deleteImageThought
{

    for (int i1=0; i1<[appDelegate.thoughsImageFloats count]; i1++)
    {
        if ([[[appDelegate.thoughsImageFloats objectAtIndex:i1] objectForKey:@"_id"] isEqualToString:[thoughtsDic objectForKey:@"_id"]])
        {
            [appDelegate.thoughsImageFloats removeObjectAtIndex:i1];
            break;
        }
    }
    
    
    [appDelegate.imageScroll reloadInputViews];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];


}



-(void)reportImageThought
{
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *hideVal=[NSString stringWithFormat:@"text_%@",[user objectForKey:@"_id"]];

    if ([user objectForKey:hideVal])
    {
        NSMutableArray *imgHideArray=[[user objectForKey:hideVal] mutableCopy];
        [imgHideArray addObject:[thoughtsDic objectForKey:@"_id"]];
        [user setObject:imgHideArray forKey:hideVal];
        [user synchronize];
    }
    
    else
    {
        NSMutableArray *imgHideArray=[[NSMutableArray alloc] initWithCapacity:1];
        [imgHideArray addObject:[thoughtsDic objectForKey:@"_id"]];
        [user setObject:imgHideArray forKey:hideVal];
        [user synchronize];
    }
    

    
    [appDelegate.imageScroll reloadInputViews];


}


@end
