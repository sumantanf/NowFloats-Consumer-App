//
//  EditRadiusController.h
//  NowFloats_v1
//
//  Created by pravasis on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class ViewController;
@interface EditRadiusController : UIViewController
{
    ViewController *viewCon;
    int fromHome;
    IBOutlet UIScrollView *bottomScrollView;
    IBOutlet UIButton *btn20;
    IBOutlet UIButton *btn10;
    
    IBOutlet UIButton *btn5;
    
    IBOutlet UIButton *btn3;
    
    IBOutlet UIButton *btn2;
    
    IBOutlet UIButton *btn1;
    AppDelegate *app;
    int var;
    
    IBOutlet UIButton *btnp5;
    
    int colorVal;
    NSUserDefaults *userDetails;
    
}

@property (nonatomic ,retain )  ViewController *viewCon;
@property (nonatomic ) int fromHome;
@property (nonatomic , retain) IBOutlet UIScrollView *bottomScrollView;
-(IBAction)distanceButtonClicked:(id)sender;

@end
