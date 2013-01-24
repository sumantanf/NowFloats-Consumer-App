//
//  CreateFloatViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarViewController.h"
#import "ThoughtsViewController.h"
#import "AppDelegate.h"

@interface CreateFloatViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet UITextView *createFloatTextView;  
    BottomBarViewController *bottomBar;
    IBOutlet UIButton *button4,*OButton1;
    IBOutlet UILabel *locationLabel;
    UIColor *color;
    UIView *barView;
    NSMutableArray *locationDataArray;
    IBOutlet UITableView *popoverTable;
    BOOL isPopOverPresent;
    int selectedLocationIndex;
    IBOutlet UILabel *numberLabel;
    IBOutlet UIImageView *countHolder;
    IBOutlet UIImageView *pickImage;
    NSMutableData *webData;
    AppDelegate *appDelegate;
    IBOutlet UIScrollView *bottomNewBar;
    NSString *locationString;
    IBOutlet UIView *tableBack;
    IBOutlet UIView *textFloatView;
    IBOutlet UIImageView *bobbleImageView ;
    UIButton *closeButton ;
    NSUserDefaults *prefs;
    NSUserDefaults *prefimg;
    
}
@property (nonatomic,retain)AppDelegate *appDelegate;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)displayTableView:(id)sender;

-(void)resignKeyBoard;
- (UIImage*)loadImage;
-(void)selectPhotoType;
-(IBAction)submit:(id)sender;
-(void)setSpecialValues:(id)sender;

@end
