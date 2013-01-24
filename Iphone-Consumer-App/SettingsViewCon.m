//
//  SettingsViewCon.m
//  NowFloatsv1
//
//  Created by pravasis on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewCon.h"
#import "UIColor+HexaString.h"
#import "MarqueeLabel.h"

@interface SettingsViewCon ()

@end

@implementation SettingsViewCon
@synthesize viewCon;

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
    [bottomScrollView setContentSize:CGSizeMake(580, 50)];
   AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    // NSLog(@"The Date is: %@",[[appDelegate.dealsData objectAtIndex:0] objectForKey:@"DealEndDate"]);
    [appDelegate arrangeSettingsBottomButtons:bottomScrollView];
    for (UIView *v in bottomScrollView.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.000];
            break;
        }
        
    }

    
    userDetails=[NSUserDefaults standardUserDefaults];
    imageNames=[[NSMutableArray alloc] initWithObjects:@"Baby Blue City_1.png",@"Cream Ice City_1.png",@"Hello Yello City_1.png",@"Midnight X_1.png",@"Paris Pink_1.png",@"PB Red City_1.png", nil];

    if ([[userDetails objectForKey:@"ColorValue"] intValue]) {
        int colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];
        UIButton *b=(UIButton *)[self.view viewWithTag:colorVal];
    [b setImage:[UIImage imageNamed:@"Default City_1.png"] forState:UIControlStateNormal];
    
      //  [self calculteColor];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)initialDelayEnded{
    [selectedButton setImage:selectedImage forState:UIControlStateNormal];
    selectedButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.009, 0.009);
    selectedButton.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
[UIView setAnimationDelegate:self];
    selectedButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped :(UIButton *)b1 and :(UIImage *)img{
    selectedButton=b1;
    selectedImage=img;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    selectedButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    
    [UIView commitAnimations];
    [self performSelector:@selector(initialDelayEnded) withObject:nil afterDelay:0.8];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)backButtonClicked:(id)sender{
    
    
    [self.view removeFromSuperview];
}
-(IBAction)themeButtonClicked:(id)sender{
    
    if ([userDetails objectForKey:@"ColorValue"])
    {
        UIButton *b1=(UIButton *)sender;
        
        int previousVal;
        previousVal=[[userDetails objectForKey:@"ColorValue"]intValue];
        if (b1.tag==previousVal) {
            [userDetails removeObjectForKey:@"ColorValue"];
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];

            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"ffa50a"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]]  && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                }
            }
            [self bounce2AnimationStopped:b1 and:[UIImage imageNamed:[imageNames objectAtIndex:previousVal-1]]];
            [userDetails synchronize];
            
            
        }
        else {

            [self bounce2AnimationStopped:b1 and:[UIImage imageNamed:@"Default City_1.png"]];
            UIButton *b2=(UIButton *)[self.view viewWithTag:previousVal];
            [b2 setImage:[UIImage imageNamed:[imageNames objectAtIndex:previousVal-1]] forState:UIControlStateNormal];
            [userDetails setObject:[NSNumber numberWithInt:b1.tag] forKey:@"ColorValue"];
            [userDetails synchronize];
            if (b1.tag==1) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
                [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"739db2"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"739db2"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
                    }
                }
            }
            else if (b1.tag==2) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
                [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"b2ab5e"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"b2ab5e"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
                    }
                }
            }
            else if (b1.tag==3) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"ffa50a"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                    }
                }
            }
            else if (b1.tag==4) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
                 [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"202c66"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"202c66"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
                    }
                }
            }
            else if (b1.tag==5) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
                [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"b28cab"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"b28cab"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
                    }
                }
                
                
            }
            else if (b1.tag==6) {
                [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
                [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
                [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
                [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
                [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
                for (UIView *v in viewCon.bottomBar.subviews) {
                    if ([v isKindOfClass:[MarqueeLabel class]]){
                        MarqueeLabel *mark=(MarqueeLabel *)v;
                        
                        
                        mark.textColor = [UIColor colorWithHexString:@"b20000"];
                    }
                    if ([v isKindOfClass:[UIButton class]]) {
                        UIButton *b=(UIButton *)v;
                        [b setTitleColor:[UIColor colorWithHexString:@"b20000"] forState:UIControlStateNormal];
                    }
                    else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                        
                        [v setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
                    }
                }
            }
        }
       
    }
    else
    {
        
    UIButton *b=(UIButton *)sender;
        [self bounce2AnimationStopped:b and:[UIImage imageNamed:@"Default City_1.png"]];

    //[b setImage:[UIImage imageNamed:@"Default City_1.png"] forState:UIControlStateNormal];
    [userDetails setObject:[NSNumber numberWithInt:b.tag] forKey:@"ColorValue"];
        [userDetails synchronize];
        
        if (b.tag==1) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"739db2"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"a5e1ff"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"739db2"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"739db2"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
                }
            }
        }
        else if (b.tag==2) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b2ab5e"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"fff587"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"b2ab5e"];
                }

                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b2ab5e"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
                }
            }
        }
        else if (b.tag==3) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b27307"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"ffa50a"];
                }

                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                }
            }
        }
        else if (b.tag==4) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"202c66"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"2e3f92"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"202c66"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"202c66"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
                }
            }
        }
        else if (b.tag==5) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b28cab"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ffc8f5"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"b28cab"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b28cab"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
                }
            }
        }
        else if (b.tag==6) {
            [viewCon.view setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
            [viewCon.dayLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
            [viewCon.dollarLabel setTextColor:[UIColor colorWithHexString:@"b20000"]];
            [viewCon.parentView setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
            [viewCon.bottomCreateFloat setBackgroundColor:[UIColor colorWithHexString:@"ff0000"]];
            for (UIView *v in viewCon.bottomBar.subviews) {
                if ([v isKindOfClass:[MarqueeLabel class]]){
                    MarqueeLabel *mark=(MarqueeLabel *)v;
                    
                    
                    mark.textColor = [UIColor colorWithHexString:@"b20000"];
                }
                if ([v isKindOfClass:[UIButton class]]) {
                    UIButton *b=(UIButton *)v;
                    [b setTitleColor:[UIColor colorWithHexString:@"b20000"] forState:UIControlStateNormal];
                }
                else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                    
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
                }
            }
        }
    }
   // [self calculteColor];
}
-(void)calculteColor{
    int colorVal=[[userDetails objectForKey:@"ColorValue"] intValue];
   
    
    if (colorVal==1) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"739db2"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"739db2"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]]&& ![v isKindOfClass:[MarqueeLabel class]]){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"739db2"]];
                }
            }
        }
    }
    else if (colorVal==2) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"b2ab5e"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"b2ab5e"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]] ){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b2ab5e"]];
                }
            }
        }
    }
    else if (colorVal==3) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"ffa50a"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"ffa50a"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"ffa50a"]];
                }
            }
        }
    }
    else if (colorVal==4) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"202c66"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"202c66"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"202c66"]];
                }
            }
        }
    }
    else if (colorVal==5) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"b28cab"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"b28cab"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b28cab"]];
                }
            }
        }
    }
    else if (colorVal==6) {
        
        for (UIView *v in bottomScrollView.subviews) {
            if ([v isKindOfClass:[MarqueeLabel class]]){
                MarqueeLabel *mark=(MarqueeLabel *)v;
                
                
                mark.textColor = [UIColor colorWithHexString:@"b20000"];
            }
            if ([v isKindOfClass:[UIButton class]]) {
                UIButton *b=(UIButton *)v;
                [b setTitleColor:[UIColor colorWithHexString:@"b20000"] forState:UIControlStateNormal];
            }
            else if([v isKindOfClass:[UIView class]] && ![v isKindOfClass:[MarqueeLabel class]]){
                
                if (![v isKindOfClass:[UIImageView class]]) {
                    [v setBackgroundColor:[UIColor colorWithHexString:@"b20000"]];
                }
                
            }
        }
        
        
    }
}

-(IBAction)gotoHomePage:(id)sender
{
    [self.view removeFromSuperview];
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    [m_appDel.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];
    
}
@end
