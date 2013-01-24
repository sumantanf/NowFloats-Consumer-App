//
//  EditRadiusController.m
//  NowFloats_v1
//
//  Created by pravasis on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditRadiusController.h"
#import "AppDelegate.h"
#import "UrlInfo.h"
#import "ViewController.h"
#import "UIColor+HexaString.h"
#import "MarqueeLabel.h"


@implementation EditRadiusController
@synthesize viewCon;
@synthesize fromHome;
@synthesize bottomScrollView;
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

-(IBAction)distanceButtonClicked:(id)sender
{
    var=1;
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [viewCon.dealsCountlabel setText:@""];
    [viewCon.eventsCountLael setText:@""];
    [viewCon.thoughtsCountLabel setText:@""];
        
    
    [viewCon.dealActivity startAnimating];
    [viewCon.eventActivity startAnimating];
    [viewCon.thoughtActivity startAnimating];
    
    app.radiusVal=0.00;
    app.isEditButtonSelected = NO;
    
    
    [app.dealsData removeAllObjects];
    [app.eventsData removeAllObjects];
    [app.thoughsTextFloats removeAllObjects];
    
    float selectedRadius;
    
    if([sender tag] == 0)
    {
        selectedRadius=20;
//        [app setdistance:20];
//        [app setRadiusVal:20];
    }
    else if([sender tag] == 1)
    {       
        selectedRadius=10; 
//        [app setdistance:10];
//        [app setRadiusVal:10];
    }
    else if([sender tag] == 2)
    {
        selectedRadius=5;
//        [app setdistance:5];
//        [app setRadiusVal:5];
    }
    else if([sender tag] == 3)
    {
        selectedRadius=3;
        
//        [app setdistance:3];
//        [app setRadiusVal:3];
    }
    else if([sender tag] == 4)
    {
        selectedRadius=2;
//        [app setdistance:2];
//        [app setRadiusVal:2];
    }
    else if([sender tag] == 5)
    {
        selectedRadius=1;
//        [app setdistance:1];
//        [app setRadiusVal:1];
    }
    else if([sender tag] == 6)
    {
        selectedRadius=0.5;
//        [app setdistance:0.5];
//        [app setRadiusVal:0.5];
    }
      
    if (selectedRadius<app.radiusVal) {
        //Events Data
        
        NSMutableArray *temp=[[NSMutableArray alloc] initWithCapacity:1];
        for (int i1=0; i1<[app.eventsData count]; i1++) {
            if ([[[app.eventsData objectAtIndex:i1] objectForKey:@"CalculateRadius"] floatValue]<=selectedRadius) {
                [temp addObject:[app.eventsData objectAtIndex:i1]];
            }        
        }
    if ([app.eventsData count]) {
        [app.eventsData removeAllObjects];
        for (int i1=0; i1<[temp count]; i1++) {
            [app.eventsData addObject:[temp objectAtIndex:i1]];
            
        }
        [temp removeAllObjects];
    }
        [app.viewController.eventsCountLael setText:[NSString stringWithFormat:@"%d",app.eventCount]];
        [viewCon.eventActivity stopAnimating];
        
        //Deals Data
        for (int i1=0; i1<[app.dealsData count]; i1++) {
            if ([[[app.dealsData objectAtIndex:i1] objectForKey:@"CalculateRadius"] floatValue]<=selectedRadius) {
                [temp addObject:[app.dealsData objectAtIndex:i1]];
            }        
        }
        if ([app.dealsData count]) {
            [app.dealsData removeAllObjects];
            for (int i1=0; i1<[temp count]; i1++) {
                [app.dealsData addObject:[temp objectAtIndex:i1]];
                
            }
            [temp removeAllObjects];
        }
        [app.viewController.dealsCountlabel setText:[NSString stringWithFormat:@"%d",app.dealCount]];
        [viewCon.dealActivity stopAnimating];
        //Around Data
        for (int i1=0; i1<[app.aroundData count]; i1++) {
            if ([[[app.aroundData objectAtIndex:i1] objectForKey:@"CalculateRadius"] floatValue]<=selectedRadius) {
                [temp addObject:[app.aroundData objectAtIndex:i1]];
            }        
        }
        if ([app.aroundData count]) {
            [app.aroundData removeAllObjects];
            for (int i1=0; i1<[temp count]; i1++) {
                [app.aroundData addObject:[temp objectAtIndex:i1]];
                
            }
            [temp removeAllObjects];
        }

        
        
        //Thoughts Data
        NSMutableArray *temp1=[[NSMutableArray alloc] initWithCapacity:1];
        for (int i1=0; i1<[app.thoughsTextFloats count]; i1++) {
            if ([[[app.thoughsTextFloats objectAtIndex:i1] objectForKey:@"CalculateRadius"] floatValue]<=selectedRadius) {
                [temp addObject:[app.thoughsTextFloats objectAtIndex:i1]];
                [temp1 addObject:[app.thoughtsComments objectAtIndex:i1]];
            }        
        }
        if ([app.thoughsTextFloats count]) {
            [app.thoughsTextFloats removeAllObjects];
            [app.thoughtsComments removeAllObjects];
            for (int i1=0; i1<[temp count]; i1++) {
                [app.thoughsTextFloats addObject:[temp objectAtIndex:i1]];
                [app.thoughtsComments addObject:[temp1 objectAtIndex:i1]];
                
            }
            [temp removeAllObjects];
            [temp1 removeAllObjects];
        }

        [app.viewController.thoughtsCountLabel setText:[NSString stringWithFormat:@"%d",app.textCount]];
        [viewCon.thoughtActivity stopAnimating];
        //Thoughts Data
   
        for (int i1=0; i1<[app.thoughsImageFloats count]; i1++) {
            if ([[[app.thoughsImageFloats objectAtIndex:i1] objectForKey:@"CalculateRadius"] floatValue]<=selectedRadius) {
                [temp addObject:[app.thoughsImageFloats objectAtIndex:i1]];
                //[temp1 addObject:[app.thoughtsComments objectAtIndex:i1]];
            }        
        }
        if ([app.thoughsImageFloats count]) {
            [app.thoughsImageFloats removeAllObjects];
            for (int i1=0; i1<[temp count]; i1++) {
                [app.thoughsImageFloats addObject:[temp objectAtIndex:i1]];
                //[app.thoughtsComments addObject:[temp1 objectAtIndex:i1]];
                
            }
            [temp removeAllObjects];
            //[temp1 removeAllObjects];
        }
        [app setdistance:selectedRadius];
        [app setRadiusVal:selectedRadius];

        
    }
    else {
        [app setdistance:selectedRadius];
        [app setRadiusVal:selectedRadius];
        app.IsFromEditController=YES;
//        UrlInfo *url=[[UrlInfo alloc] init];
//        [url parseAllData];
//        [url release];
        
        UrlInfo *url=[[UrlInfo alloc] init];
        [url parseData:[NSNumber numberWithInt:99]];
        [url release];
    }
    for (int i1=0; i1<[app.editViewArray count]; i1++) {
        [[app.editViewArray objectAtIndex:[app.editViewArray count]-1] removeFromSuperview];
        [app.editViewArray removeObjectAtIndex:[app.editViewArray count]-1];
    }
    
    
    if (fromHome) {
        for(int i=0;i<[app.viewsArray count];i++)
        {
            [[app.viewsArray objectAtIndex:i] removeFromSuperview];
        }
    }
    else {
        [app arrangeBottomButtons:bottomScrollView];
    }
    
    [app clearArray];

    [self arrangeBottomButtons];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad   ];
    [app.editViewArray addObject:self.view];
    
     userDetails=[NSUserDefaults standardUserDefaults];
    
        
    
    colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];
    
    
    
    if (colorVal==1) {
        
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"739db2"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"739db2"]];
        [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"739db2"]];
        
        
        
    }
    
    else if(colorVal==2)
    {
        
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"b2ab5e"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"b2ab5e"]];
        [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"b2ab5e"]];
        
        
             
    }
    
    
    else if (colorVal==3)
    {
        
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"ffa50a"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"ffa50a"]];
         [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"ffa50a"]];
        

            
    }
    
    
    else if (colorVal ==4)
        
    {
        
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"202c66"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"202c66"]];
        [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"202c66"]];
        
    }
    
    
    
    else if(colorVal ==5)
    {
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"b28cab"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"b28cab"]];
        [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"b28cab"]];

        
        
        
    }
    
    
    else if (colorVal ==6)
    {
        
        
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
        [btn2   setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
        [btn3  setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
        [btn5   setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
        [btn10  setBackgroundColor:[UIColor  colorWithHexString:@"b20000"]];
        [btn20  setBackgroundColor:[UIColor  colorWithHexString:@"b20000"]];
        [btnp5 setBackgroundColor:[UIColor  colorWithHexString:@"b20000"]];
        
        
        
    }
    

    

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
        
    
    [btn20 release];
    btn20 = nil;
    [btn10 release];
    btn10 = nil;
    [btn5 release];
    btn5 = nil;
    [btn3 release];
    btn3 = nil;
    [btn2 release];
    btn2 = nil;
    [btn1 release];
    btn1 = nil;
    [btnp5 release];
    btnp5 = nil;
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
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
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
            
            for (UIView *v in appDelegate.viewController.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]) {
                    [v removeFromSuperview];
                }
            }
            if ([appDelegate.viewController.locationButton.titleLabel.text length]<25) {
                [appDelegate.viewController.locationButton setFrame:CGRectMake(appDelegate.viewController.locationLine.frame.origin.x-205, 8, 200, 38)];
                
            }
            
            else{
                MarqueeLabel *continuousLabel2 ;
                
                continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(appDelegate.viewController.locationLine.frame.origin.x-100, 17, 100, 20) rate:50.0f andFadeLength:10.0f];
                
                
                continuousLabel2.marqueeType = MLContinuous;
             
                continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
                continuousLabel2.numberOfLines = 1;
             
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

                continuousLabel2.backgroundColor = [UIColor clearColor];
                continuousLabel2.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.000];
                continuousLabel2.text = appDelegate.viewController.locationButton.titleLabel.text;
                //[appDelegate.viewController.locationButton setTitle:@"" forState:UIControlStateNormal];
                [appDelegate.viewController.bottomBar addSubview:continuousLabel2];
                [appDelegate.viewController.bottomBar sendSubviewToBack:continuousLabel2];
                
            }
            
            
        }
    }
}
- (void)dealloc {
    [btn20 release];
    [btn10 release];
    [btn5 release];
    [btn3 release];
    [btn2 release];
    [btn1 release];
    [btnp5 release];
    [super dealloc];
}
@end
