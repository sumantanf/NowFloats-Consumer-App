//
//  EventViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventViewController.h"

#import "AppDelegate.h"
#import "JSON.h"
#import "EditController.h"
#import "UIImageView+WebCache.h"
#import "UrlInfo.h"
#import "MarqueeLabel.h"

@implementation EventViewController

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
    return [pickerDataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    appDelegate.eventSortName=[pickerDataArray objectAtIndex:row];

    CurrentVal=row;
}

-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES]; 
   
}

-(IBAction)done:(id)sender
{
    //[prograssBar startAnimating];
    data=[[NSMutableData alloc] initWithCapacity:1];
    [pickerView setHidden:YES]; 
    NSString *sortByName;
    if (CurrentVal==0) {
        sortByName=@"latest";
    }
    else if (CurrentVal==1) {
        sortByName=@"nearest";
    }
    else  {
        sortByName=@"hottest";
    }
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/eventFloats?lat=%f&lng=%f&radius=%f&skipEventBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,sortByName];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLConnection *connection;
   connection =[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1{
    [data appendData:data1];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    if (isFromTap==1) {
        int count=appDelegate.eventsData.count;

        if ([responseString length]) {
            data = nil;
            NSMutableArray *eventsData1=[responseString JSONValue];
            
            
           NSMutableArray *eventsRefidArray=[[NSMutableArray alloc] initWithCapacity:1];
        
            for (NSDictionary *dic in appDelegate.eventsData)
            {
                
                [eventsRefidArray addObject:[dic objectForKey:@"ExternalSourceId"]];
            }
            

            for (NSDictionary *dic in eventsData1)
            {
            
                if ([dic objectForKey:@"ExternalSourceId"]!=[NSNull null])
                {
                    BOOL isEvent=NO;
                    
                    for (int i1=0; i1<[eventsRefidArray count]; i1++) {
                        if ([[eventsRefidArray objectAtIndex:i1] isEqualToString:[dic objectForKey:@"ExternalSourceId"]]) {
                            isEvent=YES;
                            break;
                        }
                    }
                    
                    if (isEvent) {
                        
                        isEvent=NO;
                        
                    }
                    else {
                        
                        
                        if ([dic objectForKey:@"Description"]!=[NSNull null]) {
                            NSString *st=[appDelegate convertToXMLEntities:[dic objectForKey:@"Description"]];
                            
                            [dic setValue:st forKey:@"Description"];
                        }
                        
                        
                        [dic setValue:[appDelegate calculteDistanceLatitude:[[dic objectForKey:@"EventLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"EventLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                        [appDelegate.eventsData addObject:dic];
                        [eventsRefidArray addObject:[dic objectForKey:@"ExternalSourceId"]];

                    }
                }
                else {
                    
                    if ([dic objectForKey:@"Description"]!=[NSNull null]) {
                        NSString *st=[appDelegate convertToXMLEntities:[dic objectForKey:@"Description"]];
                        [dic setValue:st forKey:@"Description"];
                    }
                    
                    
                    [dic setValue:[appDelegate calculteDistanceLatitude:[[dic objectForKey:@"EventLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"EventLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                    [appDelegate.eventsData addObject:dic];
                }
                
                                            
        }

    }
    isFromTap=0;

        if (count==[appDelegate.eventsData count])
        {
            //[btnDeco setTitle:@"No more events to load" forState:UIControlStateNormal];
            [prograssBar stopAnimating];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No more events to load." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            //[alert show];
            [alert release];
        }
        
        
        else
        {
            
            [eventsTableView reloadData];
        }

    }
   
    
    else{
    if ([responseString length]) {
        data = nil;
        NSMutableArray *eventData2=[responseString JSONValue];
        
        
        [appDelegate getEventData:eventData2];
        
        
        [eventsTableView reloadData];

    }
    }
    [prograssBar stopAnimating];
    [mainActivity stopAnimating];
    [mainLabel setHidden:YES];
    [btnDeco setHidden:NO];
    
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

    eventsTableView.scrollsToTop=YES;
    
    
    
    pickerDataArray = [[NSMutableArray alloc] initWithObjects:@"LATEST",@"NEAREST",@"EXPIRING", nil];

    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [nearLocation addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    btnDeco = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDeco.frame = CGRectMake(0, 15, 280, 20);
    [btnDeco.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
    if (appDelegate.eventCount)
    {
        [btnDeco setTitle:@"Tap here.And more events will magically appear." forState:UIControlStateNormal];
        
    }
    else
    {
        [btnDeco setTitle:@"Please increase radius to get more events." forState:UIControlStateNormal];
    
    }
    
    
    if (![appDelegate.eventsData count] ) {
        [mainActivity startAnimating];
        [btnDeco setHidden:YES];
        [self downloadThoughts];
    }
    else{
        [mainLabel setHidden:YES];
    }
    
    
    [prograssBar stopAnimating];

    [btnDeco addTarget:self action:@selector(downloadThoughts) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 50)];
    [footerView addSubview:btnDeco];
    
    eventsTableView.tableFooterView=footerView;
   [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1.000];
            break;
        }
        
    }

    
    imageData=[[NSMutableArray alloc] initWithCapacity:1];
    
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    
    [self animateImages];

    userDefaults_event = [NSUserDefaults standardUserDefaults];
    
    [doneButton.layer setCornerRadius:5.0f];
    color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    

}


#pragma UITableViewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
  
    return [appDelegate.eventsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 2)];
        [imageView setTag:1];
        [cell addSubview:imageView];
        [imageView release];
        
       
        
        UIImageView *dateHoldimageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 22, 49, 49)];
        [dateHoldimageView setTag:2];
        [cell addSubview:dateHoldimageView];
        [dateHoldimageView release];
        
        UILabel *dateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 49, 22)];
        [dateLabel1 setTag:3];
        [dateLabel1 setNumberOfLines:2];
        color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
        [dateLabel1 setTextColor:color];
        [dateLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [dateLabel1 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:dateLabel1];
        [dateLabel1 release];
        
        UILabel *dateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 41, 49, 27)];
        [dateLabel2 setTag:4];
        [dateLabel2 setNumberOfLines:2];
        color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
        [dateLabel2 setTextColor:color];
        [dateLabel2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
        [dateLabel2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:dateLabel2];
        [dateLabel2 release];
        
        UIImageView *imageView_event = [[UIImageView alloc] initWithFrame:CGRectMake(73, 20, 88, 88)];
        [imageView_event setTag:5];
        
        [cell addSubview:imageView_event];
        
        UILabel *whiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 20, 140, 88)];
        [whiteLabel setTag:6];
        [whiteLabel setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:whiteLabel];
        [whiteLabel release];
        
        UILabel *EventTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 100, 68)];
        [EventTextLabel setTag:7];
        [EventTextLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
        [EventTextLabel setTextColor:color];
        
        [EventTextLabel setNumberOfLines:5];
        [EventTextLabel setTextAlignment:UITextAlignmentLeft];
        [EventTextLabel setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:EventTextLabel];
        [EventTextLabel release];
        
        UIImageView *expandimageView = [[UIImageView alloc] initWithFrame:CGRectMake(285, 88, 14, 16)];
        [expandimageView setTag:8];
        [cell addSubview:expandimageView];
        [expandimageView release];
        
        UIImageView *imageView_event1 = [[UIImageView alloc] initWithFrame:CGRectMake(73, 20, 88, 88)];
        [imageView_event1 setTag:9];
        [cell addSubview:imageView_event1];
        

 


    }
    
    UIImageView *imgView1 = (UIImageView*)[cell viewWithTag:1];

    UIImageView *imgView2 = (UIImageView*)[cell viewWithTag:2];
    [imgView2 setImage:[UIImage imageNamed:@"date_holder.png"]];

    UILabel *label1 = (UILabel*)[cell viewWithTag:3];
    UILabel *label2 = (UILabel*)[cell viewWithTag:4];

    UIImageView *imgView_event = (UIImageView*)[cell viewWithTag:5];


    UILabel *label3 = (UILabel*)[cell viewWithTag:6];

    UILabel *label4 = (UILabel*)[cell viewWithTag:7];
    UIImageView *imgView_expand = (UIImageView*)[cell viewWithTag:8];
    
    UIImageView *imgView_event1 = (UIImageView*)[cell viewWithTag:9];



    if (indexPath.row%2==0) {
       


        [imgView2 setFrame:CGRectMake(16, 22, 49, 49)];


        
        
        [label1 setFrame:CGRectMake(16, 22, 49, 22)];
        
        [label2 setFrame:CGRectMake(16, 41, 49, 27)];
        
        [ label3 setFrame:CGRectMake(162, 20, 140, 88)];
        
        [ label4 setFrame:CGRectMake(172, 30, 100, 68)];
        
        [ imgView_expand setFrame:CGRectMake(287, 88, 14, 16)];
        
        [imgView_event setFrame:CGRectMake(75, 20, 88, 88)];
        
        [imgView_event1 setFrame:CGRectMake(75, 20, 88, 88)];
        
    }
    else{
        
        
        [imgView2 setFrame:CGRectMake(255, 22, 49, 49)];

        [label1 setFrame:CGRectMake(255, 22, 49, 22)];
        
        [label2 setFrame:CGRectMake(255, 41, 49, 27)];
        
        [ label3 setFrame:CGRectMake(106, 20, 140, 88)];
        
        [ label4 setFrame:CGRectMake(116, 30, 100, 68)];
        
        [ imgView_expand setFrame:CGRectMake(232, 88, 14, 16)];
        
        [imgView_event setFrame:CGRectMake(18, 20, 88, 88)];

        [imgView_event1 setFrame:CGRectMake(18, 20, 88, 88)];
        
        
    }
    
    [imgView1 setImage:[UIImage imageNamed:@"clothesline.png"]];
    [imgView2 setImage:[UIImage imageNamed:@"date_holder.png"]];

    [imgView1 setAlpha:0.6f];

    [imgView2 setAlpha:0.6f];

    [label1 setTextAlignment:UITextAlignmentCenter];
  
    
    NSString *dateString=[[appDelegate.eventsData objectAtIndex:indexPath.row] objectForKey:@"StartDate"] ;
    if (dateString == (id)[NSNull null] || dateString.length == 0 )
    {
        [label1 setText:@"T B D"];
        [label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
        [label2 setTextAlignment:UITextAlignmentCenter];
        [label2 setText:@""];
        [label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28.0f]];
    }
    else
    {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        if ([dateString length]) {
            NSDate *date1=[self getDateFromJSON:dateString];
            [dateFormatter setDateFormat:@"MMM"];
            if ([[dateFormatter stringFromDate:date1] length]) {
                [label1 setText:[[dateFormatter stringFromDate:date1] uppercaseString]];
                [label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
                [dateFormatter setDateFormat:@"dd"];
                [label2 setTextAlignment:UITextAlignmentCenter];
                [label2 setText:[[dateFormatter stringFromDate:date1]uppercaseString]];
                [label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28.0f]];
            }
            
            
            
            
        }

    }
    
    
    [imgView_event setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.withfloats.com%@",[[appDelegate.eventsData objectAtIndex:indexPath.row] objectForKey:@"TileImageUri"]]] placeholderImage:[UIImage imageNamed:@"eventlogo.png"]];


    [imageData addObject:imgView_event.image];
    
        
    [label3 setBackgroundColor:[UIColor whiteColor]];
    
    if ([[appDelegate.eventsData objectAtIndex:indexPath.row] objectForKey:@"Title"]!=(id)[NSNull null])
    
    {
        [label4 setText:[[appDelegate.eventsData objectAtIndex:indexPath.row] objectForKey:@"Title"]];
            }
   

    [imgView_expand setImage:[UIImage imageNamed:@"blue.png"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [imgView_event1 setContentMode:UIViewContentModeScaleToFill];
    
    [imgView_event1 setImage:[UIImage imageNamed:@"IPhone event-image-frame.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    exp = [[EventsExpandedView alloc] initWithNibName:@"EventsExpandedView" bundle:nil];
    [exp setDic:[appDelegate.eventsData objectAtIndex:indexPath.row]];
    UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *img=(UIImageView *)[cell viewWithTag:5];
    [exp setImg:img.image];

   // [exp setImg:[imageData objectAtIndex:indexPath.row]];
  
    
    AppDelegate *m_appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [m_appDel.viewsArray addObject:exp.view];

    [self.view addSubview:exp.view];
}


-(IBAction)gotoHomePage:(id)sender
{
    //[self.view removeFromSuperview];
    [self deallocateForHome];
    AppDelegate *m_appDel =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    for(int j=0;j<[m_appDel.viewsArray count];j++)
    {
        [[m_appDel.viewsArray objectAtIndex:j] removeFromSuperview];
    }
    [m_appDel.viewsArray removeAllObjects];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];


}

-(IBAction)goBack:(id)sender
{
    [self deallocate];
    [self.view removeFromSuperview];
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
        unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
       
        NSTimeInterval interval = milliseconds/1000;
        d= [NSDate dateWithTimeIntervalSince1970:interval];
    }
    // Expect date in this format "/Date(1268123281843)/"
    return d;
}


-(void)downloadThoughts{
    
    [btnDeco setHidden:YES];
    int eventSkipByValue=[appDelegate.eventsData count];
    if (eventSkipByValue<=appDelegate.eventCount)
    {
        isFromTap=1;
        [prograssBar startAnimating];
        data=[[NSMutableData alloc] initWithCapacity:1];
        [prograssBar startAnimating];
        NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/eventFloats?lat=%f&lng=%f&radius=%f&skipEventBy=%d&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,[appDelegate.eventsData count],appDelegate.eventSortName];
        NSURL *url=[NSURL URLWithString:urlString];
        NSURLRequest *req=[NSURLRequest requestWithURL:url];
        NSURLConnection *connection;
        connection=[NSURLConnection connectionWithRequest:req delegate:self];
        
        if (appDelegate.eventCount==0 && appDelegate.radiusVal<20.00000) 
        {
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"Please increase radius to get more events." forState:UIControlStateNormal];

        }
        
        else if (appDelegate.eventCount==0 && appDelegate.radiusVal==20.00000) 
        {
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"" forState:UIControlStateNormal];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"We could not find any events around you. We are working hard to discover more events for you.\n Keep checking!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        
        
        else if (eventSkipByValue==appDelegate.eventCount) 
        {
            [btnDeco setHidden:NO];
            [btnDeco setTitle:@"No more events to load" forState:UIControlStateNormal];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No more events to load." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        
        
        
        
    
        

    }
    else{
        
        [btnDeco setHidden:NO];
        [btnDeco setTitle:@"No more events to load" forState:UIControlStateNormal];

        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No more events to load." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        [alert release];

    }
    
    
    //IsFromThought=1;

}

-(void)deallocate
{
    [picker release];
    [pickerDataArray release];
    [pickerView release];
    [doneButton release];
    [cancelButton release];
    [prograssBar release];
    [mainActivity release];
    [mainLabel release];
    [eventsTableView release];
    [btnDeco release];
    
}


-(void)deallocateForHome;
{
    [picker release];
    [pickerDataArray release];
    [pickerView release];
    [doneButton release];
    [cancelButton release];
    [prograssBar release];
    [mainActivity release];
    [mainLabel release];
    [eventsTableView release];
    [btnDeco release];

}


@end
