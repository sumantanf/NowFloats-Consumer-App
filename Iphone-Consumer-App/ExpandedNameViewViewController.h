//
//  ExpandedNameViewViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class CompassViewController;
@interface ExpandedNameViewViewController : UIViewController
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *placeLabel;
    IBOutlet UILabel *daysLabel;
    IBOutlet UILabel *distanceLabel;
    NSMutableDictionary *dic;
    NSMutableDictionary *thoughtsDic;
    IBOutlet UIView *blackView;
    IBOutlet UIImageView *pointerView;
    
    IBOutlet UIButton *deleteButton;
    
    IBOutlet UIActivityIndicatorView *prograssBar;
    IBOutlet UIImageView *deleteImage;
    IBOutlet UILabel *deleteLabel;
    IBOutlet UIView *pickerView;
    NSMutableArray *hideMessages;
    int CurrentVal;
    int isReport;
    CompassViewController *compass;
    AppDelegate *appDelegate;

}
- (NSDate*) getDateFromJSON:(NSString *)dateString;
-(IBAction)goBack:(id)sender;
-(IBAction)mapKitButtonClicked:(id)sender;
-(IBAction)DeleteButtonClicked:(id)sender;
-(void)deallocate;

@property (nonatomic,retain) NSString *nameString;
@property (nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic,retain) NSMutableDictionary *thoughtsDic;

@end
