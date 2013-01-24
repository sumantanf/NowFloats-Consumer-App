//
//  CompassViewController.h
//  NowFloatsv1
//
//  Created by jitu keshri on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
@interface CompassViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
     UIImageView *compassImage;
    float dblLat1,dblLon1,dblLat2,dblLon2,fltAngle,fltLon,fltLat;
    NSMutableDictionary *locationDic;
    float lat;

    float lng;
}
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic ,retain ) NSMutableDictionary *locationDic;
@property (nonatomic ,retain ) UIImageView *compassImage;
@property (nonatomic ) float lat;
@property (nonatomic ) float lng;

-(void)setLatLonForDistanceAndAngle;
-(void)rotateArrowView:(UIView *)view degrees:(CGFloat)degrees;
-(CGFloat)DegreesToRadians:(CGFloat) degrees;
-(CGFloat)RadiansToDegrees:(CGFloat) radians;
-(void)rotateImage;
@end
