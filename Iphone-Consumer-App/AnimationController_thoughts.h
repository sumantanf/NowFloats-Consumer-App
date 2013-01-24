//
//  AnimationController_thoughts.h
//  NowFloats_v1
//
//  Created by pravasis on 02/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationController_thoughts : UIViewController
{
    IBOutlet UIImageView *imageView;
    NSTimer *RunningTimer1,*RunningTimer2;
    int tempVal;
    IBOutlet UIView *coverView;
    BOOL direction;
    int checkVal;
}

-(void)loadImage1;


@end
