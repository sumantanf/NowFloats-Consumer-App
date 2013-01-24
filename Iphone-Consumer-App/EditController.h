//
//  EditController.h
//  NowFloats_v1
//
//  Created by pravasis on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditRadiusController.h"
#import "EditLocationController.h"


@class ViewController;
@interface EditController : UIViewController
{
    EditRadiusController *editRadiusController;
    EditLocationController *editLocationController;
    ViewController *viewCon;
    IBOutlet UIScrollView *bottomScrollView;
    IBOutlet UITableView *selectedTableView;
    int fromHome;
    NSUserDefaults *userDetails;
    IBOutlet UIButton* editlocatio;
    IBOutlet  UIButton* editradius;
}
@property(nonatomic,retain ) ViewController *viewCon;
@property(nonatomic,retain ) IBOutlet UIScrollView *bottomScrollView;
@property (nonatomic ) int fromHome;
-(IBAction)EditLocation:(id)sender;
-(IBAction)EditRadius:(id)sender;

@end
