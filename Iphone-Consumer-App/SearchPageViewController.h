//
//  SearchPageViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBarViewController.h"

@interface SearchPageViewController : UIViewController
{
    IBOutlet UITableView    *search_TableView;
    IBOutlet NSMutableArray *searchArray;
    IBOutlet UIButton *button1,*button2,*button3,*button4,*OButton1;
    BottomBarViewController *bottomBar;
    UIColor *color;
    UIImageView *img1,*img2,*img3,*img4;
    UIButton *locationButton,*distanceButton,*editButton;
    UIFont *fontForBottomBar;
    int i;
    NSTimer *timer1;
    BOOL stoporNot1,stoporNot2;

}

-(void)animateImages;

@end
