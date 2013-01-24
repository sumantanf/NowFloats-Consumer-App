//
//  StoreViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MarqueeLabel.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

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
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:0.686 green:0.764 blue:0.019 alpha:1.000];
            break;
        }
        
    }

     

    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [appDelegate.aroundData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier= @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

        
        UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 260, 45)];
        [backgroundLabel setTag:1];
        [backgroundLabel setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:backgroundLabel];
        [backgroundLabel release];
        
        UILabel *thoughtLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 17, 190, 50)];
        [thoughtLabel setTag:2];
        [thoughtLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:thoughtLabel];
        [thoughtLabel release];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 44, 200, 50)];
        [nameLabel setTag:3];
        [nameLabel setNumberOfLines:2];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:nameLabel];
        [nameLabel release];
        
        UIImageView *imageView_Pocket = [[UIImageView alloc] initWithFrame:CGRectMake(276, 35, 13 ,16)];
        [imageView_Pocket setTag:4];
        [cell addSubview:imageView_Pocket];
        [imageView_Pocket release];
        
        UILabel *sideLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, 30, 14)];
        [sideLabel setTag:5];
        [cell addSubview:sideLabel];
        [sideLabel release];
        
    }
    
    UIColor *color1 = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
    
    UILabel *imgView1 = (UILabel*)[cell viewWithTag:1];
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

    [imgView1.layer setCornerRadius:5];
    [pool release];
    
    UILabel *label = (UILabel*)[cell viewWithTag:2];
    [label setTextColor:color1];
    
    NSMutableDictionary *dataDictionary = [appDelegate.aroundData objectAtIndex:indexPath.row];
    [label setText:[dataDictionary objectForKey:@"Name"]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:17]];
    [label setLineBreakMode:UILineBreakModeTailTruncation];
    
    UILabel *label2 = (UILabel*)[cell viewWithTag:3];
    NSString *personString = [dataDictionary objectForKey:@"Title"];
    [label2 setFont:[UIFont fontWithName:@"Helvetica" size:10]];
 
    [label2 setTextColor:color1];
    [label2 setText:personString];
    
    UIImageView *imgView_pocket = (UIImageView*)[cell viewWithTag:4];
    [imgView_pocket setImage:[UIImage imageNamed:@"itemExpandIcon.png"]];
    
    UILabel *sideLabel = (UILabel*)[cell viewWithTag:5];
    UIColor *color = [UIColor colorWithRed:175/250.0f green:195/250.0f blue:5/250.0f alpha:1.0];
    
    [sideLabel setBackgroundColor:color];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(IBAction)gotoHomePage:(id)sender{
    [self.view removeFromSuperview];
    [appDelegate.bottomBar setContentOffset:CGPointMake(260, 0) animated:NO];

}
-(IBAction)goBack:(id)sender{

    [self.view removeFromSuperview];

}
-(IBAction)goToDeals:(id)sender{
    [self.view removeFromSuperview];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    storeViewController=[[StoreFrontViewController alloc] initWithNibName:@"StoreFrontViewController" bundle:nil];
    [storeViewController setDictionary:[appDelegate.aroundData objectAtIndex:indexPath.row]];
    [self.view addSubview:storeViewController.view];
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

@end
