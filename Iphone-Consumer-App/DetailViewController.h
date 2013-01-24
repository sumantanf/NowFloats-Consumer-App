//
//  DetailViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ImageDetialViewController.h"
#import "ExpandNameInImageViewController.h"
#import "ImageAirsinkVC.h"
@interface DetailViewController : UIViewController{
    NSString *nameString;
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UIButton *detailImage;
    IBOutlet UITextView *detailTextView;
    IBOutlet UITextView *commentTextView;
    IBOutlet UILabel *accountholderName;
    NSMutableDictionary *dic;
    AppDelegate *appDelegate;
    int selectedAvatar;
    IBOutlet UITableView *CommentTableView;
    IBOutlet UIImageView *commentImmages1;
    IBOutlet UIImageView *commentImmages2;
    ImageDetialViewController *imageDetail;
    NSMutableDictionary *ownerDic;
    ExpandNameInImageViewController *expandNameViewCon;
    ImageAirsinkVC *imageAirsink;
    //NEw
    
    NSMutableData *commentsDic;
    NSMutableArray *commentsArray;
    IBOutlet UITableView *commentsTable;
    
    IBOutlet UILabel *shareBackgroundLabel;
    IBOutlet UILabel *backGroundLbl;
    IBOutlet UIImageView *cityImage;
    IBOutlet UIImageView *profileImg;
    IBOutlet UIButton *commentMessageButton;

}
@property (nonatomic,copy)  NSMutableDictionary *dic;
@property (nonatomic, retain) NSMutableDictionary *ownerDic;
@property (nonatomic )    int selectedAvatar;
 

-(IBAction)goBack:(id)sender;
-(IBAction)CommentButtonClicked:(id)sender;
    -(IBAction)airorSinkButtonClicked:(id)sender;
-(IBAction)imageButtonClicked:(id)sender;
-(IBAction)nameButtonClicked:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
- (IBAction)commentBubbleClicked:(id)sender;


@end
