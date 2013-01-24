//
//  ThoughtsViewController.m
//  NowFloats_v1
//
//  Created by pravasis on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThoughtsViewController.h"
#import "ThoughtSelectedView.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageGridViewController.h"
#import "NSString+CamelCase.h"
#import "MarqueeLabel.h"
#import "UploadFloat.h"
#import "LoginViewController.h"
#import "CreateFloatViewController.h"

//UIScrollViewDelegate
//UITableView
#define REFRESH_HEADER_HEIGHT 52.0f
//UITableViewDelegate

@implementation ThoughtsViewController
//Table View Refresh Methods
@synthesize refreshHeaderView,refreshLabel,refreshArrow,refreshSpinner,textPull,textRelease,textLoading,isFromFloat,floatDic,pickingImage;


-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES]; 
}

-(IBAction)done:(id)sender
{
    [activityView setHidden:NO];

    [pickerView setHidden:YES];
    data=[[NSMutableData alloc] initWithCapacity:1];
    [pickerView setHidden:YES]; 
    appDelegate.skipByValue=0;
    NSString *sortByName;
    sortByName=[[pickerDataArray objectAtIndex:CurrentVal] lowercaseString];
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/textFloats?lat=%f&lng=%f&radius=%f&skipBy=3&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,sortByName];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLConnection *connection;
    connection =[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    IsFromThought=2;
}

-(IBAction)sort:(id)sender
{
    [pickerView setHidden:NO];
    

    
    [self.view bringSubviewToFront: pickerView];
}

#pragma picker delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [pickerDataArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    
        [(UIView*)[[thePickerView subviews] objectAtIndex:0] setHidden:YES];
    return [[pickerDataArray objectAtIndex:row] uppercaseString];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //[userDefaults setObject:[NSString stringWithFormat:@"%d",row] forKey:@"selectedIndex"];
    CurrentVal=row;
}


//Table View Refresh COmpleted
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    

    
    
    
    [activityView setHidden:YES];
    appDelegate =(AppDelegate* ) [[UIApplication sharedApplication] delegate];

    thoughtsref=[[NSMutableArray alloc] initWithCapacity:0];
    
    [appDelegate setThoughtsTab:thoughtsTable];
    
    if (isFromFloat)
    {
        if ([[floatDic objectForKey:@"isFrom"] intValue]==1)
        {
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc] initWithCapacity:1];
            [dic1 setObject:[floatDic objectForKey:@"float"] forKey:@"FloatMessage"];
            [dic1 setObject:[floatDic objectForKey:@"location"] forKey:@"NearByLocationName"];
            [dic1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"] forKey:@"OwnerId"];
            [dic1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"AvatarId"] forKey:@"AvatarImageId"];
            
            [dic1 setObject:[NSString stringWithFormat:@"Date(%.0f)",[[NSDate date] timeIntervalSince1970]*1000] forKey:@"CreatedOn"];
            [dic1 setObject:[NSNumber numberWithInt:0] forKey:@"AirCount"];
            [dic1 setObject:[NSNumber numberWithInt:0] forKey:@"SinkCount"];
            if ([appDelegate.thoughsTextFloats count])
            {
                [appDelegate.thoughsTextFloats insertObject:dic1 atIndex:0];

            }
            else
            {
                isFromFloat=NO;
//                [appDelegate.thoughsTextFloats addObject:dic1];
//                [self downloadThoughts];
//                [mainBar startAnimating];

            }
            UploadFloat *upload=[[UploadFloat alloc] init];
            [upload uploadTextFloat:[floatDic objectForKey:@"float"]
                        andLocation:[floatDic objectForKey:@"location"]];
        }
        else{
            
            isFromFloat=NO;
            UploadFloat *upload=[[UploadFloat alloc] init];
            [upload uploadImageFloats:pickingImage andText:[floatDic objectForKey:@"float"] andLocation:[floatDic objectForKey:@"location"]];
        }
    }
    latestVale=@"latest";
    [prograssBar stopAnimating];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    btnDeco = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDeco.frame = CGRectMake(0, 15, 280, 20);
    [btnDeco.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    
    if (appDelegate.textCount)
    {
        [btnDeco setTitle:@"Tap here for more juice." forState:UIControlStateNormal];
        
    }
    else
    {
        
        [btnDeco setTitle:@"Please increase your radius to get more thoughts." forState:UIControlStateNormal];
        
    }
    
    if (![appDelegate.thoughsTextFloats count]) {
        [self downloadThoughts];
        [prograssBar stopAnimating];
        [btnDeco setHidden:YES];
        [mainBar startAnimating];
    }
    else
    {
        [mainLabel setHidden:YES];
        [mainBar setHidden:YES];
    }
    
    // btnDeco.backgroundColor = [UIColor clearColor];
    //[btnDeco setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [btnDeco addTarget:self action:@selector(downloadThoughts) forControlEvents:UIControlEventTouchUpInside];

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 50)];
    [footerView addSubview:btnDeco];

    thoughtsTable.tableFooterView=footerView;
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    
    pickerDataArray=[[NSMutableArray alloc] initWithObjects:@"latest",@"nearest", nil];
    
    
    [appDelegate.thoughtsViewArray addObject:self.view];
    color = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1];
   
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    
    }

-(void)saveData{
    
    NSString *reportThougt=[NSString stringWithFormat:@"text_%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]];
    
    NSMutableArray *reportThougtArray=[[[NSUserDefaults standardUserDefaults] objectForKey:reportThougt] mutableCopy];
    if ([reportThougtArray count]) {
        for (int i1=0; i1<[appDelegate.thoughsTextFloats count]; i1++) {
            NSMutableDictionary *dic=[appDelegate.thoughsTextFloats objectAtIndex:i1];
            
            BOOL isReport;
            for (int j=0; j<[reportThougtArray count]; j++) {
                if ([[dic objectForKey:@"_id"] isEqualToString:[reportThougtArray objectAtIndex:j]]) {
                    isReport=YES;
                    break;
                }
                else{
                    isReport=NO;
                }
                
            }
            if (!isReport) {
                [thoughtsref addObject:[appDelegate.thoughsTextFloats objectAtIndex:i1]];
                
            }
        }
    }
    else{
        [thoughtsref removeAllObjects];
        [thoughtsref addObjectsFromArray:appDelegate.thoughsTextFloats];
    }
    
    
    
}

-(NSTimeInterval)getUTCFormateDate{
    
    NSDateComponents *comps = [[NSCalendar currentCalendar]
                               components:NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit
                               fromDate:[NSDate date]];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    
    return [[[NSCalendar currentCalendar] dateFromComponents:comps] timeIntervalSince1970];
}

-(IBAction)goBack:(id)sender
{
    for (int i1=0; i1<[appDelegate.thoughtsViewArray count]; i1++) {
        [[appDelegate.thoughtsViewArray objectAtIndex:i1] removeFromSuperview];
        
    }
    [appDelegate.thoughtsViewArray removeAllObjects];
}

-(IBAction)loadImagesGridView:(id)sender
{
    
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Uh-Ho" message:@"Image Floats coming soon." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [alert show];
//    [alert release];

    ImageGridViewController *grid=[[ImageGridViewController alloc] initWithNibName:@"ImageGridViewController" bundle:nil];
    [appDelegate.thoughtsViewArray addObject:grid.view];
    [self.view addSubview:grid.view];
    
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


#pragma UITableViewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{

    [thoughtsref removeAllObjects];
    
    [self saveData];
//     NSLog(@"thought ref: %d",[thoughtsref count]);
    return [thoughtsref count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 310, 98)];
            [imageView setTag:1];
            [imageView setAlpha:0.5f];
            [cell addSubview:imageView];
            [imageView release];
            
            UILabel *thoughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 235, 50)];
            [thoughtLabel setTag:2];
            [thoughtLabel setNumberOfLines:2];
            [thoughtLabel setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:thoughtLabel];
            [thoughtLabel release];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 78, 230, 22)];
            [nameLabel setTag:3];
            [nameLabel setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:nameLabel];
            [nameLabel release];
            
            UIImageView *imageView_profile = [[UIImageView alloc] initWithFrame:CGRectMake(270, 8, 45 , 45)];
            [imageView_profile setTag:4];
            [imageView_profile setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:imageView_profile];
            [imageView_profile release];
         
}
        
        
    NSMutableDictionary *dic=[thoughtsref objectAtIndex:indexPath.row];
        
        UIImageView *imgView1 = (UIImageView*)[cell viewWithTag:1];
        [imgView1 setImage:[UIImage imageNamed:@"messageBase.png"]];
        
        UILabel *label = (UILabel*)[cell viewWithTag:2];

        [label setBackgroundColor:[UIColor clearColor]];
        
        
        [label setText:[dic objectForKey:@"FloatMessage"]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0f]];
        [label setAlpha:0.4f];

        
        for (int i2=0; i2<[appDelegate.thoughtsOwnerDetails count]; i2++)
        {
            
            if ([[[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"_id"] isEqualToString:[dic objectForKey:@"OwnerId"]])
            
            {
               
                 NSString *personString = [[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"OwnerTag"];
                //[label2 setText:[NSString stringWithFormat:@"%@",personString]];
                
                nameString=[NSString stringWithFormat:@"%@  |",personString];
                
                UIImageView *imgView_profile = (UIImageView*)[cell viewWithTag:4];
                int avatarId;
                
                avatarId=[[[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"AvatarImageId"] intValue];
                if (avatarId > 6)
                    avatarId = avatarId % 7;
                else if (avatarId < 0) {
                    avatarId = 0;
                }
                int isMale;
                isMale=[[[appDelegate.thoughtsOwnerDetails objectAtIndex:i2] objectForKey:@"IsMale"] intValue];
                if (isMale)
                {
                    [imgView_profile setImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]]];
                } else {
                    [imgView_profile setImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]]];
                }
                
                //[imgView_profile setBackgroundColor:color];
                
                UILabel *timeLabel = (UILabel*)[cell viewWithTag:5];
                [timeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];  //Machi,HN75Bold,HN55Roman are working and HN77ConBold,GothamMd are not working
                [timeLabel setAlpha:0.6f];
                
                //Date Calculating
                
                NSDate *startdate ;
                NSString *dateString=[dic objectForKey:@"CreatedOn"];
                
                
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

                }
                
                
                break;
            }
            
            
        }


    UILabel *label2 = (UILabel*)[cell viewWithTag:3];
   
    [label2 setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
    [label2 setAlpha:0.6f];
    
    if (indexPath.row==0) {
        if(!isFromFloat){
            [redDotImage removeFromSuperview];
        }
    }
    
    if (isFromFloat && indexPath.row==0) {
        [redDotImage setFrame:CGRectMake(25, 78, 20 , 20)];
        
        [cell addSubview:redDotImage];
        [label2 setText:@"      Patience young one........uploading"];

    }
    else{

         nameString=[NSString stringWithFormat:@"%@  %@",nameString,[dic objectForKey:@"NearByLocationName"]];
        [label2 setText:[[nameString lowercaseString]  stringByConvertingCamelCaseToCapitalizedWords]];
        isFromFloat=NO;

    }
        
    

        UIImageView *verticalLine = (UIImageView*)[cell viewWithTag:6];
        [verticalLine setBackgroundColor:[UIColor blackColor]];
        [verticalLine setAlpha:0.3f];
        
        UIImageView *sinkImgView = (UIImageView*)[cell viewWithTag:7];
        [sinkImgView setBackgroundColor:[UIColor blackColor]];
        [sinkImgView setAlpha:0.3f];
        
        UILabel *sinkLabel = (UILabel*)[cell viewWithTag:8];
        [sinkLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        [sinkLabel setAlpha:0.6f];
        NSString *airCount=[NSString stringWithFormat:@"%d",[[dic objectForKey:@"AirCount"]intValue]] ;
        
        [sinkLabel setText:airCount];
        
        UIImageView *airImgView = (UIImageView*)[cell viewWithTag:9];
        [airImgView setBackgroundColor:[UIColor blackColor]];
        [airImgView setAlpha:0.3f];
        
        UILabel *airLabel = (UILabel*)[cell viewWithTag:10];
        [airLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        [airLabel setAlpha:0.6f];
        NSString *sinkCount=[NSString stringWithFormat:@"%d",[[[[ownerandText objectAtIndex:indexPath.row]  objectForKey:@"text"] objectForKey:@"SinkCount"]intValue]] ;
        
        [airLabel setText:sinkCount];
        
        
//}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    thoughtSelectedView = [[ThoughtSelectedView alloc] initWithNibName:@"ThoughtSelectedView" bundle:nil];
    
    UITableViewCell *cell=(UITableViewCell *)[tableView viewWithTag:indexPath.row];
    
    UILabel *label = (UILabel*)[cell viewWithTag:3];
    
    [thoughtSelectedView setThoughtsRef:thoughtsref];

    [thoughtSelectedView setOwnerDetails:label.text];
   
    [thoughtSelectedView setSelectedAvatar:indexPath.row];
    
    [thoughtSelectedView setM_thoughtController:self];

    [self.view addSubview:thoughtSelectedView.view];
 

    CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
    CGPoint yOffset = thoughtsTable.contentOffset;
    
    
  
    [thoughtSelectedView.displayImageView setFrame:CGRectMake(frame.origin.x, (frame.origin.y - yOffset.y)+10, 320,95)];
    [thoughtSelectedView.view setFrame:CGRectMake(frame.origin.x, 0, 320,460)];
   

}




-(void)loadcurrentView
{
    [thoughtsTable reloadData];
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

        
/*Download the thoughts*/
-(void)downloadThoughts{
    
    int eventSkipByValue=[thoughtsref count];
    if (eventSkipByValue<=appDelegate.textCount)
    {
    [btnDeco setHidden:YES];
    data=[[NSMutableData alloc] initWithCapacity:1];
    [prograssBar startAnimating];
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/textFloats?lat=%f&lng=%f&radius=%f&skipBy=%d&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,thoughtsref.count,latestVale];

    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection;
    connection=[NSURLConnection connectionWithRequest:req delegate:self];
    
    IsFromThought=1;
        
        
        if (appDelegate.textCount==0 && appDelegate.radiusVal<20.00000) 
        {
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"Please increase radius to get more thoughts." forState:UIControlStateNormal];
        }
        
        
        else if (appDelegate.textCount==0 && appDelegate.radiusVal==20.00000) 
        {
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"" forState:UIControlStateNormal];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"We could not find any thoughts floating around you. Why don't you be the first one to go ahead and float something !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            alert.tag=1;
            [alert show];
            //[alert release];
        }

        
       else if (thoughtsref.count==appDelegate.textCount)
       {
            [prograssBar stopAnimating];
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"No more thoughts to load." forState:UIControlStateNormal];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No more thoughts to load." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {

            NSUserDefaults *userdetails=[NSUserDefaults standardUserDefaults];
            if ([userdetails objectForKey:@"DisplayTag"])
            {
                
                CreateFloatViewController *createCon=[[CreateFloatViewController alloc]initWithNibName:@"CreateFloatViewController" bundle:nil];
                
                [self.view addSubview:createCon.view];
            }
            else
            {
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
                [alertView show];
                alertView.tag=2;
                [alertView release];
                
            }
        }
    }
    
    
    if (alertView.tag==2) {
        if (buttonIndex==1) 
        {
                LoginViewController *loginVi=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.view addSubview:loginVi.view];
        }
    }

}



-(void)sortThoughts:(NSString *)sortString
{

    appDelegate.skipByValue=0;
    latestVale=[sortString lowercaseString];
    data=[[NSMutableData alloc] initWithCapacity:1];  
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/textFloats?lat=%f&lng=%f&radius=4&skipBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],sortString];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection;
    connection=[NSURLConnection connectionWithRequest:req delegate:self];
    
    IsFromThought=2;
    
    [activityView setHidden:NO];

}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [data appendData:data1];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (IsFromThought==1)
    {
        NSMutableArray *events2=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        [appDelegate getThoughData:events2];
        NSMutableArray *events1=[[responseString JSONValue] objectForKey:@"TextFloats"];
        [appDelegate getThoughTextFloatData:events1];
        [thoughtsTable  reloadData];
        //[self startLoading];
    }
    
    else if(IsFromThought==2){
        NSMutableArray *eventData=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        [self getThoughData:eventData];
        NSMutableArray *eventdata2=[[responseString JSONValue] objectForKey:@"TextFloats"];
        [self getThoughTextFloatData:eventdata2];
        [thoughtsTable reloadData];
    }
    
    [activityView setHidden:YES];
    [prograssBar stopAnimating];
    [mainBar stopAnimating];
    [mainLabel setHidden:YES];
    [btnDeco setHidden:NO];
}


-(void)getThoughData:(NSMutableArray *)dataarray
{
    if ([appDelegate.thoughtsOwnerDetails count]) {
        [appDelegate.thoughtsOwnerDetails removeAllObjects];
    }
    
    for (NSDictionary *dic in dataarray)
    {
        
        
        [appDelegate.thoughtsOwnerDetails addObject:dic];
    }
  
}


-(void)getThoughTextFloatData:(NSMutableArray *)dataarray
{
    
    if ([appDelegate.thoughsTextFloats count]) {
        [appDelegate.thoughsTextFloats removeAllObjects];
    }
    if ([appDelegate.thoughtsComments count]) {
        [appDelegate.thoughtsComments removeAllObjects];
    }
    for (NSDictionary *dic in dataarray)
    {
    
        if ([[dic objectForKey:@"AirCount"] intValue]) {
            BOOL isAired;
            
            for (int i1=0; i1<[[dic objectForKey:@"AirUserIds"] count]; i1++) {
                
                if ([[[dic objectForKey:@"AirUserIds"] objectAtIndex:i1] isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"_id"]]) {
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
            
            for (int i1=0; i1<[[dic objectForKey:@"SinkUserIds"] count]; i1++) {
                
                if ([[[dic objectForKey:@"SinkUserIds"] objectAtIndex:i1] isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"_id"]]) {
                    isSinked=YES;
                    break;
                }
            }
            
            [dic setValue:[NSNumber numberWithBool:isSinked] forKey:@"isSinked"];
        }
        else {
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isSinked"];
        }
        
        [appDelegate.thoughsTextFloats addObject:dic];
    
        //[self performSelector:@selector(parseThoughtsCommentData:) onThread:[NSThread currentThread] withObject:dic waitUntilDone:YES];
    }
  //  [self.viewController.thoughtsCountLabel setText:[NSString stringWithFormat:@"%d",[thoughsTextFloats count]]];
}


-(void)getThoughtsComment:(NSMutableArray *)dataarray
{
    [appDelegate.thoughtsComments addObject:dataarray];
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

- (NSDate*)getDateFromJSON1:(NSString *)dateString
{
    // Expect date in this format "/Date(1268123281843)/"
    int startPos = [dateString rangeOfString:@"("].location+1;
    int endPos = [dateString rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos,endPos-startPos);
    unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
    NSTimeInterval interval = milliseconds/1000;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}
@end
