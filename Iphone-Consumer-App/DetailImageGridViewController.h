//
//  DetailImageGridViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailViewController.h"
@class ImageGridViewController;
@interface DetailImageGridViewController : UIViewController{
    
    IBOutlet UIView *v;
    
    AppDelegate *appDelegate;
    IBOutlet UILabel *expandLabel,*airLabel,*sinkLabel;
    IBOutlet UIImageView *messageImageView;
    IBOutlet UIView *displayImageView;
    int sinkVal,airVal;
    IBOutlet UILabel *sinkNumLabel,*airNumLabel;
    IBOutlet UIButton *expandButton,*sinkButton,*airButton;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    UIColor *color;
    UIImageView *img1,*img2,*img3,*img4;
    BOOL stoporNot1,stoporNot2;
    int arrowImagesWidth,arrowImagesHeight,yPosition;
    int i;
    NSTimer *timer1;
    int air,sink    ;
    int selectedAvatar;
    int timerVal;
    int sinkingVal;
    IBOutlet UIImageView *airBackGroundImage;
    IBOutlet UIImageView *sinkBackGroundImage;
    NSMutableArray *ownerandText;
    
    IBOutlet UIView *airedview;
    IBOutlet UILabel *airedLabelView;
    DetailViewController *detailViewCon;
    ImageGridViewController *imageGrid;
    
    
}
@property (nonatomic  , retain ) IBOutlet UIView *v;
@property (nonatomic  , retain ) ImageGridViewController *imageGrid;


@property (nonatomic) int selectedAvatar;
@property (nonatomic,retain) NSMutableArray *ownerandText;

-(IBAction)AirButtonClicked:(id)sender;
-(IBAction)ExpandButtonClicked:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)SinkButtonClicked:(id)sender;
-(void)addSinkImage:(NSTimer *)timer;
-(void)addAirImage:(NSTimer *)timer;
-(void)removeairedView;

@end
