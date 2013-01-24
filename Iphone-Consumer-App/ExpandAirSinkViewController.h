//
//  ExpandAirSinkViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExpandAirSinkViewController : UIViewController{
    
     IBOutlet UIButton *sinkButton,*airButton;
    IBOutlet UILabel *sinkNumLabel,*airNumLabel;
    NSMutableDictionary *dic;
    IBOutlet UIView *airedview;
    IBOutlet UILabel *airedLabelView;
    int timerVal;
    IBOutlet UIImageView *airBackGroundImage;
    IBOutlet UIImageView *sinkBackGroundImage;
    int sinkingVal,airVal,sinkVal;
    int selectedVal;
    int air,sink;
}
@property (nonatomic , retain )  NSMutableDictionary *dic;
@property (nonatomic ) int selectedVal;
@end
