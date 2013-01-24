//
//  StoreFrontViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "FbGraph.h"
#import "StoreFrontImageDetailView.h"
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"



@class CompassViewController;
@interface StoreFrontViewController : UIViewController<UIScrollViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate,ABNewPersonViewControllerDelegate>{
    
    IBOutlet UIPageControl *pageControlle ;
    int storefrontValue; 
    IBOutlet UIView *page1;
    IBOutlet UIView *page2;
    IBOutlet UIView *page3;
    IBOutlet UIView *page4;
    IBOutlet UIView *page5;
    IBOutlet UIView *page6;
    IBOutlet UIView *page7;
    IBOutlet UIView *page8;
    
    IBOutlet UIButton *sliderImage1;
    IBOutlet UIImageView *sliderShadow1;
    IBOutlet UIImageView *groove1;
    IBOutlet UIImageView *markers1;
    IBOutlet UIButton *sliderImage2;
    IBOutlet UIImageView *sliderShadow2;
    IBOutlet UIImageView *groove2;
    IBOutlet UIImageView *markers2;
    IBOutlet UIButton *sliderImage3;
    IBOutlet UIImageView *sliderShadow3;
    IBOutlet UIImageView *groove3;
    IBOutlet UIImageView *markers3;
    IBOutlet UISlider *serviceSlider;
    IBOutlet UISlider *qualitySlider;
    IBOutlet UISlider *valueslider;
   IBOutlet  UIScrollView *bottomBar;
    UIImageView *img1,*img2,*img3,*img4;
      int arrowImagesWidth,arrowImagesHeight,yPosition;
    int i;
    NSTimer *timer1;
    BOOL stoporNot1,stoporNot2;
    
    
    //Page 8
    
    
    NSMutableArray *thoughtsArray;
    
    //Setting Data--page1
    IBOutlet UILabel *distanceLaebl;
    IBOutlet UIImageView *pointerView;
    NSMutableDictionary *dictionary;
     
    IBOutlet UIImageView *mapImage;
    
    //Setting Data ---Page 2
    
    IBOutlet UITextView *addressDetails;
    
    IBOutlet UITextView *mainNameLabel;

   FbGraph *fbGraph;
    NSUserDefaults *user;
    int RatingValue;
    IBOutlet UIImageView *ratingProfile;
    IBOutlet UILabel *ratingCommentLabel;
    NSMutableArray *profilePic;
    IBOutlet UIButton *ratingButton;
    IBOutlet UIButton *yourRatingButton;
    IBOutlet UIView *oopsMessage;
    UIView *selectedRatingView;
    IBOutlet UITextView *tellNumber;
    
    IBOutlet UILabel *serviceRating;
    IBOutlet UILabel *valueRating;
    IBOutlet UILabel *qualityRating;
    
    IBOutlet UILabel *serviceCommentLabel;
    IBOutlet UILabel *valueCommentLabel;
    IBOutlet UILabel *qualityCommentLabel;
    
    IBOutlet UIImageView *serviceImage;
    IBOutlet UIImageView *valueImage;
    IBOutlet UIImageView *qualityImage;
    NSMutableArray *commentsArray;
    IBOutlet UIImageView *starImage1;
    IBOutlet UIImageView *starImage2;
    IBOutlet UIImageView *starImage3;
    IBOutlet UIImageView *starImage4;
    IBOutlet UIImageView *starImage5;
   
    IBOutlet UIImageView *oopsstarImage1;
    IBOutlet UIImageView *oopsstarImage2;
    IBOutlet UIImageView *oopsstarImage3;
    IBOutlet UIImageView *oopsstarImage4;
    IBOutlet UIImageView *oopsstarImage5;
    
    //Tile Image
    
    IBOutlet UIImageView *shopImage;
    
    IBOutlet UIImageView *openImage;
    IBOutlet UILabel *openLabel;
    IBOutlet UITextView *contactNumber;
    IBOutlet UILabel *imageDescription;
    
    //Store Front Swipe Tutorial
    
    IBOutlet UIView *swipeTut;
    UITapGestureRecognizer *tap;
    UISwipeGestureRecognizer *swipGesture;
    NSMutableArray *ar;
    int callVal;
     NSString *currentTimmings;
    NSString *timmingString;
    NSString *dayTimmings;
    NSString *allDaysTimmings;
    
    IBOutlet UIImageView *ratingLing;
    IBOutlet UILabel *ratingName;
    IBOutlet UIButton *ratingSubmit;
    IBOutlet UIImageView *ratingSubmitLine;
    IBOutlet UIImageView *ratingCancelLine;
    NSMutableArray *ratingNames;
    IBOutlet UIButton *ratingCancelButton;
    
    //Rating Image Outlets
    
    IBOutlet UIImageView *serviceRatingImg;
    IBOutlet UIImageView *valueRatingImg;
    IBOutlet UIImageView *qualityRatingImg;
    
    IBOutlet UIImageView *openImage2;
    IBOutlet UILabel *openLbl2;
    
    IBOutlet  MKMapView *mapView;
    CompassViewController *compass;
    

}
@property(nonatomic,retain) IBOutlet UIScrollView *scrolling ;
@property (nonatomic, retain) FbGraph *fbGraph;
@property (nonatomic ,retain )     NSMutableDictionary *dictionary;

-(IBAction)gotoHomePage:(id)sender;
-(IBAction)goBack:(id)sender;


-(IBAction)serviceRating:(id)sender;
-(void)addjustServiceRating;
-(IBAction)qualityRating:(id)sender;
-(void)addjustQualityRating;
-(IBAction)valueRating:(id)sender;
-(void)adjustValueRating;
-(IBAction)mapKitButtonClicked:(id)sender;
-(IBAction)socialNetworkButtonsClicked:(id)sender;
- (void)postInAppFacebook;
-(void)displayComposerSheet;
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error ;
-(void)launchMailAppOnDevice;
-(IBAction)ratingButtonClicked:(id)sender;
-(void)submitRatings:(NSDictionary *)dic;
-(IBAction)RatingViewButtonClicke:(id)sender;
-(IBAction)yourRatingButtonClicked:(id)sender;
-(IBAction) sendInAppSMS:(id) sender;
-(void)tapButtonClicked;
-(void)callButtonClicked:(id)sender;
-(void)saveButtonClicked:(id)sender;
-(void)expandTimmings:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;
-(IBAction)StoreFrontImageButtonClicked:(id)sender;
-(void)deallocate;

@end
