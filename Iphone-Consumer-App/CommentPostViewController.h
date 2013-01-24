//
//  CommentPostViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CommentPostViewController : UIViewController{
    IBOutlet UIScrollView *bottomBar;
    IBOutlet UITextView *textVi;
    NSMutableDictionary *selectedDictionary;
    IBOutlet UIView *airedview;
    IBOutlet UILabel *airedLabelView;

    int fromVi;
    int selectedAvatar;
    UITableView *previousTable;
    AppDelegate *appDelegate;
    UIImageView *commentImage1;
    UIImageView *commentImage2;
    NSMutableArray *commentsArray;
    
    IBOutlet UIActivityIndicatorView *activity;
}
@property (nonatomic ,retain) NSMutableDictionary *selectedDictionary;
@property (nonatomic , retain) UITableView *previousTable;
@property (nonatomic , retain) UIImageView *commentImage1;
@property (nonatomic, retain) UIImageView *commentImage2;
@property (nonatomic ,retain )    NSMutableArray *commentsArray;
 
 

@property (nonatomic ) int fromVi;
@property (nonatomic ) int selectedAvatar;
 
-(IBAction)gotoBack:(id)sender;
-(IBAction)postComment:(id)sender;
-(void)removeairedView;
-(IBAction)gotoHomePage:(id)sender;
@end
