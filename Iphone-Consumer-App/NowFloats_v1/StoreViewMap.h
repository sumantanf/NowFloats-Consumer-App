//
//  StoreViewMap.h
//  NowFloatsv1
//
//  Created by pravasis on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"


@interface StoreViewMap : UIViewController{
    
    IBOutlet  MKMapView *mapView;  
    IBOutlet UIScrollView *bottomBar;
    
}
@property(nonatomic ,retain ) NSString *latitudeValue;
@property(nonatomic ,retain ) NSString *longitudeValue;
-(IBAction)goBack:(id)sender;
@end
