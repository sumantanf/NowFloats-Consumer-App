//
//  DetailViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "CommentPostViewController.h"
#import "ExpandAirSinkViewController.h"
#import "UIButton+WebCache.h"
#import "JSON.h"
#import "MarqueeLabel.h"
#import "LoginViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize dic;
@synthesize ownerDic;
@synthesize selectedAvatar;
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

    
    [bottomBar setContentSize:CGSizeMake(580, 50)];
    [accountholderName setText:[ownerDic objectForKey:@"OwnerTag"]];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    for (int i2=0; i2<[appDelegate.imgaethoughtOwnerDetails count]; i2++) 
    {
        
        if ([[[appDelegate.imgaethoughtOwnerDetails objectAtIndex:i2] objectForKey:@"_id"] isEqualToString:[dic objectForKey:@"OwnerId"]]) 
        {
            
            ownerDic=[appDelegate.imgaethoughtOwnerDetails objectAtIndex:i2];
            
            NSString *personString = [[appDelegate.imgaethoughtOwnerDetails objectAtIndex:i2] objectForKey:@"OwnerTag"];
            
            //[label2 setText:[NSString stringWithFormat:@"%@",personString]];
            
            nameString=[NSString stringWithFormat:@"%@  |",personString];
           
            
            
            NSDate *startdate ;
            NSString *dateString=[dic objectForKey:@"CreatedOn"];
            
            
            startdate=[appDelegate getDateFromJSON:dateString];
            
            NSDate *toDate = [NSDate date];
            int k = [startdate timeIntervalSince1970];
            int j = [toDate timeIntervalSince1970];
            
            double X = j-k;
            
            int days = (int)((double)X/(3600*24.0));
            int hrs = (int)X%(3600*24);
            int hrstemp =  hrs/3600;
            
            
            
            if(days > 0)
            {
                // [timeLabel setText:[NSString stringWithFormat:@"%d days ago",days]];
                if (days==1) {
                    nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d day ago",days]];
                }
                else{
                    nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d days ago",days]];
                    
                }
                
                
            }
            else
            {
                nameString=[NSString stringWithFormat:@"%@  %@  |",nameString,[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
                
                // [timeLabel setText:[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
            }
            
            
            break;
        }
        
        
    }
    
    
   
    nameString=[NSString stringWithFormat:@"%@  %@",nameString,[dic objectForKey:@"NearByLocationName"]];
    [accountholderName setText:nameString];
    
    [[detailImage imageView] setContentMode: UIViewContentModeScaleAspectFit];

    
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.thoughtsViewArray addObject:self.view];
    if ([[dic objectForKey:@"TotalComments"] intValue]) {
        
        [commentMessageButton setHidden:YES];
        [commentImmages1 setHidden:YES];
        [commentImmages2 setHidden:YES];
    
       // [commentView setHidden:YES];
        [CommentTableView setHidden:NO];
        
    }
    else {
        
        [commentImmages1 setHidden:NO];
        [commentImmages2 setHidden:NO];
        [commentMessageButton setHidden:NO];
        //[commentView setHidden:NO];
        [CommentTableView setHidden:YES];
    }
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    NSString *endUrl=[NSString stringWithFormat:@"https://api.withfloats.com%@",[dic objectForKey:@"ImageUri"]];
    [profileImg setImageWithURL:[NSURL URLWithString:endUrl]];
   
    [self drawText];
   

    
    commentsDic=[[NSMutableData alloc] initWithCapacity:0];
    //commentsArray=[[NSMutableArray alloc] initWithCapacity:0];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/comments/image/%@",[dic objectForKey:@"_id"]]];
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    NSURLConnection *connection;
    connection=[NSURLConnection  connectionWithRequest:req delegate:self];

}

-(void)drawText
{
    
    NSString *textFile=[dic objectForKey:@"FloatMessage"];
    if ([textFile length]>26) {
        [shareBackgroundLabel setFrame:CGRectMake(23, 190, 116, 40)];
        [backGroundLbl setFrame:CGRectMake(17, 192, 123, 36)];
        
        [shareBackgroundLabel setNumberOfLines:2];
        [shareBackgroundLabel setText:textFile];
        
        [shareBackgroundLabel setAlpha:0.4];
        [backGroundLbl setAlpha:0.4];
        
    }
    else {
        [shareBackgroundLabel setNumberOfLines:0];
        [shareBackgroundLabel setText:textFile];
        [shareBackgroundLabel sizeToFit];
        [shareBackgroundLabel setAlpha:0.4];
        [backGroundLbl setAlpha:0.4];
        [backGroundLbl setFrame:CGRectMake(17, 200, shareBackgroundLabel.frame.size.width+12, 20)];
        [shareBackgroundLabel setFrame:CGRectMake(23, 203, shareBackgroundLabel.frame.size.width, shareBackgroundLabel.frame.size.height)];
        
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [commentsDic appendData:data1];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // responseData=[[NSMutableData alloc] initWithCapacity:1];
    NSString *responseString = [[NSString alloc] initWithData:commentsDic encoding:NSUTF8StringEncoding];
    //[commentsDic setData:nil];
    if ([responseString length]) {
        commentsArray=[[[responseString JSONValue] objectForKey:@"Comments"] mutableCopy];
        NSMutableArray *ar=[[[responseString JSONValue] objectForKey:@"OwnerDetails"] mutableCopy];
        
        for (int j=0; j<[commentsArray count]; j++) {
            NSMutableDictionary *dic1=[commentsArray objectAtIndex:j];
            
            for (int j=0; j<[ar count]; j++) {
                if ([[dic1 objectForKey:@"OwnerId"] isEqualToString:[[ar objectAtIndex:j]objectForKey:@"_id"]]) {
                    [dic1 setObject:[[ar objectAtIndex:j] objectForKey:@"OwnerTag"] forKey:@"OwnerTag"];
                    [dic1 setObject:[[ar objectAtIndex:j] objectForKey:@"CreatedOn"] forKey:@"CreatedOn"];
                    [commentsArray replaceObjectAtIndex:j withObject:dic1];
                    break;
                    
                }
                
            }
            
        }

            }
    
    [commentsTable reloadData];
    
    
}

- (void)viewDidUnload
{
    [self setCommentBubbleClicked:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)goBack:(id)sender
{
    
    [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
    [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
}

-(IBAction)CommentButtonClicked:(id)sender
{
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])
    {
    CommentPostViewController *commentpost=[[CommentPostViewController alloc] initWithNibName:@"CommentPostViewController" bundle:nil];
    [commentpost setSelectedDictionary:dic];
    [commentpost setSelectedAvatar:selectedAvatar];
    [commentpost setPreviousTable:CommentTableView];
    [commentpost setCommentImage1:commentImmages1];
    [commentpost setCommentImage2:commentImmages2];
    [self.view addSubview:commentpost.view];
    }
    
    
    else
    {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
        
        
        
    }
    
    
    
}

-(IBAction)airorSinkButtonClicked:(id)sender
{
    
    imageAirsink=[[ImageAirsinkVC alloc] initWithNibName:@"ImageAirsinkVC" bundle:nil];
    [imageAirsink setDic:dic];
    [self.view addSubview:imageAirsink.view];
    [self.view bringSubviewToFront:cityImage];
    [self.view bringSubviewToFront:bottomBar];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return[commentsArray  count];;
}
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 static NSString *CellIdentifier = @"Cell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
 UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 23)];
 [label setFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];
 [label setAlpha:0.6];
 [label setTag:1];
 [label setBackgroundColor:[UIColor blackColor]];
 [label setTextColor:[UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:5.0f/255.0f alpha:1]];
 [cell addSubview:label];
 UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(9, 33, 250, 80)];
 [textView setBackgroundColor:[UIColor clearColor]];
 [textView setTag:2];
 [textView setEditable:NO];
 [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
 [cell addSubview:textView];
 UILabel *ownertag=[[UILabel alloc] initWithFrame:CGRectMake(18, 58, 80, 23)];
 
 [ownertag setTag:3];
 [ownertag setBackgroundColor:[UIColor blackColor]];
 [ownertag setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
 [ownertag setAlpha:0.6f];
 [ownertag setBackgroundColor:[UIColor clearColor]];
 
 [cell addSubview:ownertag];
 [ownertag release];
 
 UILabel *dateLbl=[[UILabel alloc] initWithFrame:CGRectMake(18, 69, 90, 23)];
 [dateLbl setTag:4];
 [dateLbl setBackgroundColor:[UIColor blackColor]];
 [dateLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:11]];
 [dateLbl setBackgroundColor:[UIColor clearColor]];
 [dateLbl setAlpha:0.6f];
 [cell addSubview:dateLbl];
 [dateLbl release];
 
 }
 UILabel *label=(UILabel *)[cell viewWithTag:1];
 UITextView *textVi=(UITextView *)[cell viewWithTag:2];
 
 [label setText:[NSString stringWithFormat:@"    00%d",[commentsArray count]-indexPath.row]];
     NSInteger row=indexPath.row+1;

 [textVi setText:[[commentsArray objectAtIndex:[commentsArray count]-row] objectForKey:@"CommentMessage"]];
 
 
 
 UILabel *ownLbl=(UILabel *)[cell viewWithTag:3];
 
 CGRect fra=[textVi frame];
 fra.size.height=textVi.contentSize.height;
 [textVi setFrame:fra];
 
 [ownLbl setFrame:CGRectMake(19, textVi.frame.origin.y+textVi.contentSize.height-7, 80,23)];
 
 
 [ownLbl setText:[[commentsArray objectAtIndex:[commentsArray count]-row] objectForKey:@"OwnerTag"]];
 UILabel *dateLbl=(UILabel *)[cell viewWithTag:4];
 
 [dateLbl setFrame:CGRectMake(19,ownLbl.frame.origin.y+ownLbl.frame.size.height-12 , 90, 23)];
 NSDate *startdate ;
 NSString *dateString=[[commentsArray objectAtIndex:[commentsArray count]-row] objectForKey:@"CreatedOn"];
 
 
 startdate=[appDelegate getDateFromJSON:dateString];
 
 NSDate *toDate = [NSDate date];
 int k = [startdate timeIntervalSince1970];
 int j = [toDate timeIntervalSince1970];
 
 double X = j-k;
 
 int days = (int)((double)X/(3600*24.0));
 int hrs = (int)X%(3600*24);
 int hrstemp =  hrs/3600;
 
 
 NSString *dayName;
 
 if(days > 0)
 {
 // [timeLabel setText:[NSString stringWithFormat:@"%d days ago",days]];
     if (days==1) {
         dayName=[NSString stringWithFormat:@"%d day ago",days];

     }
     else{
         dayName=[NSString stringWithFormat:@"%d days ago",days];

     }
 
 }
 else
 {
 dayName=[NSString stringWithFormat:@"%d hrs ago",hrstemp];
 
 }
 
 [dateLbl setText:dayName];
 
    
  cell.selectionStyle=UITableViewCellSelectionStyleNone;

 return cell;
 }
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}


-(IBAction)imageButtonClicked:(id)sender;
{
    imageDetail=[[ImageDetialViewController alloc] initWithNibName:@"ImageDetialViewController" bundle:nil];
    [imageDetail setImg:profileImg.image];
    [self.view addSubview:imageDetail.view];
    
    
}


-(IBAction)nameButtonClicked:(id)sender;
{
    expandNameViewCon=[[ExpandNameInImageViewController alloc] initWithNibName:@"ExpandNameInImageViewController" bundle:nil];
    
    
    [expandNameViewCon setDic:ownerDic];
    [expandNameViewCon setThoughtsDic:dic];
    [self.view addSubview:expandNameViewCon.view];
    [self.view bringSubviewToFront:cityImage];
    [self.view bringSubviewToFront:bottomBar];
    
    
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


- (IBAction)commentBubbleClicked:(id)sender
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])

    {
    
        CommentPostViewController *commentpost=[[CommentPostViewController alloc] initWithNibName:@"CommentPostViewController" bundle:nil];
        [commentpost setSelectedDictionary:dic];
        [commentpost setSelectedAvatar:selectedAvatar];
        [commentpost setPreviousTable:CommentTableView];
        [commentpost setCommentImage1:commentImmages1];
        [commentpost setCommentImage2:commentImmages2];
        [self.view addSubview:commentpost.view];

    
    }
    
    
    
    else
    {
    
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
        

      
    }
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex==1)
    {
        
        LoginViewController *loginVi=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:loginVi.view];
        
    }
    
}

- (void)dealloc {

    [super dealloc];
}
@end
