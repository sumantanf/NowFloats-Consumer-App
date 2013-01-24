//
//  ThoughtsExpandedView.m
//  NowFloatsv1
//
//  Created by pravasis on 21/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "UrlInfo.h"

#import "ThoughtsExpandedView.h"
#import "ThoughtSelectedView.h"
#import "JSON.h"
#import "CommentPostViewController.h"
#import "MarqueeLabel.h"
#import "NSString+CamelCase.h"
#import "LoginViewController.h"


@implementation ThoughtsExpandedView



@synthesize messageString,nameString,thoughtsArray,selectedAvatar,selectedView,m_thoughtController,textFloats,ownerandText,commentDetails;
@synthesize ownerDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)animateImages
{
    i = 0;
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationImages:) userInfo:nil repeats:YES];
}

-(IBAction)animationImages:(id)sender
{
    ++i;
    if(i == 1)
    {
        [img1 setHidden:NO];
        [img1 setAlpha:1.0];
    }
    else if(i == 2)
    {
        [img2 setHidden:NO];
        [img2 setAlpha:0.75];
    }
    else if(i == 3)
    {
        [img3 setHidden:NO];
        [img3 setAlpha:0.50];
    }
    else if(i == 4)
    {
        [img4 setHidden:NO];
        [img4 setAlpha:0.35];
        if(stoporNot1)
        {
            stoporNot2 = YES;
        }
    }
    else if(i == 5)
    {
        i = 0;
        stoporNot1 = YES;
        [img1 setHidden:YES];
        [img2 setHidden:YES];
        [img3 setHidden:YES];
        [img4 setHidden:YES];
    }
    if(i == 1 && stoporNot2 && stoporNot1)
    {
        [timer1 invalidate];
        [img1 setHidden:YES];
        [img2 setHidden:YES];
        [img3 setHidden:YES];
        [img4 setHidden:YES];
    }
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [bottomBar setContentSize:CGSizeMake(580, 50)];
   
    
  
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.bottomBar=bottomBar;
    [appDelegate arrangeBottomButtons:bottomBar];
    for (UIView *v in bottomBar.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]){
            MarqueeLabel *mark=(MarqueeLabel *)v;
            
            
            mark.textColor = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1.000];
            break;
        }
        
    }

    [appDelegate.thoughtsViewArray addObject:self.view];
    int y;
    y=10;
    [messageTextView setAlpha:0.3f];
    

   // NSLog(@" comments array is: %@ and count : %d",m_appDel.commentsArray,[m_appDel.commentsArray count]);
    
    [CommentTableView setHidden:YES];
    [commentImmages1 setHidden:YES];

    

   // [nameLabel setText:[[ownerandText objectAtIndex:0] objectForKey:@"OwnerTag"]];
    [nameLabel setText:ownerDetails];
    [commentActivity setFrame:self.view.bounds];
   // [commentActivity setFrame:CGRectMake(0, 0, 320, 406)];

    [self.view addSubview:commentActivity];
    [commentActivity bringSubviewToFront:self.view];
   
    for (int t=1; t<[textFloats count]+1; t++) {
       
        UIButton  *b=[UIButton buttonWithType:UIButtonTypeCustom];
        int avatarId;
        int isMale;

                avatarId=[[[ownerandText objectAtIndex:t-1] objectForKey:@"AvatarImageId"] intValue];
        
                if (avatarId > 6)
                    avatarId = avatarId % 7;
                else if (avatarId < 0) {
                    avatarId = 0;
                }
                
                isMale=[[[ownerandText objectAtIndex:t-1] objectForKey:@"IsMale"] intValue];
                if (isMale) {
                    [b setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"male_avatar_%d.png",avatarId]] forState:UIControlStateNormal];
                } else {
                    [b setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"female_avatar_%d.png",avatarId]] forState:UIControlStateNormal];
                }
                
               

//            }
//        }
                
        
       if (t!=1) {
            [b setAlpha:0.3f];
        }
        [b setFrame:CGRectMake(12, y, 30, 30)];
        [b setTag:t];
       [b addTarget:self action:@selector(addAvatarImage:) forControlEvents:UIControlEventTouchUpInside];
        [avatarView addSubview:b];
       // [avatarScrollView addSubview:b];
        y=y+40;
        
  
    }
    

    color = [UIColor colorWithRed:255/255.0 green:200/255.0 blue:5/255.0 alpha:1];

    
    [messageTextView setText:[[textFloats objectAtIndex:0] objectForKey:@"FloatMessage"]];

        
    
    CGRect fra=[messageTextView frame];
    fra.size.height=messageTextView.contentSize.height;

    [textBoxBackground setFrame:CGRectMake(8, 30, 268,fra.size.height)];
    [messageTextView setFrame:fra];
    [belowView setFrame:CGRectMake(8,fra.origin.y+fra.size.height,268, 279)];
    
    commentsVal=0;
    commentsArray=[[NSMutableArray alloc] initWithCapacity:1];
    commentsDic=[[NSMutableData alloc] initWithCapacity:1];
    [self downloadComments];
    
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];

    [nameLabel setText:[[[[textFloats objectAtIndex:0] objectForKey:@"namestring"] lowercaseString]  stringByConvertingCamelCaseToCapitalizedWords]];


    
}

-(void)downloadComments
{
    
    NSString *url=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/comments/text/%@",[[textFloats objectAtIndex:commentsVal] objectForKey:@"_id"]];
    NSURL *urlValue=[NSURL URLWithString:url];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:urlValue];
    NSURLConnection *connection;
    connection=[NSURLConnection connectionWithRequest:theRequest delegate:self];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLog(@"touch");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch= [touches anyObject];
    if ([touch view]==avatarView && isDownloaded) {

        CGPoint currentPoint = [touch locationInView:avatarView];
        if (currentPoint.x>0) {
            int n1=(int)currentPoint.y;
            if (n1>0) {
                int correctVal=n1/40;
                
                if (correctVal<[textFloats count]) {
                    
                    
                    [self.view addSubview:movingView];
                    [city sendSubviewToBack:movingView];
                    [movingNameLabel setText:[[ownerandText objectAtIndex:correctVal]  objectForKey:@"OwnerTag"]];
                    
                    movingViewValue=correctVal;
                    [movingNameLabel setFrame:CGRectMake(100, currentPoint.y, 150, 35)];
                    [arrowImage setFrame:CGRectMake(100, currentPoint.y, 175, 35)];
                    [hilightedImag setFrame:CGRectMake(100, currentPoint.y, 151, 16)];
                    
                    
                    
                }
                else {
                    
                    
                }
            }
            
            
        }
    }
    
    
  
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [movingView removeFromSuperview];
    
    
    
    UIButton *b1=(UIButton*)[avatarView viewWithTag:selectedAvatar];
    
    
    [b1 setAlpha:0.3f];
    
    UIButton *b2=(UIButton*)[avatarView viewWithTag:movingViewValue+1];
    [b2 setAlpha:1.0f];
    selectedAvatar=b2.tag;
    [messageTextView setText:[[textFloats objectAtIndex:b2.tag-1]   objectForKey:@"FloatMessage"]];
    //[nameLabel setText:[[textFloats objectAtIndex:b2.tag-1] objectForKey:@"namestring"]];
    

    [nameLabel setText:[[[[textFloats objectAtIndex:b2.tag-1] objectForKey:@"namestring"] lowercaseString]  stringByConvertingCamelCaseToCapitalizedWords]];

    CGRect fra=[messageTextView frame];
    fra.size.height=messageTextView.contentSize.height;
    
    [textBoxBackground setFrame:CGRectMake(8, 30, 268,fra.size.height)];
    [messageTextView setFrame:fra];
    [belowView setFrame:CGRectMake(8,fra.origin.y+fra.size.height,268, 279)];
    
   if([commentsArray count])
   {
     if ([[commentsArray objectAtIndex:selectedAvatar-1] count]) {
      
        int selectedAvatarVal=0;
        for (int i1=1; i1<=b2.tag; i1++) {
            if ([[[textFloats objectAtIndex:i1-1]   objectForKey:@"TotalComments"] intValue]) {
                selectedAvatarVal++;
            }
        }
        selectedAvatarVal=selectedAvatarVal-1;
     
    }
   
    if ([[[textFloats objectAtIndex:b2.tag-1]   objectForKey:@"TotalComments"] intValue]) {
       
        [CommentTableView reloadData];
        
        
        [commentImmages1 setHidden:YES];
        [commentImmages2 setHidden:YES];
        [messageButton setHidden:YES];
        [commentView setHidden:YES];
        [CommentTableView setHidden:NO];
        
    }
    else {
        
        [commentImmages1 setHidden:NO];
        [commentImmages2 setHidden:NO];
        [messageButton setHidden:NO];

        [commentView setHidden:NO];
        [CommentTableView setHidden:YES];
    }

    [CommentTableView reloadData];
   }
    
}



-(IBAction)nameButtonClicked:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])
    {
    isNameButtonClicked = YES;
    expandedNameController = [[ExpandedNameViewViewController alloc] initWithNibName:@"ExpandedNameViewViewController" bundle:nil];
    [expandedNameController setDic:[ownerandText objectAtIndex:selectedAvatar-1]];
    [expandedNameController setThoughtsDic:[textFloats objectAtIndex:selectedAvatar-1]];
    [expandedNameController setNameString:nameString];
    appDelegate.isNameViewSelected = YES;
    [appDelegate.viewsArray addObject:expandedNameController.view];
    [appDelegate.thoughtsViewArray addObject:expandedNameController.view];
    [self.view addSubview:expandedNameController.view];
    
    //[self.view bringSubviewToFront:city];
    [self.view bringSubviewToFront:bottomBar];
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
-(IBAction)goBackTo:(id)sender
{
   
    if (appDelegate.thoughtsViewArray.count==3) {
        [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
        [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
        [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
        [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
        
    }
    else {
        [[appDelegate.thoughtsViewArray objectAtIndex:appDelegate.thoughtsViewArray.count-1] removeFromSuperview];
        [appDelegate.thoughtsViewArray removeObjectAtIndex:appDelegate.thoughtsViewArray.count-1];
    }
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
-(IBAction)addAvatarImage:(id)sender{
 


    if (isDownloaded) {
        UIButton *b1=(UIButton*)[avatarView viewWithTag:selectedAvatar];
        
        
        [b1 setAlpha:0.3f];
        
        UIButton *b2=(UIButton*)sender;
        [b2 setAlpha:1.0f];
        selectedAvatar=b2.tag;
        
        
        [messageTextView setText:[[textFloats objectAtIndex:b2.tag-1]   objectForKey:@"FloatMessage"]];
       // [nameLabel setText:[[textFloats objectAtIndex:b2.tag-1] objectForKey:@"namestring"]];

        
        [nameLabel setText:[[[[textFloats objectAtIndex:b2.tag-1] objectForKey:@"namestring"] lowercaseString]  stringByConvertingCamelCaseToCapitalizedWords]];

        CGRect fra=[messageTextView frame];
        fra.size.height=messageTextView.contentSize.height;
        
        [textBoxBackground setFrame:CGRectMake(8, 30, 268,fra.size.height)];
        [messageTextView setFrame:fra];
        [belowView setFrame:CGRectMake(8,fra.origin.y+fra.size.height,268, 279)];
        
        
        
        
        
        
        if ([[commentsArray objectAtIndex:selectedAvatar-1] count]) {
            
            
            [commentImmages1 setHidden:YES];
            [commentImmages2 setHidden:YES];
            [messageButton setHidden:YES];
            [commentView setHidden:YES];
            [CommentTableView setHidden:NO];
            [CommentTableView reloadData];
            
        }
        else {
            
            [commentImmages1 setHidden:NO];
            [commentImmages2 setHidden:NO];
            [messageButton setHidden:NO];
            [commentView setHidden:NO];
            [CommentTableView setHidden:YES];
        }

    }


   
    
}
-(IBAction)CommentButtonClicked:(id)sender{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_id"])
    {
    if (isDownloaded) {
        CommentPostViewController *commentpost=[[CommentPostViewController alloc] initWithNibName:@"CommentPostViewController" bundle:nil];
        [commentpost setFromVi:1];
       // NSLog(@"comment Details: %@",commentsArray);
        commentpost.commentsArray=commentsArray;
        [commentpost setSelectedAvatar:selectedAvatar-1];
        [commentpost setCommentImage1:commentImmages1];
        [commentpost setCommentImage2:commentImmages2];
        [commentpost setPreviousTable:CommentTableView];
        [commentpost setSelectedDictionary:[textFloats objectAtIndex:selectedAvatar-1]];
        [self.view addSubview:commentpost.view];
    }
 
   
    }
    
    
    else{
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Ouch!" message:@"We know it's a pain, but you gotta login to do more." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login",nil];
        [alertView show];
        [alertView release];
    }
    
    
}

-(IBAction)airorSinkButtonClicked:(id)sender{
    
   
    ExpandAirSinkViewController *airsink=[[ExpandAirSinkViewController alloc] initWithNibName:@"ExpandAirSinkViewController" bundle:nil];
    [airsink setSelectedVal:1];
    [airsink setDic:[textFloats objectAtIndex:selectedAvatar-1]];
    [self.view addSubview:airsink.view];
    [airsink.view bringSubviewToFront:city];
}

-(void)higligtedImage:(id)sender{
    
  
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

#pragma -TableviewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[commentsArray objectAtIndex:selectedAvatar-1]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 23)];
        [label setFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f]];
        [label setAlpha:0.6];
        [label setTag:1];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setTextColor:[UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:5.0f/255.0f alpha:1]];
        [cell addSubview:label];
        
        
        
        UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 33, 250, 80)];
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setTag:2];
        [textView setEditable:NO];
        [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];
        [cell addSubview:textView];
        
        
        
        UILabel *ownertag=[[UILabel alloc] initWithFrame:CGRectMake(19, 58, 80, 23)];
        
        [ownertag setTag:3];
        [ownertag setBackgroundColor:[UIColor blackColor]];
        [ownertag setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
        [ownertag setAlpha:0.6f];
        [ownertag setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:ownertag];
        [ownertag release];
        
        
        UILabel *dateLbl=[[UILabel alloc] initWithFrame:CGRectMake(19, 69, 90, 23)];
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
    int row=[[commentsArray objectAtIndex:selectedAvatar-1]count]-1;
    row=row-indexPath.row;
    [label setText:[NSString stringWithFormat:@"    00%d",row+1]];
    
    [textVi setText:[[[commentsArray objectAtIndex:selectedAvatar-1] objectAtIndex:row] objectForKey:@"CommentMessage"]];
    
    UILabel *ownLbl=(UILabel *)[cell viewWithTag:3];
    
    CGRect fra=[textVi frame];
    fra.size.height=textVi.contentSize.height;
    [textVi setFrame:fra];
    
    [ownLbl setFrame:CGRectMake(19, textVi.frame.origin.y+textVi.contentSize.height-7, 80,23)];
    
    
    [ownLbl setText:[[[commentsArray objectAtIndex:selectedAvatar-1] objectAtIndex:row] objectForKey:@"OwnerTag"]];
    UILabel *dateLbl=(UILabel *)[cell viewWithTag:4];
    
    [dateLbl setFrame:CGRectMake(19,ownLbl.frame.origin.y+ownLbl.frame.size.height-12 , 90, 23)];
    NSDate *startdate ;
    NSString *dateString=[[[commentsArray objectAtIndex:selectedAvatar-1] objectAtIndex:row] objectForKey:@"CreatedOn"];
    
    
    startdate=[self getDateFromJSON:dateString];
    
    
    
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
        
        dayName=[NSString stringWithFormat:@"%d days ago",days];
    }
    else
    {
        dayName=[NSString stringWithFormat:@"%d hrs ago",hrstemp];
        
        // [timeLabel setText:[NSString stringWithFormat:@"%d hrs ago",hrstemp]];
    }
    
    [dateLbl setText:dayName];
    
    
    //    [cell.textLabel setText:[[[thoughtsArray objectAtIndex:selectedAvatar-1] objectForKey:@"comments"] objectAtIndex:indexPath.row]];
    return cell;

}
- (NSDate*) getDateFromJSON:(NSString *)dateString
{
    
    NSDate *d;
    if (dateString == (id)[NSNull null] || dateString.length == 0 ) {
        d=nil;
    }
    else {
        int startPos = [dateString rangeOfString:@"("].location+1;
        int endPos = [dateString rangeOfString:@")"].location;
        
        NSRange range = NSMakeRange(startPos,endPos-startPos);
        
        dateString=[dateString substringWithRange:range];
        if ([dateString hasPrefix:@"-"]) {
            dateString=[dateString substringFromIndex:1];
            
        }
        unsigned long long milliseconds = [dateString longLongValue];
        
        NSTimeInterval interval = milliseconds/1000;
        d= [NSDate dateWithTimeIntervalSince1970:interval];
    }
    // Expect date in this format "/Date(1268123281843)/"
    return d;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    int row=[[commentsArray objectAtIndex:selectedAvatar-1]count]-1;
    row=row-indexPath.row;
    //NSLog(@"comments: %@",commentsArray);
    
    [tempText setText:[[[commentsArray objectAtIndex:selectedAvatar-1] objectAtIndex:row] objectForKey:@"CommentMessage"]];
    
    CGRect fra=[tempText frame];
    fra.size.height=tempText.contentSize.height;
   // NSLog(@"content  %@ height: %f",[[[commentsArray objectAtIndex:selectedAvatar-1] objectAtIndex:row] objectForKey:@"CommentMessage"],tempText.contentSize.height);
    [tempText setFrame:fra];
    
    
    

    return tempText.contentSize.height+50;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1{
    [commentsDic appendData:data1];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    // responseData=[[NSMutableData alloc] initWithCapacity:1];
    NSString *responseString = [[NSString alloc] initWithData:commentsDic encoding:NSUTF8StringEncoding];
    //[commentsDic setData:nil];
    if ([responseString length]) {
        NSMutableArray *comments=[[responseString JSONValue] objectForKey:@"Comments"];
        NSMutableArray *owner=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
        
       // NSLog(@"Comments : %@ and owner Details: %@",comments,owner);
        
        
        for (int i1=0; i1<[comments count]; i1++)
        {
            NSMutableDictionary *dic=[comments objectAtIndex:i1];
            
            for (int j=0; j<[owner count]; j++)
            {
                if ([[dic objectForKey:@"OwnerId"] isEqualToString:[[owner objectAtIndex:j]objectForKey:@"_id"]])
                {
                    [dic setObject:[[owner objectAtIndex:j] objectForKey:@"OwnerTag"] forKey:@"OwnerTag"];
                    //[dic setObject:[[owner objectAtIndex:j] objectForKey:@"CreatedOn"] forKey:@"CreatedOn"];
                    [comments replaceObjectAtIndex:j withObject:dic];
                    break;
                    
                }
                
            }
            
        }
        [commentsArray addObject:comments];

    }
    else {
        NSMutableArray *ar=[[NSMutableArray alloc] initWithCapacity:1];
        [commentsArray addObject:ar];

    }
    //[thoughtsArray removeAllObjects];
    
    
    if (commentsVal==[textFloats count]-1) {
        

        isDownloaded=YES;
        if ([[[textFloats objectAtIndex:0]   objectForKey:@"TotalComments"] intValue] || [[commentsArray objectAtIndex:0] count]) {
            [CommentTableView reloadData];
            
            
            [commentImmages1 setHidden:YES];
            [messageButton setHidden:YES];
            [commentView setHidden:YES];
            [CommentTableView setHidden:NO];
            
        }
        else {
            
            [commentImmages1 setHidden:NO];
            [messageButton setHidden:NO];
            
            [commentView setHidden:NO];
            [CommentTableView setHidden:YES];
        }
        [commentActivity removeFromSuperview];
        [CommentTableView reloadData];

    }
    else{

        [commentsDic setData:nil];
        commentsVal++;
        [self downloadComments];

        
    }
    
    
   
}

@end
