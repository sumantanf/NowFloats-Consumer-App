//
//  ImageGridViewController.h
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ImageGridViewController : UIViewController<UIScrollViewDelegate>{
    
    
    IBOutlet UIScrollView *gridScrollView;
    IBOutlet UIScrollView *bottomBar;
    NSMutableArray *imagesArray;
    IBOutlet UIView *v;
    IBOutlet UIImageView *bottomBackGroundImage;
    AppDelegate *appDelegate;
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;    NSMutableArray *pickerDataArray;
    int selectedAvatar;

    NSMutableData *data;
    int CurrentVal;   // IBOutlet UIScrollView *bottomBar;
    IBOutlet UIView *airBackgroundView;
    IBOutlet UILabel *airView;
    NSUserDefaults *userDetails;
    int IsFromImageThought;
    NSMutableArray *thoughsImageFloats;
    NSMutableArray *imgaethoughtOwnerDetails;
    DetailViewController *detailViewCon;

    NSMutableArray *bufferArr;
}
@property (nonatomic , retain ) IBOutlet UIView *airBackgroundView;
@property (nonatomic , retain ) IBOutlet UILabel *airView;
@property (nonatomic , retain ) IBOutlet UIImageView *bottomBackGroundImage;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
-(void)loadImages;
-(void)addPopup:(id)sender;
-(IBAction)sort:(id)sender;

-(IBAction)gotoback:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)gotoHomePage:(id)sender;
-(void)downloadImageThoughts;
-(void)addToScrollVIew;
-(void)refreshScrollVIew;
- (IBAction)tapToLoad:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *tapToLoad;


@end
