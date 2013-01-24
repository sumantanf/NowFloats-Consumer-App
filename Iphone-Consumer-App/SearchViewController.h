//
//  SearchViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarViewController.h"
#import "SearchPageViewController.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    BottomBarViewController *bottomBar;
    IBOutlet UIImageView *diningImageView, *shoppingImageView, *attractionsImageView, *entertainmentImageView, *convenienceImageView, *emergencyImageView;
    
   IBOutlet UIView *diningClickedView; 
    UIColor *color;
    BOOL isCategoryClicked;
    UIImageView *img1,*img2,*img3,*img4;
    UIButton *locationButton,*distanceButton,*editButton;
    NSTimer *timer1;
    BOOL stoporNot1,stoporNot2;
    int i;
    UIFont *fontForBottomBar;
    SearchPageViewController *searchPageController;
    IBOutlet UIView *shopingClickedView;
    IBOutlet UIView *attractionClickedView;
    IBOutlet UIView *entertainmentClickedView;
    IBOutlet UIView *convenienceClickedView;
    IBOutlet UIView *emergencyClickedView;
    BOOL IsDinning;
    BOOL IsShoping;
}

-(IBAction)diningButtonClicked:(id)sender;
-(IBAction)shoppingButtonClicked:(id)sender;
-(IBAction)attractionButtonClicked:(id)sender;
-(IBAction)entertainmentButtonClicked:(id)sender;
-(IBAction)convenienceButtonClicked:(id)sender;
-(IBAction)emergencyButtonClicked:(id)sender;
-(IBAction)allButtonClicked:(id)sender;
-(void)animateImages;

-(IBAction)dinningInnerButtonClicked:(id)sender;

@end
