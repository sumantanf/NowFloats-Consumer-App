//
//  EventViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsExpandedView.h"
#import "BottomBarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "EditController.h"
@interface EventViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate>
{
    //NSURLConnectionDelegate
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    UIColor *color;
   IBOutlet  UIScrollView *bottomBar;
    //BottomBarViewController *bottomBar;
    NSMutableArray *eventsArray;
    
    NSMutableDictionary *eventDictionary;
    EventsExpandedView *exp;
    
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;
    NSMutableArray *pickerDataArray;
    NSUserDefaults *userDefaults_event;
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *cancelButton;
    int i;
    NSTimer *timer1;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    AppDelegate *appDelegate;
     NSMutableArray  *imageData;
    IBOutlet UIButton *nearLocation;

    int CurrentVal;
    NSMutableData *data;
    IBOutlet UITableView *eventsTableView;
    NSMutableData *eventData;
    UIButton *btnDeco;
    int isFromTap;
    IBOutlet UIActivityIndicatorView *prograssBar,*mainActivity;
    IBOutlet UILabel *mainLabel;

}

-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)sort:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)editButtonClicked:(id)sender;
-(void)deallocate;
-(void)deallocateForHome;
@end
