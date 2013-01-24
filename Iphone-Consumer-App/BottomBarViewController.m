//
//  BottomBarViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BottomBarViewController.h"
#import "AppDelegate.h"

@interface BottomBarViewController ()

@end

@implementation BottomBarViewController

@synthesize bottomScrollView;
@synthesize OButton;

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)gotoHomePage:(id)sender
{
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    for(int i=0;i<[m_appDel.viewsArray count];i++)
    {
        [[m_appDel.viewsArray objectAtIndex:i] removeFromSuperview];
    }
    [m_appDel.viewsArray removeAllObjects];
    
    [m_appDel setIsEditButtonSelected:NO];
    [m_appDel setIsNameViewSelected:NO];
    [m_appDel setIsSearchButtonSelected:NO];
    [m_appDel setIsThoughtViewSelected:NO];
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

@end
