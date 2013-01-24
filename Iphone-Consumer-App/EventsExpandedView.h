//
//  EventsExpandedView.h
//  NowFloatsv1
//
//  Created by pravasis on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarViewController.h"
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FbGraph.h"
#import "FbGraphFile.h"
#import "AppDelegate.h"

@class CompassViewController;
@interface EventsExpandedView : UIViewController<UIAccelerometerDelegate,MFMessageComposeViewControllerDelegate>
{
    IBOutlet UIScrollView *bottomBar;
    //BottomBarViewController *bottomBar;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    UIColor *color;
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIImageView *eventImageView;
    IBOutlet UILabel *eventTextLabel;
    IBOutlet UITextView *eventTextView;
    IBOutlet UITextView *eventDescriptionText;
    IBOutlet UILabel *dateandTimeValidityLabel;
    IBOutlet UILabel *costLabel;
    IBOutlet UIButton *phoneButton;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *addressLabel;
    int i;
    NSTimer *timer1;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    NSMutableDictionary *dic;
    IBOutlet UIImageView *pointerView;
    IBOutlet UIButton *urlButton;
    UIImage *img;
    NSDate *latestDate;
    CompassViewController *compass;
    UIAccelerometer *accelerometer;
    double azimutAngle;
    NSString *fullMonth;
    
    IBOutlet UIView *shareView;
    FbGraph *fbGraph;
    
    IBOutlet UIView *belowView;
    BOOL isShare;
    AppDelegate *appDelegate;
    
}


@property (nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic,retain) UIImage *img;

-(IBAction)goBack:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)callPhone:(id)sender;
-(IBAction)urlButtonClicked:(id)sender;
-(IBAction)shareButtonClicked:(id)sender;
//social

-(IBAction)socialNetworkButtonsClicked:(id)sender;
- (void)postInAppFacebook;
-(void)displayComposerSheet;
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error ;
-(void)launchMailAppOnDevice;
-(IBAction) sendInAppSMS:(id) sender;
-(IBAction)addToCalendar:(id)sender;
-(void)deallocate;
-(void)deallocateForHome;

@end
