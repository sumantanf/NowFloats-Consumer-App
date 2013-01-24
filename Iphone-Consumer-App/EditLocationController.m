//
//  EditLocationController.m
//  NowFloats_v1
//
//  Created by pravasis on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditLocationController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UrlInfo.h"
#import "UIColor+HexaString.h"
#import "MarqueeLabel.h"


@implementation EditLocationController
@synthesize viewCon;
@synthesize fromHome;
@synthesize bottomScrollView;

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

#pragma UITableViewDelegate and DataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [locatonArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    color = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1];

    [tableView setSeparatorColor:color];
    //int colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];

    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        UILabel *backgroundColor = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 305, 45)];
        [backgroundColor setTag:2];
        [backgroundColor setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:backgroundColor];
        [backgroundColor release];
        
        UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,-3, 245, 45)];
        [backgroundLabel setTag:1];
        [backgroundLabel setBackgroundColor:[UIColor clearColor]];
        color = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1];
        [backgroundLabel setTextColor:color];
        [cell addSubview:backgroundLabel];
        [backgroundLabel release];
        
       
        UIImageView *footer = [[UIImageView alloc] initWithFrame:CGRectMake(4,40, 292,5)];

                
        
        
        
        if (colorVal==1) {
            
            footer.backgroundColor=[UIColor colorWithHexString:@"a5e1ff"];

        }
        
        else if(colorVal==2)
        {
           footer.backgroundColor=[UIColor colorWithHexString:@"fff587"];
            

            
            
        }
        
        
        else if (colorVal==3)
        {
            footer.backgroundColor=[UIColor colorWithHexString:@"ffa50a"];
            
        
            
        }
        
        
        else if (colorVal ==4)
            
        {
            footer.backgroundColor=[UIColor colorWithHexString:@"2e3f92"];

        }
        
        
        
        else if(colorVal ==5)
        {
            
            footer.backgroundColor=[UIColor colorWithHexString:@"ffc8f5"];
            
            
        }
        
        
        else if (colorVal ==6)
        {
            
             footer.backgroundColor=[UIColor colorWithHexString:@"ff0000"];
            
            
            
        }
        
        else 
        {
            
            footer.backgroundColor=[UIColor colorWithHexString:@"ffa50a"];
            
            
            
        }

        
       // footer.backgroundColor=colorCodeVal;
        [cell addSubview:footer]; 
        [footer release];
        
        [cell setBackgroundView:nil];
    }
    
    
    UILabel *locationLabel = (UILabel*)[cell viewWithTag:1];
    [locationLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [locationLabel setText:[[locatonArray objectAtIndex:indexPath.row] uppercaseString]];
    [locationLabel setTextColor:[UIColor whiteColor]];

   // color = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1];
    UILabel *selectedBackground= (UILabel*)[cell viewWithTag:2];

    if(appDelegate.selectedArondValue == indexPath.row)
    {
        //[locationLabel setBackgroundColor:[UIColor redColor]];
        


        
        if (colorVal==1) {
            
            selectedBackground.backgroundColor=[UIColor colorWithHexString:@"a5e1ff"];
            
        }
        
        else if(colorVal==2)
        {
            selectedBackground.backgroundColor=[UIColor colorWithHexString:@"fff587"];
            
            
            
            
        }
        
        
        else if (colorVal==3)
        {
            selectedBackground.backgroundColor=[UIColor colorWithHexString:@"ffa50a"];
            
            
          //  [selectedBackground setBackgroundColor:[UIColor colorWithRed:255/255.0 green:165/255 blue:10/255.0 alpha:1]];
        }
        
        
        else if (colorVal ==4)
            
        {
            selectedBackground.backgroundColor=[UIColor colorWithHexString:@"2e3f92"];
            
        }
        
        
        
        else if(colorVal ==5)
        {
            
selectedBackground.backgroundColor=[UIColor colorWithHexString:@"ffc8f5"];
            
            
        }
        
        
        else if (colorVal ==6)
        {
            
           selectedBackground.backgroundColor=[UIColor colorWithHexString:@"ff0000"];
            
            
            
        }
        
        else
        {
            
           selectedBackground.backgroundColor=[UIColor colorWithHexString:@"ffa50a"];
            
            
            
        }

       //selectedBackground.backgroundColor = [UIColor redColor];
//        [cell setBackgroundView:selectedBackground];
//        [selectedBackground release];
    }
    else
    {
       // [locationLabel setTextColor:[UIColor whiteColor]];
        
        [selectedBackground setBackgroundColor:[UIColor blackColor]];

       [cell setBackgroundView:nil];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // selectedCell = indexPath.row;
    
    [tableView reloadData];
    
    AppDelegate *m_del = [[UIApplication sharedApplication] delegate];
    m_del.isEditButtonSelected = NO;
    NSString *selectedLocationString = [[locatonArray objectAtIndex:indexPath.row] uppercaseString];
    [m_del setLocation:selectedLocationString];
    
    [m_del.locationArray addObject:[[m_del.aroundData objectAtIndex:indexPath.row] objectForKey:@"lat"]];
    [m_del.locationArray addObject:[[m_del.aroundData objectAtIndex:indexPath.row] objectForKey:@"lng"]];
    NSString *st=[[m_del.aroundData objectAtIndex:indexPath.row] objectForKey:@"Name"];
    st=[st uppercaseString];
    [viewCon.aroundYouLabel setText:st];
    
    if ([[[m_del.aroundData objectAtIndex:indexPath.row] objectForKey:@"Address"] isEqual:[NSNull null]])
    {
        [viewCon.rightNowLabel setText:@""];
    }
    else
    {
    NSString *rightNowLbl=[[[[[m_del.aroundData objectAtIndex:indexPath.row] objectForKey:@"Address"] componentsSeparatedByString:@","] objectAtIndex:0]uppercaseString];
    [viewCon.rightNowLabel setText:rightNowLbl];    
    }
    
    [m_del.bottomBarData replaceObjectAtIndex:0 withObject:st];
    [m_del setSelectedArondValue:indexPath.row];
    [self arrangeBottomButtons];
    
   
    


    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseEventAndDeals];
    [url release];
        for (int i1=0; i1<[appDelegate.viewsArray count]; i1++) {
            [[appDelegate.viewsArray objectAtIndex:i1] removeFromSuperview];
            [appDelegate.viewsArray removeObjectAtIndex:i1];
    
        }
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 40;
//}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDetails=[NSUserDefaults standardUserDefaults];
    
   // selectedCell = -1;
    
    color = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1];
    
    appDelegate=[[UIApplication sharedApplication]delegate];
    [appDelegate.editViewArray addObject:self.view];
    locatonArray = [[NSMutableArray alloc] initWithCapacity:0];

    
    
    for (int i=0; i<[appDelegate.aroundData count]; i++) {
        [locatonArray addObject:[[appDelegate.aroundData objectAtIndex:i] objectForKey:@"Name"]];
      
        
    }
    
    for (int i=0; i<[appDelegate.aroundData count]; i++) {
        if ([[[[appDelegate.aroundData objectAtIndex:i] objectForKey:@"Name"] lowercaseString] isEqualToString:[appDelegate.viewController.locationButton.titleLabel text]]) {
            selectedCell=i;
            break;
        }
    }
            //[locationTable.layer setBorderColor:color.CGColor];
    
    
    
   colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];
    
    
    
    if (colorVal==1) {
        
        [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"a5e1ff"].CGColor];
        
        
        
        
    }
    
    else if(colorVal==2)
    {
        [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"fff587"].CGColor];

       
        
    }
    
    
    else if (colorVal==3)
    {
      
         [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"ffa50a"].CGColor];
        

    }
    
    
    else if (colorVal ==4)
        
    {
        [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"2e3f92"].CGColor];
        

    }
    
    
    
    else if(colorVal ==5)
    {
         [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"ffc8f5"].CGColor];

        

    }
    
    
    else if (colorVal ==6)
    {
        
        [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"ff0000"].CGColor];

        
    }
    else 
    {
        
        [locationTable.layer setBorderColor:[UIColor colorWithHexString:@"ffa50a"].CGColor];

        
    }
    [locationTable.layer setBorderWidth:4.0f];
    
    // Do any additional setup after loading the view from its nib.
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
-(void)arrangeBottomButtons{
    for (int i1=0; i1<3; i1++) {
        if (i1==0) {
            [appDelegate.viewController.editButton setFrame:CGRectMake(550, 8, 29, 38)];
            [appDelegate.viewController.radiusLine setFrame:CGRectMake(appDelegate.viewController.editButton.frame.origin.x-6, 21, 1, 12)];
        }
        else if(i1==1){
            
            [appDelegate.viewController.distanceButton setFrame:CGRectMake(appDelegate.viewController.radiusLine.frame.origin.x-44, 8, 40, 38)];
            
            
        }
        else if(i1==2){
            NSString *radiusString;
            radiusString=[appDelegate.viewController.distanceButton.titleLabel text];
            if ([radiusString length]==5) {
                [appDelegate.viewController.locationLine setFrame:CGRectMake(appDelegate.viewController.distanceButton.frame.origin.x+3, 21, 1, 12)];
            }
            else if ([radiusString length]==6) {
                [appDelegate.viewController.locationLine setFrame:CGRectMake(appDelegate.viewController.distanceButton.frame.origin.x-2, 21, 1, 12)];
            }
            else if ([radiusString length]==7) {
                [appDelegate.viewController.locationLine setFrame:CGRectMake(appDelegate.viewController.distanceButton.frame.origin.x-5, 21, 1, 12)];
            }
            
            
            if ([appDelegate.viewController.locationButton.titleLabel.text length]<25) {
                [appDelegate.viewController.locationButton setFrame:CGRectMake(appDelegate.viewController.locationLine.frame.origin.x-205, 8, 200, 38)];
                for (UIView *v in appDelegate.viewController.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]) {
                        [v removeFromSuperview];
                    }
                }
                
            }
            
            else{
                MarqueeLabel *continuousLabel2 ;
                for (UIView *v in appDelegate.viewController.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]) {
                        [v removeFromSuperview];
                    }
                }
                
                continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(appDelegate.viewController.locationLine.frame.origin.x-100, 17, 100, 20) rate:50.0f andFadeLength:10.0f];
                
                
                continuousLabel2.marqueeType = MLContinuous;
                // continuousLabel2.continuousMarqueeSeparator = @"  |SEPARATOR|  ";
                continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
                continuousLabel2.numberOfLines = 1;
                                continuousLabel2.opaque = YES;
                //                continuousLabel2.enabled = YES;
                continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
                continuousLabel2.textAlignment = UITextAlignmentRight;
                
                
                if (colorVal==1) {
                    
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"739db2"];
                    
                }
                
                else if(colorVal==2)
                {
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"b2ab5e"];
                    
                    
                    
                    
                }
                
                
                else if (colorVal==3)
                {
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"ffa50a"];
                    
                    
                    
                }
                
                
                else if (colorVal ==4)
                    
                {
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"202c66"];
                    
                }
                
                
                
                else if(colorVal ==5)
                {
                    
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"b28cab"];
                    
                    
                }
                
                
                else if (colorVal ==6)
                {
                    
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"b20000"];
                    
                    
                    
                }
                
                else
                {
                    
                    continuousLabel2.textColor=[UIColor colorWithHexString:@"ffa50a"];
                    
                    
                    
                }
//                continuousLabel2.backgroundColor = [UIColor clearColor];
                continuousLabel2.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.000];
                continuousLabel2.text = appDelegate.viewController.locationButton.titleLabel.text;
                [appDelegate.viewController.locationButton setTitle:@"" forState:UIControlStateNormal];
                
                [appDelegate.viewController.bottomBar addSubview:continuousLabel2];
                [appDelegate.viewController.bottomBar sendSubviewToBack:continuousLabel2];
                
            }

            
            
        }
    }
}
@end
