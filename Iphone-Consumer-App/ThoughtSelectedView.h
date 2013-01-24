//
//  ThoughtSelectedView.h
//  NowFloats_v1
//
//  Created by pravasis on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AnimationController_thoughts.h"
#import "ThoughtsExpandedView.h"

#import "ThoughtsViewController.h"

@interface ThoughtSelectedView : UIViewController
{
    AppDelegate *appDelegate;
    IBOutlet UILabel *expandLabel,*airLabel,*sinkLabel;
    IBOutlet UIImageView *messageImageView;
    ThoughtsViewController *m_thoughtController;
    IBOutlet UIView *displayImageView;
    AnimationController_thoughts *m_animationController;
    ThoughtsExpandedView *expandedView;
    int sinkVal,airVal;
    IBOutlet UILabel *sinkNumLabel,*airNumLabel;
    IBOutlet UIButton *expandButton,*sinkButton,*airButton;
    int air,sink;

    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    UIColor *color;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    int i;
    NSTimer *timer1;
   
    int selectedAvatar;
    int timerVal;
    int sinkingVal;
   
    
    IBOutlet UIImageView *airBackGroundImage;
    IBOutlet UIImageView *sinkBackGroundImage;
    NSMutableArray *ownerandText;

    IBOutlet UIView *airedview;
    IBOutlet UILabel *airedLabelView;
    NSString *ownerDetails;
    int selectedVal;
    
    BOOL shouldContinueBlinking;
    NSMutableArray *thoughtsRef;
   
}

@property (nonatomic,retain) UIImageView *messageImageView;
@property (nonatomic,retain) ThoughtsViewController *m_thoughtController;
@property (nonatomic,retain) UIView *displayImageView;
@property (nonatomic,retain)     NSString *ownerDetails;



@property (nonatomic) int selectedAvatar;
@property (nonatomic,retain) NSMutableArray *ownerandText;
@property (nonatomic,retain) NSMutableArray *thoughtsRef;


-(IBAction)AirButtonClicked:(id)sender;
-(IBAction)ExpandButtonClicked:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)gotoBack:(id)sender;
-(IBAction)SinkButtonClicked:(id)sender;
-(void)addSinkImage:(NSTimer *)timer;
-(void)addAirImage:(NSTimer *)timer;
-(void)removeairedView;
@end
