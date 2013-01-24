//
//  ImageDetialViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageDetialViewController.h"
#import "MarqueeLabel.h"

@interface ImageDetialViewController ()

@end

@implementation ImageDetialViewController
@synthesize img;

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
    appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    [appDelegate.thoughtsViewArray addObject:self.view];
    [bottomBar setContentSize:CGSizeMake(580, 50)];

    [image setImage:img];
    [image setUserInteractionEnabled:YES];
    [scroll setDelegate:self];
    scroll.minimumZoomScale = scroll.frame.size.width/image.frame.size.width;
    scroll.maximumZoomScale = 2.0;
    [scroll setZoomScale:scroll.minimumZoomScale];
    tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBack:)];
    [tap1 setNumberOfTapsRequired:1];
    [v1 addGestureRecognizer:tap1];
    
    tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBack:)];
    [tap2 setNumberOfTapsRequired:1];
    [v2 addGestureRecognizer:tap2];
    

    // Do any additional setup after loading the view from its nib.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return image;
}
- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll1 andUIView:(UIView *)rView {
    CGSize boundsSize = scroll1.bounds.size;
    CGRect frameToCenter = rView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width-frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height-frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
    return frameToCenter;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    image.frame = [self centeredFrameForScrollView:scrollView andUIView:image];;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)gotoBack:(id)sender;
{
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)gotoHomePage:(id)sender
{
    appDelegate.isThoughtViewSelected = NO;
    
    
    for (int i1=0; i1<[appDelegate.thoughtsViewArray count]; i1++) {
        [[appDelegate.thoughtsViewArray objectAtIndex:i1] removeFromSuperview];
    }
    [appDelegate.thoughtsViewArray removeAllObjects];
    [appDelegate.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

    
}
@end
