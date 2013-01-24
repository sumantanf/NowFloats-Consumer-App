//
//  DealsExpandedViewMain.h
//  NowFloatsv1
//
//  Created by pravasis on 17/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsExpandedView.h"
#import "BottomBarViewController.h"
#import "StoreFrontViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StoreViewMap.h"
#import "AppDelegate.h"
@class CompassViewController;
@class DealsViewController;
@interface DealsExpandedViewMain : UIViewController
{
    IBOutlet UIImageView *dayimg;
    IBOutlet UILabel *lblday;
    IBOutlet UILabel *dealsLocationLabel;
    IBOutlet UILabel *descriptionBackgroundLabel;
    IBOutlet UITextView *dealsTitleLabel;
    IBOutlet UILabel *dealsDescriptionLabel;
    IBOutlet UIButton *dealsCatchButton;
    IBOutlet UILabel *pointerBackground;
    IBOutlet UIView *dealsValidView;
    UIView *dealsImageViews;
    NSMutableArray *dealsImagesArray;
    BOOL isdealsButtonClicked;
    UIView *imageHoldView;
    
    IBOutlet UILabel *lbltitlebg;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    //UIScrollView *bottomBar;
    BottomBarViewController *bottomBar;
    BOOL isShareButtonClicked;
    UIView *shareView;
    DealsExpandedView *m_dealsExpanded;
    
    NSDictionary *dic;
    IBOutlet UILabel *dateLaebel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UIImageView *pointerView;
    IBOutlet UIScrollView *bottomNewBar;
    StoreFrontViewController *storeViewController;
    NSMutableArray *hideMessages;
    
    IBOutlet UIView *pickerView;
    int CurrentVal;
    UITableView *dealsTableview;
    DealsViewController *deal;
    AppDelegate *appDelegate;
    CompassViewController *compass;

}


@property (nonatomic, retain) NSDictionary *dic;
@property (nonatomic, retain) UITableView *dealsTableview;

- (IBAction)saveButtonClicked:(id)sender;

-(IBAction)clickedOnDeals:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)share:(id)sender;
-(IBAction)catchTheDeal:(id)sender;
-(IBAction)merchantNameButtonClicked:(id)sender;
-(IBAction)mapButtonClicked:(id)sender;
-(IBAction)hideButtonClicked:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)cancel:(id)sender;
-(void)deallocate;
-(void)deallocateForStoreController;

@end
