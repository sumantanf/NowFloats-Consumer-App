//
//  StoreViewMap.m
//  NowFloatsv1
//
//  Created by pravasis on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreViewMap.h"
#import "MarqueeLabel.h"

#import "AppDelegate.h"
@interface StoreViewMap ()

@end

@implementation StoreViewMap
@synthesize latitudeValue,longitudeValue;

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
    NSString *selectedString=[NSString stringWithFormat:@"%@",@"simple"];
    
    [super viewDidLoad];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:10/255.0 alpha:1.000];
            break;
        }
        
    }
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([latitudeValue floatValue], [longitudeValue floatValue]);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    
    [mapView setRegion:MKCoordinateRegionMake(coordinate, span)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:coordinate];
    [mapView addAnnotation:annotation];
    [UIView commitAnimations];
    [annotation release];
    
    MKCoordinateRegion region;
    //Set Zoom level using Span
    // MKCoordinateSpan span;  
    region.center=mapView.region.center;
    
    span.latitudeDelta=mapView.region.span.latitudeDelta /2.0002;
    span.longitudeDelta=mapView.region.span.longitudeDelta /2.0002;
    region.span=span;
    [mapView setRegion:region animated:TRUE];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)goBack:(id)sender{
[self.view removeFromSuperview];
}

@end
