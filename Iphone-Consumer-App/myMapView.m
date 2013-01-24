//
//  myMapView.m
//  NowFloatsv1
//
//  Created by Sumanta Roy on 29/08/12.
//
//

#import "myMapView.h"
#import "MapAnnotation.h"


@interface myMapView ()

@end

@implementation myMapView
@synthesize mymap,latitude,longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mymap=[[MKMapView alloc]initWithFrame:self.view.bounds];
    //myMapView *obj=[[myMapView alloc]init];
    
    
    
    mymap.delegate=self;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.02;
    span.longitudeDelta=0.02;
    
    CLLocationCoordinate2D location;

    
    
    location.latitude=latitude;
    location.longitude=longitude;
    
    region.span=span;
    region.center=location;
     MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:location];
    [mymap addAnnotation:annotation];
    
    [mymap setRegion:region animated:TRUE];
    
    
    
    [self.view addSubview:mymap];
    

    
}



- (void)viewDidUnload
{
    [self setMymap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)displayMYMap:(float)lat:(float)lon;
{
    
    //NSLog(@"lat:%g lon:%g",lat,lon);
    lat=latitude;
    lon=longitude;
    
    
    
    
}

- (void)dealloc {
    [mymap release];
    [super dealloc];
}
@end
