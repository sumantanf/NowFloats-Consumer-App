//
//  ImageDetialViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ImageDetialViewController : UIViewController<UIScrollViewDelegate>{
    
    UIImage *img;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *image;
    AppDelegate *appDelegate;
    IBOutlet UIScrollView *bottomBar;
    
    UITapGestureRecognizer *tap1;
    UITapGestureRecognizer *tap2;
    
    IBOutlet UIView *v1;
    IBOutlet UIView *v2;

}
@property (nonatomic ,retain )UIImage *img;
-(IBAction)gotoBack:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
@end
