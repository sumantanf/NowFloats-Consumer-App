//
//  CommentPostViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommentPostViewController.h"
#import "AppDelegate.h"
#import "MarqueeLabel.h"
#import "JSON.h"
@interface CommentPostViewController ()

@end

@implementation CommentPostViewController
@synthesize selectedDictionary;
@synthesize fromVi;
@synthesize selectedAvatar;
@synthesize previousTable;
@synthesize commentImage1;
@synthesize commentImage2;
@synthesize commentsArray;
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
    [activity stopAnimating];
    //NSLog(@"selected avatar: %d",selectedAvatar);
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate arrangeBottomButtons:bottomBar];
    
    for (UIView *v in bottomBar.subviews) 
    {
        if ([v isKindOfClass:[MarqueeLabel class]])
        {
            MarqueeLabel *mark=(MarqueeLabel *)v;
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    [appDelegate.thoughtsViewArray addObject:self.view];
    
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

-(IBAction)gotoBack:(id)sender
{
    
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    
    
}

-(IBAction)postComment:(id)sender
{
   
    [activity startAnimating];
    [textVi resignFirstResponder];
    

    if (fromVi==1) 
    {
              
        NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/comment/text/%@?lat=%f&lng=%f&clientId=5F47D9A85F7B4FE89F5022CD53C69F3EAC16E0892F2F45388F439BDE9F6F3FB5&comment=%@&locName=%@",[selectedDictionary objectForKey:@"_id"],[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],textVi.text,[selectedDictionary objectForKey:@"NearByLocationName"]  ];
        
        NSString *urlTo=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
        NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlTo] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
        //NSLog(@"Req:%@",request);
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection *theConnection;
        theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }
    
    else 
    {
        
        NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/discover/v1/comment/image/%@?lat=%f&lng=%f&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A&comment=%@&locName=%@",[selectedDictionary objectForKey:@"_id"],[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],textVi.text,[selectedDictionary objectForKey:@"NearByLocationName"]  ];
        
        
        NSLog(@"URL:%@",url);
        
        NSString *urlTo=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *newurlString=[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"];
        
        NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlTo] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
        
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection *theConnection;
        theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    NSLog(@"code:%d",code);
    [airedview setFrame:CGRectMake(16, 162, 284, 37)];
    if (code==200)
    {
        if (fromVi) 
        {
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:0];
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc] initWithCapacity:0];
            [dic1 setObject:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:0]floatValue]] forKey:@"latitude"];
            [dic1 setObject:[NSNumber numberWithFloat:[[appDelegate.locationArray objectAtIndex:1]floatValue]] forKey:@"longitude"];
            [dic setObject:dic1 forKey:@"CommentLocation"];
            [dic setObject:textVi.text forKey:@"CommentMessage"];
            [dic setObject:[NSString stringWithFormat:@"Date(%.0f)",[[NSDate date] timeIntervalSince1970]*1000] forKey:@"CreatedOn"];
            
            [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"] forKey:@"OwnerId"];
            
            [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayTag"] forKey:@"OwnerTag"];
            //[dic setObject:<#(id)#> forKey:@"_id"];
            
            if ([[commentsArray objectAtIndex:selectedAvatar] count])
            {
              
                [[commentsArray objectAtIndex:selectedAvatar] addObject:dic];               
                //[[appDelegate.thoughtsComments objectAtIndex:selectedAvatar] addObject:dic];
                [previousTable reloadData];
                [self gotoBack:nil];
            }
            else {
                
                [[commentsArray objectAtIndex:selectedAvatar] addObject:dic];
                [previousTable reloadData];
                [previousTable setHidden:NO];
                [commentImage1 setHidden:YES];
                [commentImage2 setHidden:YES];
                [self gotoBack:nil];
            }
            
        }
        else {


        
        }
        
        [airedLabelView setText:@"Successfully commented"];
    }
    

    else
    {
        
        [airedLabelView setText:@"Comment is not posted"];
    }
    
    [activity stopAnimating];
    //[self gotoHomePage:nil];
}
-(void)removeairedView
{
    [airedview setFrame:CGRectMake(-300, 162, 284, 37)];    
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
