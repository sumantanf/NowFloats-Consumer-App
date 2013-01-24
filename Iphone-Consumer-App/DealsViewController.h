//
//  DealsViewController.h
//  NowFloats_v1
//
//  Created by pravasis on 01/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsExpandedViewMain.h"
#import "BottomBarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "EditController.h"
#import "StoreViewController.h"


@interface DealsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    //BottomBarViewController *bottomBar;
    IBOutlet UIScrollView *bottomBar;


    NSMutableArray *dealsArray;
    DealsExpandedViewMain *dealsExpandedViewMain;
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;
    NSMutableArray *pickerDataArray;
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *cancelButton;
    NSUserDefaults *userDefaults;
    int i;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    AppDelegate *appDelegate;
    int CurrentVal;
    NSMutableData *data;
    IBOutlet UITableView *dealsTableView;
    EditController *editController;
    StoreViewController *storeViewController;
    UIButton *btnDeco;
    int isFromTap;
    IBOutlet UIActivityIndicatorView *prograssBar;
    NSMutableArray *dealsInfo;
    
    IBOutlet UIActivityIndicatorView *dealLoadingActivity,*mainActivity;
    
    int dealFlag;
    NSMutableArray *arr;
    IBOutlet UILabel *mainLabel;

}



 //@property(nonatomic,retain) IBOutlet UITableView *dealsTableView;
-(NSArray *)getDealArray:(id)val;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)sort:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
-(void)animateImages;
-(IBAction)editButtonClicked:(id)sender;
-(IBAction)storeButtonClicked:(id)sender;
-(void)readDealsInfo;
-(void)getData:(NSMutableArray *)dataarray;
-(void)deallocate;
-(void)deallocateForHome;

@end
