//
//  EditLocationController.h
//  NowFloats_v1
//
//  Created by pravasis on 09/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSString+CamelCase.h"

@class ViewController;
@interface EditLocationController : UIViewController
{
    NSMutableArray *locatonArray;
    UIColor *color;
    IBOutlet UITableView *locationTable;
    int selectedCell;
    AppDelegate *appDelegate;
     ViewController *viewCon;
    int fromHome;
    IBOutlet UIScrollView *bottomScrollView;
    NSUserDefaults *userDetails;
    UIColor *colorCodeVal;
    int colorVal;

    
}
@property(nonatomic,retain ) ViewController *viewCon;
@property(nonatomic, retain) IBOutlet UIScrollView *bottomScrollView;
@property (nonatomic )     int fromHome;

@end
