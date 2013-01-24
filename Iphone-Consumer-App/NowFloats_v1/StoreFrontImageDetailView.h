//
//  StoreFrontImageDetailView.h
//  NowFloatsv1
//
//  Created by pravasis on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface StoreFrontImageDetailView : UIViewController{
    
    
    UIImage *img;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *image;
    AppDelegate *appDelegate;
    IBOutlet UIScrollView *bottomBar;
}
@property (nonatomic ,retain )UIImage *img;
@end
