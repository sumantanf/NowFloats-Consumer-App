//
//  DealsExpandedView.h
//  NowFloats_v1
//
//  Created by pravasis on 14/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarViewController.h"
#import "StoreFrontViewController.h"
@class DealsViewController;

@interface DealsExpandedView : UIViewController
{
    IBOutlet UILabel *dealsLocationLabel;
    IBOutlet UILabel *descriptionBackgroundLabel;
    IBOutlet UILabel *dealsTitleLabel;
    IBOutlet UILabel *dealsDescriptionLabel;
    IBOutlet UIButton *dealsCatchButton;
    IBOutlet UILabel *pointerBackground;
    IBOutlet UIView *dealsValidView;
    UIView *dealsImageViews;
    NSMutableArray *dealsImagesArray;
    BOOL isdealsButtonClicked;
    BOOL isImageDisplaying;
    UIView *imageHoldView;
    NSMutableArray *hideMessages;

    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    //UIScrollView *bottomBar;
    BottomBarViewController *bottomBar;
    BOOL isShareButtonClicked;
    UIView *shareView;
    NSMutableDictionary *m_dealsDictionary;
    IBOutlet UIImageView *arrowImage;
    NSString *dealsTitleLabelText;
    NSMutableArray *imageArray;
    IBOutlet UIScrollView *bottomNewBar;
    NSDictionary *dic;
    StoreFrontViewController *storeViewController;
    IBOutlet UILabel *titleLbl;
    
    IBOutlet UIView *pickerView;
    int CurrentVal;
    UITableView *dealsTableview;
    DealsViewController *deal;
    

}

@property (nonatomic,retain) NSString *dealsTitleString;
@property (nonatomic,retain) NSMutableDictionary *m_dealsDictionary;
@property (nonatomic,retain) NSMutableArray *dealsImagesArray;
@property (nonatomic,retain) NSString *dealsTitleLabelText;

@property (nonatomic ,retain )     NSDictionary *dic;
@property (retain, nonatomic) IBOutlet UIButton *saveButtonClicked;

-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)share:(id)sender;
-(void)AddImages;
-(IBAction)removeTotalView:(id)sender;
-(void)downloadTileImages;
-(IBAction)merchantNameButtonClicked:(id)sender;
-(IBAction)catchTheDeal:(id)sender;
- (IBAction)hideButtonPressed:(id)sender;

- (IBAction)saveButtonClicked:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)cancel:(id)sender;
@end
