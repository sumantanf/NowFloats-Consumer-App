//
//  myMapView.h
//  NowFloatsv1
//
//  Created by Sumanta Roy on 29/08/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface myMapView : UIViewController<MKMapViewDelegate>
{

    float latitude;
    float  longitude;
}

@property (retain, nonatomic) IBOutlet MKMapView *mymap;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
-(void)displayMYMap:(float)lat:(float)lon;
@end
