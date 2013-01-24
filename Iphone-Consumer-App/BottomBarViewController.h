//
//  BottomBarViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 25/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomBarViewController : UIViewController
{
    IBOutlet UIScrollView *bottomScrollView;
    IBOutlet UIButton *OButton;
}

@property (nonatomic,retain) UIScrollView *bottomScrollView;
@property (nonatomic,retain) UIButton *OButton;

-(IBAction)gotoHomePage:(id)sender;

@end
