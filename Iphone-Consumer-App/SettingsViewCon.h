//
//  SettingsViewCon.h
//  NowFloatsv1
//
//  Created by pravasis on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface SettingsViewCon : UIViewController
{
    NSMutableArray *imageNames;
    ViewController *viewCon;
    IBOutlet UIImageView *selectedBackgroundView;
    NSUserDefaults *userDetails;
    IBOutlet UIScrollView *bottomScrollView;
    NSTimer *timer1;
    NSTimer *timer2;
    IBOutlet UIButton *selectedButton;
    int decrement;
    UIImage *selectedImage;
}
@property (nonatomic, retain) ViewController *viewCon;
-(IBAction)backButtonClicked:(id)sender;
-(IBAction)themeButtonClicked:(id)sender;
-(void)calculteColor;
-(void)animationFirstButton:(UIButton *)b1 :(UIImage *)img;
-(void)decrementButton:(UIButton *)b1;
-(IBAction)gotoHomePage:(id)sender;
@end
