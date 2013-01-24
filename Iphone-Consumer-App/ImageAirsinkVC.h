//
//  ImageAirsinkVC.h
//  NowFloatsv1
//
//  Created by pravasis on 05/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageAirsinkVC : UIViewController{

    
    IBOutlet UIButton *sinkButton,*airButton;
    IBOutlet UILabel *sinkNumLabel,*airNumLabel;
    NSMutableDictionary *dic;
    IBOutlet UIView *airedview;
    IBOutlet UILabel *airedLabelView;
    int timerVal;
    int air,sink;
    IBOutlet UIImageView *airBackGroundImage;
    IBOutlet UIImageView *sinkBackGroundImage;
    int sinkingVal,airVal,sinkVal;
    int selectedVal;
}
@property (nonatomic , retain )  NSMutableDictionary *dic;
@property (nonatomic ) int selectedVal;
@end
