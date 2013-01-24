//
//  AnimationController_thoughts.m
//  NowFloats_v1
//
//  Created by pravasis on 02/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnimationController_thoughts.h"

@implementation AnimationController_thoughts

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tempVal = 210;
    checkVal = 0;
    // Do any additional setup after loading the view from its nib.
    RunningTimer1 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loadImage1) userInfo:nil repeats:YES];
    
}

/*-(void)loadimage
{
    if(tempVal <=210 && tempVal > 0 && !direction)
    {
        tempVal = tempVal-1;
    }
    else if(tempVal == 0 && !direction)
    {
        direction = YES;
        tempVal = -1;
    }
    else
    {
        tempVal = tempVal +1;
        if(tempVal == 210)
            direction = NO;
    }
    
    [coverView setFrame:CGRectMake(120, 0, 80, tempVal)];
}*/


-(void)loadImage1
{
    tempVal = tempVal-1;
    [coverView setFrame:CGRectMake(98, 0, 125, tempVal)];
    
    if(tempVal == 0)
    {
        [coverView setFrame:CGRectMake(98, 0, 125, 210)];
        [RunningTimer1 invalidate];
        RunningTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loadImage2) userInfo:nil repeats:YES];
    }
}

-(void)loadImage2
{

    checkVal = checkVal + 1;
    tempVal = tempVal +1;
    
    [coverView setFrame:CGRectMake(98, tempVal, 125, 210-checkVal)];
    if(tempVal == 211)
    {
        tempVal = 210;
        checkVal = 0;
        [coverView setFrame:CGRectMake(98, 0, 125, 210)];
        [RunningTimer2 invalidate];
        RunningTimer1 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loadImage1) userInfo:nil repeats:YES];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
