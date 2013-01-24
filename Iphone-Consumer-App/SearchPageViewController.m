//
//  SearchPageViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchPageViewController.h"
#import "AppDelegate.h"

@interface SearchPageViewController ()

@end

@implementation SearchPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fontForBottomBar = [UIFont boldSystemFontOfSize:12.0f];

    searchArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    color = [UIColor colorWithRed:59/250.0f green:27/250.0f blue:6/250.0f alpha:1.0];

    bottomBar = [[BottomBarViewController alloc] initWithNibName:@"BottomBarViewController" bundle:nil];
    [bottomBar.view setFrame:CGRectMake(0, 410, 320, 50)];
    
    [bottomBar.bottomScrollView setShowsHorizontalScrollIndicator:NO];
    [bottomBar.bottomScrollView setPagingEnabled:YES];
    //[bottomBar setContentSize:CGSizeMake(640, 40)];
    [bottomBar.bottomScrollView setContentSize:CGSizeMake(592, 50)];
    [bottomBar.bottomScrollView setBackgroundColor:[UIColor blackColor]];
    [bottomBar.bottomScrollView setContentOffset:CGPointMake(272, 0) animated:NO];
    
    //bottomBar.bottomScrollView.frame = m_appDel.bottomBarFrame;
    
    [self.view addSubview:bottomBar.view];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button1 setTitle:@"Option1" forState:UIControlStateNormal];
    [button1 setTitleColor:color forState:UIControlStateNormal];
    
    [button1 setFrame:CGRectMake(1, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button2 setTitle:@"Option2" forState:UIControlStateNormal];
    [button2 setTitleColor:color forState:UIControlStateNormal];
    
    [button2 setFrame:CGRectMake(73, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button2];
    
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button3 setTitle:@"Option3" forState:UIControlStateNormal];
    [button3 setTitleColor:color forState:UIControlStateNormal];
    
    [button3 setFrame:CGRectMake(145, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button3];
    
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button4 setTitle:@"BACK" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitleColor:color forState:UIControlStateNormal];
    
    [button4 setFrame:CGRectMake(217, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button4];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(71, 8, 2, 41)];
    [imgView1 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView1];
    [imgView1 release];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(143, 8, 2, 41)];
    [imgView2 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView2];
    [imgView2 release];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(215, 8, 2, 41)];
    [imgView3 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView3];
    [imgView3 release];
    
    UIImageView *arrowimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(322, 19, 11, 12)];
    [arrowimgView1 setImage:[UIImage imageNamed:@"t1.png"]];
    [bottomBar.bottomScrollView addSubview:arrowimgView1];
    [arrowimgView1 release];
    
    UIImageView *arrowimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(337, 19, 11, 12)];
    [arrowimgView2 setImage:[UIImage imageNamed:@"t1.png"]];
    [bottomBar.bottomScrollView addSubview:arrowimgView2];
    [arrowimgView2 release];
    
    UIImageView *arrowimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(352, 19, 11, 12)];
    [arrowimgView3 setImage:[UIImage imageNamed:@"t1.png"]];
    [bottomBar.bottomScrollView addSubview:arrowimgView3];
    [arrowimgView3 release];
    
    UIImageView *arrowimgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(365, 19, 11, 12)];
    [arrowimgView4 setImage:[UIImage imageNamed:@"t1.png"]];
    [bottomBar.bottomScrollView addSubview:arrowimgView4];
    [arrowimgView4 release];

    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [locationButton setTitle:@"NEAR LOCATION" forState:UIControlStateNormal];
    [locationButton setTitleColor:color forState:UIControlStateNormal];
    [locationButton setBackgroundColor:[UIColor clearColor]];
    [locationButton setFrame:CGRectMake(399, 8, 100, 38)];
    [locationButton.titleLabel setFont:fontForBottomBar];
    
    [bottomBar.bottomScrollView addSubview:locationButton];
    
    UIImageView *locationimgView = [[UIImageView alloc] initWithFrame:CGRectMake(503, 17, 2, 18)];
    [locationimgView setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:locationimgView];
    [locationimgView release];
    
    distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [distanceButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [distanceButton setTitle:@"3 KMS" forState:UIControlStateNormal];
    [distanceButton setTitleColor:color forState:UIControlStateNormal];
    [distanceButton setBackgroundColor:[UIColor clearColor]];
    [distanceButton setFrame:CGRectMake(498, 8, 60, 38)];
    [distanceButton.titleLabel setFont:fontForBottomBar];
    
    [bottomBar.bottomScrollView addSubview:distanceButton];
    
    UIImageView *locationimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(551, 17, 2, 18)];
    [locationimgView2 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:locationimgView2];
    [locationimgView2 release];
    
    editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [editButton setTitle:@"EDIT" forState:UIControlStateNormal];
    [editButton setTitleColor:color forState:UIControlStateNormal];
    //[editButton addTarget:self action:@selector(EditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setBackgroundColor:[UIColor clearColor]];
    [editButton setFrame:CGRectMake(540, 8, 60, 38)];
    [editButton.titleLabel setFont:fontForBottomBar];
    
    [bottomBar.bottomScrollView addSubview:editButton];
    
    [bottomBar.bottomScrollView setContentSize:CGSizeMake(592, 50)];
    [bottomBar.bottomScrollView setContentOffset:CGPointMake(272, 0) animated:NO];
    [bottomBar.bottomScrollView setBackgroundColor:[UIColor blackColor]];
    
    //[self animateImages];
    
    // Do any additional setup after loading the view from its nib.
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


-(IBAction)goBack:(id)sender
{
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma UITableViewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UIView *backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 94)];
        [backgroundView setBackgroundColor:[UIColor colorWithRed:155/250.0f green:70/250.0f blue:15/250.0f alpha:1.0]];
        [cell addSubview:backgroundView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 270, 83)];
        [imageView setTag:1];
        [cell addSubview:imageView];
        [imageView release];
                
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
         [NameLabel setTag:3];
        [NameLabel setBackgroundColor:[UIColor whiteColor]];
        [NameLabel setAlpha:0.55];
         [NameLabel setTextColor:[UIColor colorWithRed:89/250.0f green:39/250.0f blue:5/250.0f alpha:1.0]];
         
         [cell addSubview:NameLabel];
         [NameLabel release];
         
         UILabel *phoneLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(14, 34, 116, 12)];
         [phoneLabel1 setTag:4];
         [phoneLabel1 setBackgroundColor:[UIColor clearColor]];
         [cell addSubview:phoneLabel1];
         [phoneLabel1 release];
        
        UILabel *phoneLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 34, 102, 12)];
        [phoneLabel2 setTag:5];
        [phoneLabel2 setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:phoneLabel2];
        [phoneLabel2 release];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(14, 50, 230, 12)];
        [address setTag:6];
        [address setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:address];
        [address release];
        
        UIImageView *imageView_pointer = [[UIImageView alloc] initWithFrame:CGRectMake(234, 36, 34, 32)];
        [imageView_pointer setTag:7];
        [cell addSubview:imageView_pointer];
        [imageView_pointer release];
        
        UIImageView *imageView_deals = [[UIImageView alloc] initWithFrame:CGRectMake(9, 65, 17, 17)];
        [imageView_deals setTag:8];
        [cell addSubview:imageView_deals];
        [imageView_deals release];

        UILabel *dealsLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 65, 17, 17)];
        [dealsLabel setTag:9];
        [dealsLabel setBackgroundColor:[UIColor clearColor]];
        [dealsLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:dealsLabel];
        [dealsLabel release];
        
        UIImageView *imageView_events = [[UIImageView alloc] initWithFrame:CGRectMake(60, 65, 17, 17)];
        [imageView_events setTag:10];
        [cell addSubview:imageView_events];
        [imageView_events release];
        
        UILabel *eventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 65, 17, 17)];
        [eventsLabel setTag:11];
        [eventsLabel setBackgroundColor:[UIColor clearColor]];
        [eventsLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:eventsLabel];
        [eventsLabel release];
        
        UIImageView *imageView_thoughts = [[UIImageView alloc] initWithFrame:CGRectMake(111, 65, 17, 17)];
        [imageView_thoughts setTag:12];
        [cell addSubview:imageView_thoughts];
        [imageView_thoughts release];
        
        UILabel *thoughtsLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 65, 17, 17)];
        [thoughtsLabel setTag:13];
        [thoughtsLabel setBackgroundColor:[UIColor clearColor]];
        [thoughtsLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:thoughtsLabel];
        [thoughtsLabel release];

        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(224, 69, 60, 14)];
        [distanceLabel setTag:14];
        [distanceLabel setBackgroundColor:[UIColor clearColor]];
        [distanceLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:distanceLabel];
        [distanceLabel release];

        UIImageView *imageView_profile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 94)];
        [imageView_profile setTag:2];
        [cell addSubview:imageView_profile];
        [imageView_profile release];
       

        
    }
    
   /* UIImageView *imgView1 = (UIImageView*)[cell viewWithTag:1];
    [imgView1 setImage:[UIImage imageNamed:@"search_card_shine.png"]];*/
    //[cell setBackgroundColor:[UIColor colorWithRed:155/250.0f green:70/250.0f blue:15/250.0f alpha:1.0]];
    
    
    UIImageView *imgView_profile = (UIImageView*)[cell viewWithTag:2];
    [imgView_profile setImage:[UIImage imageNamed:@"result_card_holders_1.png"]];
    
    UILabel *NameLabel = (UILabel*)[cell viewWithTag:3];
    [NameLabel setText:@"Subway (240 m)"];
    
    
    UILabel *phoneLabel1 = (UILabel*)[cell viewWithTag:4];
    [phoneLabel1 setAlpha:0.9f];
    [phoneLabel1 setTextColor:[UIColor blackColor]];
    [phoneLabel1 setText:@"040 64507999;"];

    UILabel *phoneLabel2 = (UILabel*)[cell viewWithTag:5];
    [phoneLabel2 setAlpha:0.9f];
    [phoneLabel2 setTextColor:[UIColor blackColor]];
    [phoneLabel2 setText:@"040 40206466"];

    UILabel *address = (UILabel*)[cell viewWithTag:6];
    [address setAlpha:0.9f];
    [address setTextColor:[UIColor blackColor]];
    [address setText:@"Fast food,health food"];

  /*  UIImageView *imgView_pointer = (UIImageView*)[cell viewWithTag:7];
    [imgView_pointer setAlpha:0.8f];
    [imgView_pointer setImage:[UIImage imageNamed:@"pointer_1.png"]];*/

    UIImageView *imgView_deals = (UIImageView*)[cell viewWithTag:8];
    [imgView_deals setAlpha:0.45098039215686f];
    [imgView_deals setImage:[UIImage imageNamed:@"deal_icon_w.png"]];

    UILabel *dealsLabel = (UILabel*)[cell viewWithTag:9];
    [dealsLabel setAlpha:0.6f];
    [dealsLabel setText:@"4"];

    UIImageView *imgView_events = (UIImageView*)[cell viewWithTag:10];
    [imgView_events setAlpha:0.45098039215686];
    [imgView_events setImage:[UIImage imageNamed:@"event_icon_w.png"]];
    
    UILabel *eventsLabel = (UILabel*)[cell viewWithTag:11];
    [eventsLabel setAlpha:0.6f];
    [eventsLabel setText:@"2"];

    UIImageView *imgView_thoughts = (UIImageView*)[cell viewWithTag:12];
    [imgView_thoughts setAlpha:0.45098039215686];
    [imgView_thoughts setImage:[UIImage imageNamed:@"thought_icon_w.png"]];
    
    UILabel *thoughtsLabel = (UILabel*)[cell viewWithTag:13];
    [thoughtsLabel setAlpha:0.6f];
    [thoughtsLabel setText:@"1"];
    
   /* UILabel *distanceLabel = (UILabel*)[cell viewWithTag:14];
    [distanceLabel setAlpha:0.6f];
    [distanceLabel setText:@"240 m"];*/

     /*NSMutableDictionary *dataDictionary = [searchArray objectAtIndex:indexPath.row];
     [label setText:[dataDictionary objectForKey:@"thoughts"]];
     [label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:17.0f]];
     [label setAlpha:0.3f];*/
     
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
