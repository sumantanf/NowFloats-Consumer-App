//
//  ExpandNameInImageViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ExpandNameInImageViewController : UIViewController

{
    
IBOutlet UILabel *nameLabel;
IBOutlet UIImageView *profileImage;
IBOutlet UILabel *placeLabel;
IBOutlet UILabel *daysLabel;
IBOutlet UILabel *distanceLabel;
NSMutableDictionary *dic;
NSMutableDictionary *thoughtsDic;
    IBOutlet UIImageView *pointerView;
    
    IBOutlet UIView *pickerView;

    IBOutlet UIImageView *deleteImage;
    IBOutlet UILabel *deleteLabel;
    AppDelegate *appDelegate;
    
    NSMutableArray *hideMessages;
    int CurrentVal;
    int isReport;


}
- (NSDate*) getDateFromJSON:(NSString *)dateString;
@property (nonatomic,retain) NSString *nameString;
@property (nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic,retain) NSMutableDictionary *thoughtsDic;
@property (nonatomic) int isFromImageDetailController;

-(IBAction)mapKitButtonClicked:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;


@end
