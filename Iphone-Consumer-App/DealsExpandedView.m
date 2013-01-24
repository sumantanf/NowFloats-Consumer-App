//
//  DealsExpandedView.m
//  NowFloats_v1
//
//  Created by pravasis on 14/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DealsExpandedView.h"
#import "AppDelegate.h"
#import "MarqueeLabel.h"
#import "DealsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"

@implementation DealsExpandedView

@synthesize dealsTitleString;
@synthesize m_dealsDictionary;
@synthesize dealsImagesArray;
@synthesize dealsTitleLabelText;
@synthesize dic;
@synthesize saveButtonClicked;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction)removeView:(id)sender
{
    isImageDisplaying = NO;
    [imageHoldView removeFromSuperview];
}

-(IBAction)removeTotalView:(id)sender
{
    [self.view removeFromSuperview];
}

-(IBAction)ImageClicked:(id)sender
{
    if(!isImageDisplaying)
    {
        imageHoldView = [[UIView alloc] initWithFrame:CGRectMake(descriptionBackgroundLabel.frame.origin.x, descriptionBackgroundLabel.frame.origin.y, descriptionBackgroundLabel.frame.size.width, 201)];
        [imageHoldView setBackgroundColor:[UIColor blackColor]];
        [imageHoldView setAlpha:0.800000011920929f];
        
        UIButton *clickedDealImageView_close = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickedDealImageView_close setFrame:CGRectMake(230, 10, 22,22)];
        [clickedDealImageView_close setAlpha:.5];
        [clickedDealImageView_close setBackgroundImage:[UIImage imageNamed:@"dealImageExpandedCross.png"] forState:UIControlStateNormal];
        [clickedDealImageView_close addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
        [imageHoldView addSubview:clickedDealImageView_close];
        
        UIImageView *clickedDealImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 240,150)];
        [clickedDealImageView setImage:[imageArray objectAtIndex:0]];
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

        [imageHoldView.layer setCornerRadius:5];
        [pool release];
        [imageHoldView addSubview:clickedDealImageView];
        [clickedDealImageView release];
        [self.view addSubview:imageHoldView];
        isImageDisplaying = YES;
    }
}

-(void)AddImages
{
    dealsImageViews = [[UIView alloc] initWithFrame:CGRectMake(41, 187 , 248, 88)];
    imageArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    if(!isdealsButtonClicked)
    {
        
        UIImageView *dealImages = [[UIImageView alloc] initWithFrame:CGRectMake(86, 5, 68, 68)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:dealImages.frame];
        
        [btn addTarget:self action:@selector(ImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        [dealsImageViews addSubview:btn];
        NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

        [dealImages.layer setCornerRadius:5];
        [pool release];
        NSMutableData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[dealsImagesArray objectAtIndex:0]]];
        if (data) {
            
            [imageArray addObject:[UIImage imageWithData:data]];
            [dealImages setImage:[UIImage imageWithData:data]];
        }
        else{
             [imageArray addObject:[UIImage imageNamed:@"deals market.png"]];
            [dealImages setImage:[UIImage imageNamed:@"deals market.png"]];
            
        }
        
        
        
        [dealImages setBackgroundColor:[UIColor whiteColor]];
        [dealsImageViews addSubview:dealImages];
        [dealImages release];
        isdealsButtonClicked = YES;
        
        [self.view addSubview:dealsImageViews];
    }

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     hideMessages=[[NSMutableArray alloc] initWithObjects:@"Uninteresting",@"Misleading",@"Sexually explicit",@"Against my views",@"Offensive",@"Repetitive",@"Other", nil];
    
    [arrowImage setTransform:CGAffineTransformMakeRotation(3.14)];
    
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

    [titleLbl.layer setCornerRadius:5];

    [dealsLocationLabel setText:[NSString stringWithFormat:@"        %@",dealsTitleString]];
    [dealsLocationLabel.layer setCornerRadius:5];
    [descriptionBackgroundLabel.layer setCornerRadius:5];
    [dealsCatchButton.layer setCornerRadius:5];
    [pointerBackground.layer setCornerRadius:5];
    [dealsValidView.layer setCornerRadius:5];
    [pool release];

    [dealsTitleLabel setText:dealsTitleLabelText];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
    [bottomNewBar setContentSize:CGSizeMake(580, 50)];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomNewBar];
    for (UIView *v in bottomNewBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:0.686 green:0.764 blue:0.019 alpha:1.000];
            break;
        }
        
    }

    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(71, 8, 2, 41)];
    [imgView1 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView1];
    [imgView1 release];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(143, 8, 2, 41)];
    [imgView2 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView2];
    [imgView2 release];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(215, 8, 2, 41)];
    [imgView3 setBackgroundColor:color];
    [bottomBar.bottomScrollView addSubview:imgView3];
    [imgView3 release];
    
    [self AddImages];
}
-(void)downloadTileImages{
   
}

-(IBAction)goBack:(id)sender
{
    [self.view removeFromSuperview];
}

-(IBAction)share:(id)sender
{
    if(!isShareButtonClicked)
    {
        shareView = [[UIView alloc] initWithFrame:CGRectMake(41, 171, 248,237)];
        [shareView setBackgroundColor:[UIColor blackColor]];
        isShareButtonClicked = YES;
        
        UIImageView *tweetimgView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 30, 50, 50)];
        [tweetimgView setImage:[UIImage imageNamed:@"tweet.png"]];
        [tweetimgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:tweetimgView];
        [tweetimgView release];

        UIImageView *centerLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(124, 0, 1, 237)];
        UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
        [centerLineImgView setBackgroundColor:color];
        [shareView addSubview:centerLineImgView];
        [centerLineImgView release];

        UIImageView *centerLineImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 118, 248, 1)];
        [centerLineImgView2 setBackgroundColor:color];
        [shareView addSubview:centerLineImgView2];
        [centerLineImgView2 release];

        UILabel *shareBackgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 104, 60, 28)];
        [shareBackgroundLabel setBackgroundColor:color];
        [shareView addSubview:shareBackgroundLabel];
        [shareBackgroundLabel release];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 102, 70, 28)];
        [shareLabel setText:@"share"];
        [shareLabel setFont:[UIFont systemFontOfSize:17]];
        [shareLabel setTextAlignment:UITextAlignmentCenter];
        [shareLabel setBackgroundColor:[UIColor clearColor]];
        [shareLabel setTextColor:[UIColor whiteColor]];
        [shareView addSubview:shareLabel];
        [shareLabel release];

        UIImageView *fbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(161, 30, 50, 50)];
        [fbImgView setImage:[UIImage imageNamed:@"fb.png"]];
        [fbImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:fbImgView];
        [fbImgView release];
        
        UIImageView *mailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 152, 43, 32)];
        [mailImgView setImage:[UIImage imageNamed:@"email.png"]];
        [mailImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:mailImgView];
        [mailImgView release];
        
        UIImageView *smslImgView = [[UIImageView alloc] initWithFrame:CGRectMake(161, 152, 50, 50)];
        [smslImgView setImage:[UIImage imageNamed:@"sms.png"]];
        [smslImgView setBackgroundColor:[UIColor clearColor]];
        [shareView addSubview:smslImgView];
        [smslImgView release];

        [self.view addSubview:shareView];
    }
}

-(IBAction)gotoHomePage:(id)sender
{
    [self.view removeFromSuperview];
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    for(int i=0;i<[m_appDel.viewsArray count];i++)
    {
        [[m_appDel.viewsArray objectAtIndex:i] removeFromSuperview];
    }
    [m_appDel.viewsArray removeAllObjects];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];


}

- (void)viewDidUnload
{
    [self setSaveButtonClicked:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    [imageArray release];
    [saveButtonClicked release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)catchTheDeal:(id)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dic objectForKey:@"DealUri"]]];
}

- (IBAction)hideButtonPressed:(id)sender {
    
    
    [pickerView setHidden:NO];
    
    
}

- (IBAction)saveButtonClicked:(id)sender {
    
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Uh-Oh!" message:@"Save your deal coming soon." delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}

#pragma UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [hideMessages count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [hideMessages objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    [userDefaults setObject:[NSString stringWithFormat:@"%d",row] forKey:@"selectedIndex"];
    CurrentVal=row;
}

-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES];
}

-(IBAction)done:(id)sender
{
    [pickerView setHidden:YES];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]) {
        //NSLog(@"is it called");
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/reportabuse/deal?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A&uid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"]];
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc] initWithCapacity:1];
        //[dic setValue:@"5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A" forKey:@"clientId"];
        [dic1 setValue:[dic objectForKey:@"_id"] forKey:@"floatId"];
        [dic1 setValue:[hideMessages objectAtIndex:CurrentVal]  forKey:@"reason"];
        [dic1 setValue:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:0] floatValue]] forKey:@"lat"];
        [dic1 setValue:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:1] floatValue]] forKey:@"lng"];
        
        
        
        NSString *urlTo=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url=[NSURL URLWithString:urlTo];
      //  NSLog(@"url is: %@",url);
        NSString *newurlString=[dic1 JSONRepresentation];
        NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
       // NSLog(@"url: %@",urlString);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
        
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        //NSLog(@"thre req: %@",request);
        
        NSURLConnection *theConnection;
        
        theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex==1) {
        
        LoginViewController *loginVi=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:loginVi.view];
        
    }
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
   // NSLog(@"code : %d",code);
    if (code==200) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        
        
        NSString *hideVal=[NSString stringWithFormat:@"hide_%@",[user objectForKey:@"_id"]];
        
        
        if ([user objectForKey:hideVal]) {
            
            
            NSMutableArray *dealHideArray=[[user objectForKey:hideVal] mutableCopy];
            [dealHideArray addObject:[dic objectForKey:@"_id"]];
            [user setObject:dealHideArray forKey:hideVal];
            [user synchronize];
        }
        else{
            NSMutableArray *dealHideArray=[[NSMutableArray alloc] initWithCapacity:1];
            [dealHideArray addObject:[dic objectForKey:@"_id"]];
            [user setObject:dealHideArray forKey:hideVal];
            [user synchronize];
        }
        
        [deal readDealsInfo];
        [dealsTableview reloadData];
        
        
        [self goBack:self];
        [dealsTableview reloadData];
        
        
    }
    
    
}






-(IBAction)merchantNameButtonClicked:(id)sender
{
    NSMutableDictionary *dealDic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dealDic setObject:[dic objectForKey:@"DealLocationName"] forKey:@"Address"];
    [dealDic setObject:[dic objectForKey:@"CalculateRadius"] forKey:@"CalculateRadius"];
    [dealDic setObject:[dic objectForKey:@"MerchantName"] forKey:@"Name"];
    [dealDic setObject:[NSNull null] forKey:@"Timings"];
    [dealDic setObject:[[dic objectForKey:@"DealLocation"] objectForKey:@"latitude"] forKey:@"lat"];
    [dealDic setObject:[[dic objectForKey:@"DealLocation"] objectForKey:@"longitude"] forKey:@"lng"];
    [dealDic setObject:[dic objectForKey:@"TileImageUri"] forKey:@"ImageUri"];
    //[dealDic setObject:[dic objectForKey:@"MerchantName"] forKey:@"imageVal"];
    
    storeViewController=[[StoreFrontViewController alloc] initWithNibName:@"StoreFrontViewController" bundle:nil];
    [storeViewController setDictionary:dealDic];
    [self.view addSubview:storeViewController.view];
}


@end
