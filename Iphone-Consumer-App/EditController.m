//
//  EditController.m
//  NowFloats_v1
//
//  Created by pravasis on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "SettingsViewCon.h"
#import "UIColor+HexaString.h"


@implementation EditController
@synthesize viewCon;
@synthesize bottomScrollView;
@synthesize fromHome;
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

-(IBAction)EditLocation:(id)sender
{
    [self.view setAlpha:1];
    editLocationController = [[EditLocationController alloc] initWithNibName:@"EditLocationController" bundle:nil];
    [editLocationController setViewCon:viewCon];
    if (fromHome) {
        [editLocationController setFromHome:1];
    }
    else {
        [editLocationController setBottomScrollView:bottomScrollView];
    }
    
    [editLocationController.view setFrame:CGRectMake(0, 0, 320, 410)];
    
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    [m_appDel.viewsArray addObject:editLocationController.view];

    
    [self.view addSubview:editLocationController.view];
}

-(IBAction)EditRadius:(id)sender
{
    [self.view setAlpha:1.0f];
    editRadiusController = [[EditRadiusController alloc] initWithNibName:@"EditRadiusController" bundle:nil];
    [editRadiusController setViewCon:viewCon];
    if (fromHome) {
         [editRadiusController setFromHome:1];
    }
    else {
        [editRadiusController setBottomScrollView:bottomScrollView];
    }
    [editRadiusController.view setFrame:CGRectMake(0, 0, 320, 410)];
    
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    [m_appDel.viewsArray addObject:editRadiusController.view];

    [self.view addSubview:editRadiusController.view];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    userDetails=[NSUserDefaults standardUserDefaults];
        

    int colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];
    
    
    
    if (colorVal==1) {
        
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
        
    }
    
    else if(colorVal==2)
    {
    
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
        [editlocatio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [editradius setBackgroundColor: [UIColor colorWithHexString:@"fff587"]];
        [editradius setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    
    }
    
    
    else if (colorVal==3)
    {
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
    
    
    }
 
    
    else if (colorVal ==4)
        
    {
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
        
    }
    
    
    
    else if(colorVal ==5)
    {
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
        

    }
    
    
    else if (colorVal ==6)
    {
    
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
    
    
    }
    else {
        [editlocatio setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        [editradius setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
        

    }
    
    
    // Do any additional setup after loading the view from its nib.
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (fromHome) {
        AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
        m_appDel.isEditButtonSelected = NO;
        
        for(int i=0;i<[m_appDel.viewsArray count];i++)
        {
            [[m_appDel.viewsArray objectAtIndex:i] removeFromSuperview];
        }
        
        [m_appDel clearArray];
        
        [self.view removeFromSuperview];
    }
    else {
        [self.view removeFromSuperview];
    }
   
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

@end
