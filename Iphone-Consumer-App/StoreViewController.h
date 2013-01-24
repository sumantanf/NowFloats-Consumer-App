//
//  StoreViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "StoreFrontViewController.h"
@interface StoreViewController : UIViewController{
    
    AppDelegate *appDelegate;

    IBOutlet UIScrollView *bottomBar;
    StoreFrontViewController *storeViewController;
}
-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)goToDeals:(id)sender;

@end
