//
//  SearchViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    
    fontForBottomBar = [UIFont boldSystemFontOfSize:12.0f];
    
    color = [UIColor colorWithRed:59/250.0f green:27/250.0f blue:6/250.0f alpha:1.0];
    
    /*bottomBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 420, 320, 40)];
     
     [bottomBar setShowsHorizontalScrollIndicator:NO];
     [bottomBar setPagingEnabled:YES];
     //[bottomBar setContentSize:CGSizeMake(640, 40)];
     [bottomBar setContentSize:CGSizeMake(592, 50)];
     [bottomBar setBackgroundColor:[UIColor blackColor]];
     [self.view addSubview:bottomBar];
     bottomBar.frame = m_appDel.bottomBarFrame;*/
    
    bottomBar = [[BottomBarViewController alloc] initWithNibName:@"BottomBarViewController" bundle:nil];
    [bottomBar.view setFrame:CGRectMake(0, 410, 320, 50)];
    
    [bottomBar.bottomScrollView setShowsHorizontalScrollIndicator:NO];
    [bottomBar.bottomScrollView setPagingEnabled:YES];
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
    [button1.titleLabel setFont:fontForBottomBar];
    [bottomBar.bottomScrollView addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button2 setTitle:@"Option2" forState:UIControlStateNormal];
    [button2 setTitleColor:color forState:UIControlStateNormal];
    [button2.titleLabel setFont:fontForBottomBar];
    
    [button2 setFrame:CGRectMake(73, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button2];
    
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button3 setTitle:@"Option3" forState:UIControlStateNormal];
    [button3 setTitleColor:color forState:UIControlStateNormal];
    [button3.titleLabel setFont:fontForBottomBar];
    
    [button3 setFrame:CGRectMake(145, 7, 70 ,36)];
    [bottomBar.bottomScrollView addSubview:button3];
    
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button4 setTitle:@"BACK" forState:UIControlStateNormal];
    [button4.titleLabel setFont:fontForBottomBar];
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
    
    img1 = [[UIImageView alloc] initWithFrame:CGRectMake(322, 19, 11, 12)];
    [img1 setImage:[UIImage imageNamed:@"t1.png"]];
    [img1 setHidden:YES];
    [bottomBar.bottomScrollView addSubview:img1];
    
    img2 = [[UIImageView alloc] initWithFrame:CGRectMake(337, 19, 11, 12)];
    [img2 setImage:[UIImage imageNamed:@"t1.png"]];
    [img2 setHidden:YES];
    [bottomBar.bottomScrollView addSubview:img2];
    
    img3 = [[UIImageView alloc] initWithFrame:CGRectMake(352, 19, 11, 12)];
    [img3 setImage:[UIImage imageNamed:@"t1.png"]];
    [img3 setHidden:YES];
    [bottomBar.bottomScrollView addSubview:img3];
    
    img4 = [[UIImageView alloc] initWithFrame:CGRectMake(365, 19, 11, 12)];
    [img4 setImage:[UIImage imageNamed:@"t1.png"]];
    [img4 setHidden:YES];
    [bottomBar.bottomScrollView addSubview:img4];
    
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
    
   // [self animateImages];
    
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
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    if(isCategoryClicked)
    {
        [diningClickedView removeFromSuperview];
        isCategoryClicked = NO;
        [diningImageView setImage:[UIImage imageNamed:@""]];
       
    }
    else 
    {
        [self.view removeFromSuperview];
        m_appDel.isSearchButtonSelected = NO;
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
-(IBAction)diningButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    [shoppingImageView setImage:[UIImage imageNamed:@""]];
    [attractionsImageView setImage:[UIImage imageNamed:@""]];
    [entertainmentImageView setImage:[UIImage imageNamed:@""]];
    [convenienceImageView setImage:[UIImage imageNamed:@""]];
    [emergencyImageView setImage:[UIImage imageNamed:@""]];
    
    if (!isCategoryClicked) {
        [self.view addSubview:diningClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:diningClickedView];
    }
//    if(!isCategoryClicked)
//    {
//        diningClickedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
//        [diningClickedView setBackgroundColor:color];
//        
//        UIButton *barsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [barsButton setTitle:@"bars" forState:UIControlStateNormal];
//        [barsButton setFrame:CGRectMake(0, 0, 150, 90)];
//        //[barsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:25.0f]];//Helvetica Neue UltraLight 18.0
//        //[barsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25.0f]]; 
//        [barsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]]; 
//        
//        [diningClickedView addSubview:barsButton];
//        
//        UIButton *cafesButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cafesButton setTitle:@"cafes" forState:UIControlStateNormal];
//        [cafesButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];//Helvetica Neue UltraLight 18.0
//        [cafesButton setFrame:CGRectMake(161, 0, 150, 90)];
//        [diningClickedView addSubview:cafesButton];
//        
//        UIButton *restaurantsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [restaurantsButton setTitle:@"restaurants" forState:UIControlStateNormal];
//        [restaurantsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];//Helvetica Neue UltraLight 18.0
//        [restaurantsButton setFrame:CGRectMake(0, 100, 150, 90)];
//        [diningClickedView addSubview:restaurantsButton];
//        
//        UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [allButton setTitle:@"all" forState:UIControlStateNormal];
//        [allButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];//Helvetica Neue UltraLight 18.0
//        [allButton setFrame:CGRectMake(161, 100, 150, 90)];
//        [allButton addTarget:self action:@selector(allButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [diningClickedView addSubview:allButton];
//        
//        UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 2)];
//        [horizontalLine setImage:[UIImage imageNamed:@"horizontaldivider.png"]];
//        [diningClickedView addSubview:horizontalLine];
//        [horizontalLine release];
//        
//        UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(160, 0, 2, 202)];
//        [verticalLine setImage:[UIImage imageNamed:@"verticaldivider.png"]];
//        [diningClickedView addSubview:verticalLine];
//        [verticalLine release];
        
//        [self.view addSubview:diningClickedView];
//        isCategoryClicked  = YES;
//    }
}

-(IBAction)allButtonClicked:(id)sender
{
    searchPageController = [[SearchPageViewController alloc] initWithNibName:@"SearchPageViewController" bundle:nil];
    
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    [m_appDel.viewsArray addObject:searchPageController.view];
    
    [self.view addSubview:searchPageController.view];
}

-(IBAction)shoppingButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@""]];
    [shoppingImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    [attractionsImageView setImage:[UIImage imageNamed:@""]];
    [entertainmentImageView setImage:[UIImage imageNamed:@""]];
    [convenienceImageView setImage:[UIImage imageNamed:@""]];
    [emergencyImageView setImage:[UIImage imageNamed:@""]];
    if (!isCategoryClicked) {
        [self.view addSubview:shopingClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:shopingClickedView];
    }
}

-(IBAction)attractionButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@""]];
    [shoppingImageView setImage:[UIImage imageNamed:@""]];
    [attractionsImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    [entertainmentImageView setImage:[UIImage imageNamed:@""]];
    [convenienceImageView setImage:[UIImage imageNamed:@""]];
    [emergencyImageView setImage:[UIImage imageNamed:@""]];
    if (!isCategoryClicked) {
        [self.view addSubview:attractionClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:attractionClickedView];
    }
}

-(IBAction)entertainmentButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@""]];
    [shoppingImageView setImage:[UIImage imageNamed:@""]];
    [attractionsImageView setImage:[UIImage imageNamed:@""]];
    [entertainmentImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    [convenienceImageView setImage:[UIImage imageNamed:@""]];
    [emergencyImageView setImage:[UIImage imageNamed:@""]];
    
    if (!isCategoryClicked) {
        [self.view addSubview:entertainmentClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:entertainmentClickedView];
    }
}

-(IBAction)convenienceButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@""]];
    [shoppingImageView setImage:[UIImage imageNamed:@""]];
    [attractionsImageView setImage:[UIImage imageNamed:@""]];
    [entertainmentImageView setImage:[UIImage imageNamed:@""]];
    [convenienceImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    [emergencyImageView setImage:[UIImage imageNamed:@""]];
    if (!isCategoryClicked) {
        [self.view addSubview:convenienceClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:convenienceClickedView];
    }
}

-(IBAction)emergencyButtonClicked:(id)sender
{
    [diningImageView setImage:[UIImage imageNamed:@""]];
    [shoppingImageView setImage:[UIImage imageNamed:@""]];
    [attractionsImageView setImage:[UIImage imageNamed:@""]];
    [entertainmentImageView setImage:[UIImage imageNamed:@""]];
    [convenienceImageView setImage:[UIImage imageNamed:@""]];
    [emergencyImageView setImage:[UIImage imageNamed:@"selection_glow.png"]];
    if (!isCategoryClicked) {
        [self.view addSubview:emergencyClickedView];
        isCategoryClicked=YES;
    }
    else {
        [[self.view viewWithTag:5] removeFromSuperview];
        [self.view addSubview:emergencyClickedView];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)dinningInnerButtonClicked:(id)sender{
    
    //UIButton *b=(UIButton *)sender;
    
    
}

@end
