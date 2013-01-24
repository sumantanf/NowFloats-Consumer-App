//
//  AppDelegate.h
//  NowFloats_v1
//
//  Created by pravasis on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>




@class ViewController;
@class Parser;
@class UrlInfo;
@class EditController;
@class DetailViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    ViewController *viewController;
    BOOL isThoughtViewSelected;
    BOOL isNameViewSelected;
    BOOL isEditButtonSelected;
    BOOL isSearchButtonSelected;

    int selectedDistance;
    NSString *distanceString;
    NSMutableArray *viewsArray;
    
    CGRect bottomBarFrame;
     
    // XML Data
    //Deals View
    NSMutableArray *dealsData;
    NSMutableArray *dealsRefidArray;
    BOOL isDeal;
   //Event View
    NSMutableArray *eventsData;
    NSMutableArray *eventsRefidArray;
    BOOL isEvent;
    
    //StoreFront View
    NSMutableArray *storeFrontData;
    NSMutableArray *storeFrontRefidArray;
    BOOL isStore;
    NSString *latitude;
    NSString *longitude;
    
    float radiusVal;
    
    NSMutableData *dataLocation;
    NSMutableArray *locationArray;
    
    //Arround u...
    NSMutableArray *aroundData;
    int selectedArondValue;
    
    
    //Thoughts View
    
    NSMutableArray *thoughtsOwnerDetails;
    NSMutableArray *thoughsTextFloats;
    NSMutableArray *thoughtsComments;
    
    int commentVal;
    
    //Thoughts Image Floats
    NSMutableArray *thoughsImageFloats;
    NSMutableArray *imgaethoughtOwnerDetails;
    
    NSUserDefaults *userDetails;
    int skipByValue;
   
    NSMutableArray *thoughtsViewArray;
    NSMutableArray *bottomBarData;
    NSMutableArray *editViewArray;
    BOOL IsFromEditController;
    
    UIImageView *imageView;
    int blinkVal;
    
    UIScrollView *bottomBar;
    BOOL isInternet;
    NSString *eventSortName;
    NSString *dealSortName;
    
    NSTimer *t1;
    BOOL tg3;
    
    UITableView *thoughtsTab;
    UIView *imageBack;
    UIScrollView *imageScroll;
    
    NSString *newlatitude;
    NSString *newlongitude;
    BOOL firstCallInitiated;
    
    CLLocationManager *locationManager;
    NSDate *appStartTimestamp;
    NSNumber *detailTag;
    UIImageView *imgView;
    int isAnimeForFirstTime;
    UILabel *label;
    //Events count
    
    int eventCount;
    
    
    //Deal Count
    
    int dealCount;
    
    //Thoughts Text Count
    
    int textCount;
    int b;
    
    //Deals View controller Ref..
    
    DetailViewController *dealRef;
    
}


@property (strong, nonatomic) UIWindow *window;
@property (readwrite, nonatomic) BOOL isThoughtViewSelected;
@property (readwrite, nonatomic) BOOL isEditButtonSelected;
@property (readwrite, nonatomic) BOOL isSearchButtonSelected;
@property (readwrite, nonatomic) BOOL isNameViewSelected;
@property (readwrite, nonatomic) int selectedDistance;
@property (nonatomic,retain) NSString *distanceString;
@property (nonatomic,retain) NSMutableArray *viewsArray;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic,readwrite) CGRect bottomBarFrame;
@property (strong, nonatomic) NSMutableArray *dealsData;
@property (strong , nonatomic) NSMutableArray *eventsData;
@property (strong , nonatomic) NSMutableArray *storeFrontData;
@property (strong , nonatomic) NSMutableArray *aroundData;

@property (nonatomic ) float radiusVal;
@property (nonatomic ,retain) NSMutableArray *locationArray;
@property (nonatomic ,retain) NSMutableArray *thoughtsOwnerDetails;
@property (nonatomic ,retain) NSMutableArray *thoughsTextFloats;
@property (nonatomic ,retain) NSMutableArray *thoughtsComments;
@property (nonatomic ,retain) NSMutableArray *thoughsImageFloats;
@property (nonatomic ,retain) NSMutableArray *imgaethoughtOwnerDetails;
@property (nonatomic ) int selectedArondValue;

@property (nonatomic ) int commentVal;
@property (nonatomic ) int skipByValue;
@property (nonatomic ,retain) NSMutableArray *thoughtsViewArray;
@property (nonatomic , retain)        NSMutableArray *bottomBarData;
@property (nonatomic , retain)        NSMutableArray *editViewArray;
@property (readwrite, nonatomic) BOOL IsFromEditController;
@property (readwrite, nonatomic)     UIScrollView *bottomBar;
@property (readwrite, nonatomic)     BOOL isInternet;
@property (nonatomic , retain )     NSString *eventSortName;
@property (nonatomic , retain) NSString *dealSortName;
@property (nonatomic,retain ) NSMutableArray *countingarray;
@property (nonatomic,retain ) NSMutableDictionary  *countingdic;
@property (nonatomic) BOOL isLocationServiceEnabled;


@property (nonatomic , retain)     UITableView *thoughtsTab;


@property (strong, nonatomic) UIViewController *backupVC;

@property (nonatomic , retain) UIScrollView *imageScroll;
@property   (nonatomic ) bool     didEnterBackgrroundBeforeErrorFlag;
@property   (nonatomic ) bool     didEnterBackgroundAfterErrorFlag;

@property (nonatomic,retain) NSMutableArray *arraApp;
@property (nonatomic ) int eventCount;
@property (nonatomic ) int dealCount;
@property (nonatomic ) int textCount;
@property(nonatomic) int aroundResposeCode;
@property (nonatomic , retain) NSMutableArray *imageOwner;

@property (nonatomic ,retain) DetailViewController *dealRef;

-(void)parsecdata:(NSMutableDictionary *)datadic;
-(void)downloadFloatCountData;
-(void) target;
-(void)setdistance:(float)distance;
-(void)setLocation:(NSString*)Location;
-(void)clearArray;
-(NSString * )convertToXMLEntities:(NSString * )myString ;
-(void)getData:(NSMutableArray *)dataarray;
-(void)parseDealsData;
-(void)getEventData:(NSMutableArray *)dataarray;
-(void)parseEventsData;
-(void)getStoreFrontData:(NSMutableArray *)dataarray;
-(void)parseStoreFrontData;
-(void)getArrounData:(NSMutableArray *)dataarray;
-(void)parseAroundData;
-(void)parseThoughtsData;
-(void)getThoughData:(NSMutableArray *)dataarray;
-(void)getThoughTextFloatData:(NSMutableArray *)dataarray;
-(void)parseThoughtsCommentData:(NSMutableDictionary *)dic;
-(void)getThoughtsComment:(NSMutableArray *)dataarray;
-(void)parseThoughtsImageData;
    -(void)getThoughtsImageData:(NSMutableArray *)dataarray;
-(NSString *)calculteDistanceLatitude:(NSString *)latitude2 :(NSString *)longitude2;
-(void)downloadData;
-(void)parseImageComments:(NSMutableDictionary *)dic;
-(void)getImageCommentsData:(NSMutableArray *)dataarray;

-(EditController *)EditButtonClicked:(id)sender;
-(void)arrangeBottomButtons:(UIScrollView *)sc;
-(void)arrangeSettingsBottomButtons:(UIScrollView *)sc;
- (NSDate*) getDateFromJSON:(NSString *)dateString
;
-(void)getImageOwnerDetails:(NSMutableArray *)dataarray;
-(BOOL)reloadAfterErrorScreen;
-(NSArray *)getDataArray:(NSMutableArray *)dataarray;
-(CLLocationDistance)calculteDistanceFromCurrentLocation:(NSString *)latitude2 :(NSString *)longitude2;
@end
