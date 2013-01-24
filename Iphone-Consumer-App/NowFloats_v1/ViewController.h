//
//  ViewController.h
//  NowFloats_v1
//
//  Created by pravasis on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThoughtsViewController.h"
#import "DealsViewController.h"
#import "EditController.h"
#import "EventViewController.h"
#import "SearchViewController.h"
#import "CreateFloatViewController.h"
#import "LoginViewController.h"

#import "LoginViewController.h"
@class SettingsViewCon;
#import "AppDelegate.h"

#import <CoreLocation/CoreLocation.h>

 UIButton *distanceButton;

@interface ViewController : UIViewController <UIScrollViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    NSString *aroundUrl;

    
    
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *profileButton, *settingsButton, *refreshButton,*OButton;
    ThoughtsViewController *m_thoughtsController;
    DealsViewController *m_dealsController;
    EditController *m_EditController;
    EventViewController *eventController;
    CreateFloatViewController *createFloatController;
    
    float currentOffset;
    UIColor *color;
    
    IBOutlet UIButton *distanceButton;
    IBOutlet UIButton *locationButton;

    CLLocationManager *locationManager;
    IBOutlet UILabel *aroundYouLabel;
    IBOutlet UILabel *rightNowLabel;
    IBOutlet UIImageView *img1,*img2,*img3,*img4;
    NSTimer *timer1;
    int i;
    BOOL stoporNot1,stoporNot2;
    SearchViewController *m_searchController;
    IBOutlet UILabel *dayLabel;
    LoginViewController *loginViewCon;
    IBOutlet UIButton *rightNowButton;
    
    IBOutlet UILabel *dealsCountlabel;
    IBOutlet UILabel *eventsCountLael;
    IBOutlet UILabel *thoughtsCountLabel;
    SettingsViewCon *settingVi;
    IBOutlet UIImageView *backGroundImageView;
     NSTimer *timer;
    int timinngVal;
    IBOutlet UILabel *dollarLabel;
    IBOutlet UIView *parentView;
    IBOutlet UIView *t1;
    IBOutlet UIView *t2;
    IBOutlet UIView *t3;
    IBOutlet UIView *t4;
    IBOutlet UIButton  *searchButton;
    
    IBOutlet UIButton *editButton;
    IBOutlet UIView *locationLine;
    IBOutlet UIView *radiusLine;
    
    IBOutlet UIView *bottomCreateFloat;
    AppDelegate *appDelegate;
    
    IBOutlet UIActivityIndicatorView *dealActivity;
    IBOutlet UIActivityIndicatorView *eventActivity;
    IBOutlet UIActivityIndicatorView *thoughtActivity;
}

@property (nonatomic,retain) UIButton *distanceButton;
@property (nonatomic,retain) UIButton *locationButton;
@property (nonatomic ,retain) IBOutlet UILabel *aroundYouLabel;
@property (nonatomic,retain) UIButton *rightNowButton;
@property (nonatomic ,retain)  IBOutlet UILabel *rightNowLabel;
@property (nonatomic ,retain) IBOutlet UILabel *dealsCountlabel;
@property (nonatomic ,retain) IBOutlet UILabel *eventsCountLael;
@property (nonatomic ,retain) IBOutlet UILabel *thoughtsCountLabel;
@property (nonatomic ,retain) IBOutlet UIImageView *backGroundImageView;
@property (nonatomic ,retain) IBOutlet UILabel *dollarLabel;
@property (nonatomic ,retain) IBOutlet UILabel *dayLabel;
@property (nonatomic ,retain) IBOutlet UIScrollView *bottomBar;
@property (nonatomic ,retain) IBOutlet UIView *parentView;
@property (nonatomic ,retain) IBOutlet IBOutlet UIButton *editButton;
@property (nonatomic ,retain) IBOutlet UIView *locationLine;
@property (nonatomic ,retain) IBOutlet UIView *radiusLine;
@property (nonatomic ,retain)     IBOutlet UIView *bottomCreateFloat;
@property (nonatomic ,retain) IBOutlet UIActivityIndicatorView *dealActivity;
@property (nonatomic ,retain) IBOutlet UIActivityIndicatorView *eventActivity;
@property (nonatomic ,retain) IBOutlet UIActivityIndicatorView *thoughtActivity;

@property (nonatomic) int homeButtonTag;

@property (retain, nonatomic) IBOutlet UIButton *dealbtn;
@property (retain, nonatomic) IBOutlet UIButton *eventbtn;
@property (retain, nonatomic) IBOutlet UIButton *thoughtsbtn;

-(IBAction)loadThoughtsController:(id)sender;
-(IBAction)loadDealsController:(id)sender;
-(IBAction)EditButtonClicked:(id)sender;
-(IBAction)HomeButtonClicked:(id)sender;
-(IBAction)EventsButtonClicked:(id)sender;
-(void)animateImages;
-(IBAction)searchButtonClicked:(id)sender;
-(IBAction)createFloat:(id)sender;

-(IBAction)profileButtonClicked:(id)sender;
-(IBAction)rightNowButtonClicked:(id)sender;
-(IBAction)settingButtonClicked:(id)sender;
-(IBAction)refreshButtonClicked:(id)sender;
-(void)viewMoving;
-(void)arrangeBottomButtons;


@end
