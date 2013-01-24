//
//  ThoughtsExpandedView.h
//  NowFloatsv1
//
//  Created by pravasis on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandedNameViewViewController.h"
#import "AppDelegate.h"
#import "ThoughtsViewController.h"
#import "ExpandAirSinkViewController.h"
@class ThoughtSelectedView;

@interface ThoughtsExpandedView : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    UIColor *color;
    NSString *messageString,*nameString;
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextView *messageTextView;
    UIView *coverView;
    IBOutlet UIImageView *city;
    
    ExpandedNameViewViewController *expandedNameController;
    AppDelegate *appDelegate;
    BOOL isNameButtonClicked;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    int i;
    NSTimer *timer1;
    IBOutlet UIScrollView *avatarScrollView;
    NSMutableArray *avatarsNamesArray;
    NSMutableArray *thoughtsArray;
    int selectedAvatar;
    ThoughtSelectedView *selectedView;
    ThoughtsViewController *m_thoughtController;

    IBOutlet UITableView *CommentTableView;
    IBOutlet UIImageView *commentImmages1;
    IBOutlet UIImageView *commentImmages2;
    IBOutlet UITextView *commentView;
    IBOutlet UIView *avatarView;
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UILabel *movingNameLabel;
    IBOutlet UIImageView *arrowImage;
    IBOutlet UIView *movingView;
    int movingViewValue;
    NSMutableArray *textFloats;
    NSMutableArray *ownerandText;
    NSMutableArray *commentDetails;
    NSMutableData *data;
    
    IBOutlet UIButton *messageButton;
    
    //NEw
    
    NSMutableArray *commentsArray;
    NSMutableData *commentsDic;
    int commentsVal;
    
    IBOutlet UIView *commentActivity;
    IBOutlet UIView *belowView;
    IBOutlet UIImageView *hilightedImag;
    IBOutlet UIImageView *textBoxBackground;
    
    NSString *ownerDetails;
    BOOL isDownloaded;
    IBOutlet UITextView *tempText;


}

@property (nonatomic,retain) NSString *messageString,*nameString;
@property (nonatomic,retain) NSMutableArray *thoughtsArray;
@property (nonatomic ) int selectedAvatar;
@property (nonatomic,retain) ThoughtSelectedView *selectedView;
@property (nonatomic,retain) ThoughtsViewController *m_thoughtController;
@property (nonatomic,retain)  NSMutableArray *textFloats;
@property (nonatomic,retain) NSMutableArray *ownerandText;
@property (nonatomic,retain) NSMutableArray *commentDetails;
@property (nonatomic,retain)     NSString *ownerDetails;


-(IBAction)goBackTo:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)nameButtonClicked:(id)sender;
-(IBAction)addAvatarImage:(id)sender;
-(IBAction)CommentButtonClicked:(id)sender;
-(void)higligtedImage:(id)sender;
-(void)downloadComments:(NSString *)clientId;
-(IBAction)airorSinkButtonClicked:(id)sender;
-(void)getOwnerDescription;

@end
