//
//  DealsViewController.m
//  NowFloats_v1
//
//  Created by pravasis on 01/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DealsViewController.h"
#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "MarqueeLabel.h"

@implementation DealsViewController

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
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];


    dealsInfo=[[NSMutableArray alloc] initWithCapacity:1];
    pickerDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [pickerDataArray addObject:@"EXPIRING"];
    [pickerDataArray addObject:@"LATEST"];
    [pickerDataArray addObject:@"NEAREST"];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
   
    appDelegate.dealRef=(DetailViewController *)self;
    btnDeco = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDeco.frame = CGRectMake(0, 15, 265, 20);
    [btnDeco.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    

    [btnDeco addTarget:self action:@selector(downloadThoughts) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (![appDelegate.dealsData count]) {
        [mainActivity startAnimating];
        [self downloadThoughts];
        [btnDeco setHidden:YES];
    }
    else{
        [mainLabel setHidden:YES];
    }
    [prograssBar stopAnimating];
    
        
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            mark.textColor = [UIColor colorWithRed:0.686 green:0.764 blue:0.019 alpha:1.000];
            break;
        }
        
    }
        
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 280, 50)];
    [footerView addSubview:btnDeco];
    
    dealsTableView.tableFooterView=footerView;
    arrowImagesWidth = 11;
    arrowImagesHeight = 12;
    yPosition = 19;
    

    userDefaults = [NSUserDefaults standardUserDefaults];

    
    dealsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    
        if ([appDelegate.dealsData count]==appDelegate.dealCount)
        {
            
            [btnDeco setTitle:@"No more deals to load" forState:UIControlStateNormal];
        }
        
        else
        {
            [btnDeco setTitle:@"Tap here to demand more offers." forState:UIControlStateNormal];
        
        }
    
    
    if (appDelegate.dealCount==0)
    {
        [btnDeco setTitle:@"Please increase radius to get more offers." forState:UIControlStateNormal];
    }
    
    [self readDealsInfo]; ;


   
}

-(void)readDealsInfo
{
    [dealsInfo removeAllObjects];
    
    if ([userDefaults objectForKey:[NSString stringWithFormat:@"hide_%@",[userDefaults objectForKey:@"_id"]]])
    {
        NSMutableArray *hidesData=
        [[userDefaults objectForKey:[NSString stringWithFormat:@"hide_%@",
                                     [userDefaults objectForKey:@"_id"]]] mutableCopy];
        
        for (int i1=0; i1<[appDelegate.dealsData count]; i1++)
        {
            NSMutableDictionary *dic=[appDelegate.dealsData objectAtIndex:i1];
            
            BOOL isDealHide;
            
            for (int j=0; j<[hidesData count]; j++)
            {
                if ([[dic objectForKey:@"_id"] isEqualToString:[hidesData objectAtIndex:j]])
                {
                    isDealHide=YES;
                }
            }
            if (!isDealHide)
            {
                [dealsInfo addObject:[appDelegate.dealsData objectAtIndex:i1]];
            }
            else
            {
                isDealHide=NO;
            }
        }
    }
    
    else
    {
        dealsInfo=[appDelegate.dealsData mutableCopy];
        
        
        for (NSMutableDictionary *dic in dealsInfo)
        {


        }
                    
    }

    [dealsTableView reloadData];
}

-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES]; 
}

-(IBAction)done:(id)sender
{
    data=[[NSMutableData alloc] initWithCapacity:1];
    [pickerView setHidden:YES]; 
    NSString *sortByName;
    sortByName=[[pickerDataArray objectAtIndex:CurrentVal] lowercaseString];
   // appDelegate.dealSortName=sortByName;
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/dealFloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,sortByName];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLConnection *connection;
    connection =[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [prograssBar startAnimating];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1{
    [data appendData:data1];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (isFromTap)
    {
        
      NSMutableArray * dealsRefidArray=[[NSMutableArray alloc] initWithCapacity:1];
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        

        data = nil;
        NSMutableArray  *latestDeals = [(NSDictionary*)[responseString JSONValue] objectForKey:@"OfflineDeals"];
        
        for (NSDictionary *dic in latestDeals)
        {
            BOOL isDeal=NO;

            if ([dic objectForKey:@"ExternalSourceId"]!=[NSNull null]) {
                
                for (int i1=0; i1<[dealsRefidArray count]; i1++)
                {
                    if ([[dealsRefidArray objectAtIndex:i1] isEqualToString:[dic objectForKey:@"ExternalSourceId"]]) {
                        isDeal=YES;
                        break;
                    }
                }
                
                if (isDeal)
                {
                    isDeal=NO;
                    
                }
                else
                {
                    
                    [dic setValue:[appDelegate calculteDistanceLatitude:[[dic objectForKey:@"DealLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"DealLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                    [appDelegate.dealsData addObject:dic];
                    [dealsRefidArray addObject:[dic objectForKey:@"ExternalSourceId"]];
                }
                
            }
            else
            {
                [dic setValue:[appDelegate calculteDistanceLatitude:[[dic objectForKey:@"DealLocation"]objectForKey:@"latitude"] :[[dic objectForKey:@"DealLocation"]objectForKey:@"longitude"]] forKey:@"CalculateRadius"];
                [appDelegate.dealsData addObject:dic];
            }
            
        }
        
        [dealsTableView reloadData];
        isFromTap=0;
        [btnDeco setHidden:NO];

        
        //[appDelegate.viewController.dealsCountlabel setText:[NSString stringWithFormat:@"%d",[dealsData count]]];
    }
    else
    {
        
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
	data = nil;
    NSMutableArray  *latestDeals = [(NSDictionary*)[responseString JSONValue] objectForKey:@"OfflineDeals"];
    
    
    [appDelegate getData:latestDeals];
    [dealsTableView reloadData];
        
    }
    
    [mainActivity stopAnimating];
    [prograssBar stopAnimating];
    [mainLabel setHidden:YES];

    //[eventsTableView reloadData];
    [self readDealsInfo];
}


-(IBAction)sort:(id)sender
{
    [pickerView setHidden:NO];
    
    NSString *str = [userDefaults objectForKey:@"selectedIndex"];
    
    if([str length] == 0)
    {
        [picker selectRow:2 inComponent:0 animated:YES];
    }
    else
    {
        [picker selectRow:[str intValue] inComponent:0 animated:YES];
    }
    
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
//    [userDefaults setObject:[NSString stringWithFormat:@"%d",row] forKey:@"selectedIndex"];
     CurrentVal=row;
}

-(IBAction)goBack:(id)sender
{

       [self.view removeFromSuperview];
}

-(IBAction)gotoHomePage:(id)sender
{
    [self deallocateForHome];
    [self.view removeFromSuperview];
    [appDelegate.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];
}

#pragma UITableViewDelegate and DataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [dealsInfo count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 260, 80)];
        [backgroundLabel setTag:1];
        [backgroundLabel setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:backgroundLabel];
        [backgroundLabel release];
        
        UILabel *thoughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 16, 200, 50)];
        [thoughtLabel setTag:2];
        [thoughtLabel setLineBreakMode:UILineBreakModeTailTruncation];
        [thoughtLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:thoughtLabel];
        [thoughtLabel release];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 46, 200, 50)];
        [nameLabel setTag:3];
        [nameLabel setNumberOfLines:2];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:nameLabel];
        [nameLabel release];
        
        UIImageView *imageView_Pocket = [[UIImageView alloc] initWithFrame:CGRectMake(19,91, 283, 9)];
        [imageView_Pocket setTag:4];
        [cell addSubview:imageView_Pocket];
        [imageView_Pocket release];

        UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 33, 23 , 16)];
        [sideLabel setTag:5];
        [cell addSubview:sideLabel];
        [sideLabel release];
        
}
    
    UIColor *color1 = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];

    
    UILabel *bglayer=(UILabel *)[cell viewWithTag:1];
    [bglayer.layer setCornerRadius:5];
    
    UILabel *label = (UILabel*)[cell viewWithTag:2];
    [label setTextColor:color1];
    [label setAdjustsFontSizeToFitWidth:NO];
    

    
    //[label setLineBreakMode:UILIne];
    
    NSMutableDictionary *dataDictionary = [dealsInfo objectAtIndex:indexPath.row];
    [label setText:[[dataDictionary objectForKey:@"MerchantName"]uppercaseString]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];

    
    UILabel *label2 = (UILabel*)[cell viewWithTag:3];
    NSString *personString =[ [dataDictionary objectForKey:@"Title"]uppercaseString];
    [label2 setFont:[UIFont fontWithName:@"Helvetica" size:12]];  
    [label2 setTextColor:color1];
    [label2 setText:personString];
        
    UIImageView *imgView_pocket = (UIImageView*)[cell viewWithTag:4] ;
    [imgView_pocket setImage:[UIImage imageNamed:@"dealPocket.png"]];

    UILabel *sideLabel = (UILabel*)[cell viewWithTag:5] ;
    UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];

    [sideLabel setBackgroundColor:color];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dealsExpandedViewMain = [[DealsExpandedViewMain alloc] initWithNibName:@"DealsExpandedViewMain" bundle:nil];
    [dealsExpandedViewMain setDealsTableview:dealsTableView];
    
    NSMutableDictionary *dataDictionary1 = [dealsInfo objectAtIndex:indexPath.row];
    //[dealsExpandedViewMain setDealsLocationString1:[dataDictionary1 objectForKey:@"MerchantName"]];
     [dealsExpandedViewMain setDic:dataDictionary1];
    [dealsExpandedViewMain.view setFrame:CGRectMake(0, 0, 320, 460)];
    [appDelegate.viewsArray addObject:dealsExpandedViewMain.view];
    [self.view addSubview:dealsExpandedViewMain.view];
    
}


- (void)viewDidUnload;
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

-(IBAction)editButtonClicked:(id)sender
{

    
}

-(IBAction)storeButtonClicked:(id)sender{

    storeViewController=[[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    [self.view addSubview:storeViewController.view];
    
}


-(void)downloadThoughts{
    

     int eventSkipByValue=[appDelegate.dealsData count];
     if (eventSkipByValue<=appDelegate.dealCount)//deal count-1
     {
        [btnDeco setHidden:YES];

        isFromTap=1;
        data=[[NSMutableData alloc] initWithCapacity:1];
         NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/dealFloats?lat=%f&lng=%f&radius=%f&skipBy=%d&sortBy=nearest&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,[appDelegate.dealsData count]];
        NSURL *url=[NSURL URLWithString:urlString];
        NSURLRequest *req=[NSURLRequest requestWithURL:url];
        NSURLConnection *connection;
        connection=[NSURLConnection connectionWithRequest:req delegate:self];
        [prograssBar startAnimating];


         if (appDelegate.dealCount==0 && appDelegate.radiusVal<20.00000) 
         {
             [btnDeco setHidden:NO];
             [btnDeco setTitle:@"Please increase radius to get more offers." forState:UIControlStateNormal];
             
         }
         
         else if (appDelegate.dealCount==0 && appDelegate.radiusVal==20.00000) 
         {
             [btnDeco setHidden:NO];
             [btnDeco setTitle:@"" forState:UIControlStateNormal];
             
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"We could not find any offers around you. We are working hard to discover more offers for you.\n Keep checking!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
             [alert show];
             [alert release];
         }
         
         
        else if(eventSkipByValue==appDelegate.dealCount)
          {
             [btnDeco setHidden:NO];
             [btnDeco setTitle:@"No more offers to load" forState:UIControlStateNormal];
             [prograssBar stopAnimating];
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No more offers to load." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
             [alert show];
             [alert release];
             
         }

    }

}


-(void)deallocate
{
 
    [pickerDataArray release];
    [data release];
    [mainActivity release];
    [picker release];
    [data release];
    [doneButton release];
    [cancelButton release];
    [dealsExpandedViewMain release];
    [prograssBar release];
    [editController release];
    [pickerView release];
    [btnDeco release];
    [storeViewController release];
    [editController release];
    [dealsTableView release];
    [dealLoadingActivity release];
    [dealsInfo release];
    [mainLabel release];
    
}

-(void)deallocateForHome
{

    [pickerDataArray release];
    [data release];
    [mainActivity release];
    [picker release];
    [data release];
    [doneButton release];
    [cancelButton release];
    [prograssBar release];
    [editController release];
    [pickerView release];
    [btnDeco release];
    [storeViewController release];
    [editController release];
    [dealsTableView release];
    [dealLoadingActivity release];
    [dealsInfo release];
    [mainLabel release];

}





-(void)dealloc{
      
//    [pickerDataArray release];
//    [data release];
//    [dealsInfo release];
//
//    [mainActivity release];
//    [picker release];
//    [pickerDataArray    release];
//    [data release];
//    [doneButton release];
//    [cancelButton release];
//    [dealsExpandedViewMain release];
//    [prograssBar release];
//    [editController release];
//    [storeViewController release];
//    [pickerView release];
//    [btnDeco release];
//    [storeViewController release];
//    [editController release];
//    [dealsTableView release];
//    [dealLoadingActivity release];
//    [dealsInfo release];
//    [mainLabel release];
    [super dealloc];
    
    
}
@end

