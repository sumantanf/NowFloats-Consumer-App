//
//  ThoughtsViewController.h
//  NowFloats_v1
//
//  Created by pravasis on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "LoadImagesGridView.h"
#import "EditController.h"
@class ThoughtSelectedView;

@interface ThoughtsViewController : UIViewController <UITableViewDelegate,UIAlertViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *thoughtsTable;
    NSMutableArray *thoughtsArray;
    
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    AppDelegate *appDelegate;
    ThoughtSelectedView *thoughtSelectedView;
   // LoadImagesGridView *gridView;
    UIColor *color;
    int i;
    NSTimer *timer1;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    
    NSMutableArray *ownerandText;
    NSMutableData *data;
    
    //Table View Refresh Variables
    
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    //Sort Attributes
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;
    NSMutableArray *pickerDataArray;
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *cancelButton;
    int CurrentVal;
    int IsFromThought;
    NSString *latestVale;
    IBOutlet UIActivityIndicatorView *prograssBar,*mainBar;
    UIButton *btnDeco;
    
    BOOL isFromFloat;
    NSMutableDictionary *floatDic;
    
    NSMutableArray *thoughtsref;
    
    
    IBOutlet UIImageView *redDotImage;
    
    UIImage *pickingImage;
    
    IBOutlet UILabel *mainLabel;
    
    IBOutlet UIView *activityView;
    NSString *nameString;
}

-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)loadImagesGridView:(id)sender;
-(void)loadcurrentView;
- (NSDate*) getDateFromJSON:(NSString *)dateString;
// Table View refresh 

@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (nonatomic)     BOOL isFromFloat;
@property (nonatomic,retain)     NSMutableDictionary *floatDic;
@property (nonatomic, retain)  UIImage *pickingImage;
@property (nonatomic,retain)    NSString *nameString;



-(IBAction)editButtonClicked:(id)sender;
-(NSDate *)mfDateFromDotNetJSONString:(NSString *)string;

@end
