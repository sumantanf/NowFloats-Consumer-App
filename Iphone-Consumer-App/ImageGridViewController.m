//
//  ImageGridViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageGridViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "JSON.h"
#import "DetailImageGridViewController.h"
#import "MarqueeLabel.h"
@interface ImageGridViewController ()

@end

@implementation ImageGridViewController
@synthesize tapToLoad;
@synthesize progressBar;
@synthesize airBackgroundView,airView,bottomBackGroundImage;

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
    [tapToLoad setHidden:YES];
    gridScrollView.delegate=self;

    pickerDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [pickerDataArray addObject:@"HOTTEST"];
    [pickerDataArray addObject:@"LATEST"];
    [pickerDataArray addObject:@"NEAREST"];
    imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    bufferArr=[[NSMutableArray alloc]init];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [appDelegate arrangeBottomButtons:bottomBar];
    appDelegate.imageScroll=gridScrollView;
    
    
    
    
    for (UIView *v in bottomBar.subviews)
    {
        if ([v isKindOfClass:[MarqueeLabel class]])
        {
            MarqueeLabel *mark=(MarqueeLabel *)v;
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }


    for (int i1=0; i1<[appDelegate.thoughsImageFloats count]; i1++)
    {
        [imagesArray addObject:[[appDelegate.thoughsImageFloats objectAtIndex:i1] objectForKey:@"SmallImageUri"]];
    }

    
    
    if (![appDelegate.thoughsImageFloats count]) 
    {
        [progressBar setHidden:NO];
        [progressBar startAnimating];

        [self downloadImageThoughts];
        
    }
    else
    {
    [progressBar setHidden:YES];
    [self loadImages];
    }
    
    
    
}
-(void)loadImages{
    
    int x,y;
    x=6;
    y=6;
    for(int j=0;j<[imagesArray count];j++)
    {

        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, 155, 169)];
        UIImageView *postImage=[[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 131, 100)];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(addPopup:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(x, y, 155, 169)];
        [button setTag:j];
        
        if (x>150)
        {
            x=6;
            y=y+167;
        }
        else {
            x=x+153;
        }
        
         NSString *imageStringUrl=[NSString stringWithFormat:@"https://api.withfloats.com%@",[imagesArray objectAtIndex:j]];
        [postImage setImageWithURL:[NSURL URLWithString:imageStringUrl]];
        [image setImage:[UIImage imageNamed:@"frame_w_shadow_2.png"]];
        [image addSubview:postImage];
        
        UILabel *shareBackgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 118, 118, 20)];
        

        UILabel *backGroundLbl=[[UILabel alloc] initWithFrame:CGRectMake(12, 120, 121,17)];
        [backGroundLbl setBackgroundColor:[UIColor yellowColor]];
        
        [shareBackgroundLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        [shareBackgroundLabel setBackgroundColor:[UIColor clearColor]];
        
        NSString *textFile=[[appDelegate.thoughsImageFloats objectAtIndex:j]objectForKey:@"FloatMessage"];
        if (textFile.length==1)
        {
            [shareBackgroundLabel setHidden:YES];
            [backGroundLbl setHidden:YES];
        }
        else
        {
        if ([textFile length]>26) {
            [shareBackgroundLabel setFrame:CGRectMake(18, 118, 116, 40)];
            [backGroundLbl setFrame:CGRectMake(12, 120, 123, 36)];

            [shareBackgroundLabel setNumberOfLines:2];
            [shareBackgroundLabel setText:textFile]; 
            
            [shareBackgroundLabel setAlpha:0.4];
            [backGroundLbl setAlpha:0.4];
            [image addSubview:backGroundLbl];
            
            [image addSubview:shareBackgroundLabel]; 
            [shareBackgroundLabel release];
        }
        else 
        {
            [shareBackgroundLabel setNumberOfLines:0];
            [shareBackgroundLabel setText:textFile]; 
            [shareBackgroundLabel sizeToFit];
            [shareBackgroundLabel setAlpha:0.4];
            [backGroundLbl setAlpha:0.4];
            [backGroundLbl setFrame:CGRectMake(12, 119, shareBackgroundLabel.frame.size.width+12, 20)];
            [shareBackgroundLabel setFrame:CGRectMake(18, 122, shareBackgroundLabel.frame.size.width, shareBackgroundLabel.frame.size.height)];
            [image addSubview:backGroundLbl];
            
            [image addSubview:shareBackgroundLabel]; 
            [shareBackgroundLabel release];
        }
        }
        
        
        [gridScrollView addSubview:image];
        [gridScrollView addSubview:button];
        
        [image release];
    }

    [gridScrollView setContentSize:CGSizeMake(320, y+70)];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == gridScrollView) 
    {
        IsFromImageThought=3;
        
        [tapToLoad setHidden:YES];
        
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == gridScrollView) 
    {
        IsFromImageThought=3;
        [tapToLoad setHidden:NO];
    }
}





-(IBAction)cancel:(id)sender
{
    [pickerView setHidden:YES]; 
}

-(IBAction)done:(id)sender
{
    if (imagesArray.count) 
    {
        [imagesArray removeAllObjects];
    }
    
    if ([appDelegate.thoughsImageFloats count]) 
    {
        [appDelegate.thoughsImageFloats removeAllObjects];
    }
    
    IsFromImageThought=2;
    [pickerView setHidden:YES]; 
    data=[[NSMutableData alloc] initWithCapacity:1];
    [pickerView setHidden:YES]; 
    NSString *sortByName;
    sortByName=[[pickerDataArray objectAtIndex:CurrentVal] lowercaseString];
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/imgfloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,[pickerDataArray objectAtIndex:CurrentVal]];    
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLConnection *connection;
    connection =[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
}


-(void)downloadImageThoughts    
{
    IsFromImageThought=1;

    data=[[NSMutableData alloc] initWithCapacity:1];
    [pickerView setHidden:YES]; 
    NSString *sortByName;
    sortByName=[[pickerDataArray objectAtIndex:CurrentVal] lowercaseString];
    NSString *urlString=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/imgfloats?lat=%f&lng=%f&radius=%f&skipBy=%d&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],appDelegate.radiusVal,[imagesArray count],[pickerDataArray objectAtIndex:CurrentVal]];    
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLConnection *connection;
    connection =[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
    

}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [data appendData:data1];
}




- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    

    if (IsFromImageThought==1) 
    {

        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableArray *imageFloats=[[responseString JSONValue] objectForKey:@"ImageFloats"] ;
        [appDelegate getThoughtsImageData:imageFloats];
        NSMutableArray *ownerDet=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        [appDelegate getImageOwnerDetails:ownerDet];
        [self refreshScrollVIew];
    }
    
    
    
    else if (IsFromImageThought==2)
    {
    
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableArray *imageFloats=[[responseString JSONValue] objectForKey:@"ImageFloats"] ;
        [appDelegate getThoughtsImageData:imageFloats];
        NSMutableArray *ownerDet=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        [appDelegate getImageOwnerDetails:ownerDet];
        
        [self refreshScrollVIew];
    
    }
    
    
    
    else if(IsFromImageThought==3)
    {
    
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableArray *imageFloats=[[responseString JSONValue] objectForKey:@"ImageFloats"] ;
        [appDelegate getThoughtsImageData:imageFloats];
        NSMutableArray *ownerDet=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        [appDelegate getImageOwnerDetails:ownerDet];
        
        [self addToScrollVIew];
    
    }
    
    
    
} 
-(void)refreshScrollVIew{
    
    [progressBar stopAnimating];
    [progressBar setHidden:YES];
    
    for(UIView *v1 in gridScrollView.subviews){
        [v1 removeFromSuperview];
    }
    if ([imagesArray count])
    {
        [imagesArray removeAllObjects];
    }
    for (int i1=0; i1<[appDelegate.thoughsImageFloats count]; i1++) {
        [imagesArray addObject:[[appDelegate.thoughsImageFloats objectAtIndex:i1] objectForKey:@"SmallImageUri"]];
        
    }
    [self loadImages];
    
}

- (IBAction)tapToLoad:(id)sender
{
    

    [self downloadImageThoughts];  
    

}
-(void)addToScrollVIew{
    
    [progressBar stopAnimating];
    [progressBar setHidden:YES];
    
//    for(UIView *v1 in gridScrollView.subviews)
//    {
//        [v1 removeFromSuperview];
//    }

    for (int i1=0; i1<[appDelegate.thoughsImageFloats count]; i1++)
    {
        [imagesArray addObject:[[appDelegate.thoughsImageFloats objectAtIndex:i1] objectForKey:@"SmallImageUri"]];
    }
    [self loadImages];
    
}

-(IBAction)sort:(id)sender
{
    [pickerView setHidden:NO];
       
    [self.view bringSubviewToFront: pickerView];
}

#pragma picker delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [pickerDataArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    return [pickerDataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CurrentVal=row;
}

- (void)viewDidUnload
{
    [self setProgressBar:nil];
    [self setTapToLoad:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)addPopup:(id)sender
{
    UIButton *b=(UIButton *)sender;
    CGRect frame = [sender frame];
    CGPoint yOffset = gridScrollView.contentOffset;
    DetailImageGridViewController *detail=[[DetailImageGridViewController alloc] initWithNibName:@"DetailImageGridViewController" bundle:nil];
    [detail setSelectedAvatar:b.tag];

    [appDelegate.thoughtsViewArray addObject:detail.view];
    [detail.view setFrame:CGRectMake(0, 0, 320, 350)];
    [detail.v setFrame:CGRectMake(frame.origin.x+6, (frame.origin.y - yOffset.y)+7, 143, 156)];
    [detail setImageGrid:self];
     
    [self.view addSubview:detail.view];

    [self.view bringSubviewToFront:bottomBackGroundImage];
    [self.view bringSubviewToFront:bottomBar];
    
  
}

-(IBAction)gotoback:(id)sender
{
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    
}
-(IBAction)gotoHomePage:(id)sender
{
    appDelegate.isThoughtViewSelected = NO;
    
    for (int i1=0; i1<[appDelegate.thoughtsViewArray count]; i1++) 
    {
        [[appDelegate.thoughtsViewArray objectAtIndex:i1] removeFromSuperview];
    }
    [appDelegate.thoughtsViewArray removeAllObjects];
    [appDelegate.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

}

- (void)dealloc {
    [progressBar release];
    [tapToLoad release];
    [super dealloc];
}
@end
