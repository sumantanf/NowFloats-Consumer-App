//
//  CompassViewController.m
//  NowFloatsv1
//
//  Created by jitu keshri on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompassViewController.h"

@implementation CompassViewController
@synthesize locationDic;
@synthesize compassImage;
@synthesize locationManager;
@synthesize lat,lng;

-(void)rotateImage{
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
	[locationManager startUpdatingHeading];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // Use the true heading if it is valid. 
    CLLocationDirection direction = newHeading.magneticHeading;
    CGFloat radians = -direction / 180.0 * M_PI;
    
    
    
    //For Rotate Niddle
    CGFloat angle = [self RadiansToDegrees:radians];
    [self setLatLonForDistanceAndAngle];
    fltAngle=-90;
    [self rotateArrowView:compassImage degrees:(angle + fltAngle)];
}

-(void)rotateArrowView:(UIView *)view degrees:(CGFloat)degrees
{
    CGAffineTransform transform = CGAffineTransformMakeRotation([self DegreesToRadians:degrees]);
    view.transform = transform;
}

-(void)setLatLonForDistanceAndAngle
{
    dblLat1 = [self DegreesToRadians:locationManager.location.coordinate.latitude];
    dblLon1 = [self DegreesToRadians:locationManager.location.coordinate.longitude];
    
    dblLat2 =  [self DegreesToRadians:lat];
    dblLon2 =  [self DegreesToRadians:lng];
    
    fltLat = dblLat2 - dblLat1;
    fltLon = dblLon2 - dblLon1;
}

-(float)getAngleFromLatLon
{
    //Calculate angle between two points taken from http://www.movable-type.co.uk/scripts    /latlong.html
    double y = sin(fltLon) * cos(dblLat2);
    double x = cos(dblLat1) * sin(dblLat2) - sin(dblLat1) * cos(dblLat2) * cos(dblLon2);
    CGFloat angle = [self RadiansToDegrees:(atan2(y, x))];
    return angle;
}
-(CGFloat)DegreesToRadians:(CGFloat) degrees
{
    return degrees * M_PI / 180;
};

-(CGFloat)RadiansToDegrees:(CGFloat) radians
{
    return radians * 180 / M_PI;
};


-(void)dealloc{
    
    [locationDic release];
    [compassImage release];
    [locationManager release];
    [super dealloc];
}
@end
