//
//  CreateFloatViewController.m
//  NowFloatsv1
//
//  Created by pravasis on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateFloatViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "ViewController.h"



@interface CreateFloatViewController ()

@end

@implementation CreateFloatViewController
@synthesize appDelegate ;

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
    prefs = [NSUserDefaults standardUserDefaults];
    prefimg=[NSUserDefaults standardUserDefaults];
   // NSLog(@"prefs:%@",[prefs objectForKey:@"floattext"]);
       
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
    

    createFloatTextView.text=[prefs objectForKey:@"floattext"];
        
   // pickImage.image=[prefimg objectForKey:@"image"];    
 
    //NSLog(@"image path:%@",[prefimg objectForKey:@"image"]);
    
    
    UIImage* image = [UIImage imageWithContentsOfFile:[prefimg objectForKey:@"image"]];
    
    
    //pickImage.image=image;
    
    

    if ([prefimg objectForKey:@"image"]!=NULL) 
    
    {
        //NSLog(@"bugg");
        pickImage.image=image;

        [self movingImage];

    }
    
    
    
    
    
    [bottomNewBar setContentSize:CGSizeMake(580, 50)];
    
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.aroundData count]) {
        [locationLabel setText:[[[appDelegate.aroundData objectAtIndex:appDelegate.selectedArondValue] objectForKey:@"Name"] uppercaseString]];

    }
    [appDelegate arrangeBottomButtons:bottomNewBar];
    //[locationLabel setText:@"Some where"];
    [createFloatTextView setDelegate:self];
    
    [createFloatTextView becomeFirstResponder];
     
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    [barView setFrame:CGRectMake(0, 194, 320, 35)];
    [numberLabel setFrame:CGRectMake(33, 76, 254, 149)];
    [countHolder setFrame:CGRectMake(17, 69, 284, 284)];
    [UIView commitAnimations];

    selectedLocationIndex = -1;
    
    locationDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [locationDataArray addObject:@"Dummy Location 1"];
    [locationDataArray addObject:@"Dummy Location 2"];
    [locationDataArray addObject:@"Dummy Location 3"];
    [locationDataArray addObject:@"Dummy Location 4"];
    [locationDataArray addObject:@"Dummy Location 5"];
    [locationDataArray addObject:@"Dummy Location 6"];
    [locationDataArray addObject:@"Dummy Location 7"];
    
    color = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:5/255.0 alpha:1];
    
    barView = [[UIView alloc] initWithFrame:CGRectMake(0, 375, 320, 35)];
    [barView setAlpha:1.0f];
    [barView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"options_bar.png"]]];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"iphone At Sign.png"] forState:UIControlStateNormal];
    [btn1 setTag:1];
    [btn1 addTarget:self action:@selector(setSpecialValues:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:color forState:UIControlStateNormal];
    
    [btn1 setFrame:CGRectMake(28, 4, 22 ,21)];
    [barView addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"iPhone Exclaim.png"] forState:UIControlStateNormal];
    [btn2 setTag:2];
    [btn2 addTarget:self action:@selector(setSpecialValues:) forControlEvents:UIControlEventTouchUpInside];
    //[btn1 addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:color forState:UIControlStateNormal];
    
    [btn2 setFrame:CGRectMake(110, 4, 5 ,23)];
    [barView addSubview:btn2];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btn4 setTitle:@"Button4" forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"camera_icon_yellow.png"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(selectPhotoType) forControlEvents:UIControlEventTouchUpInside];
    //[btn1 addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleColor:color forState:UIControlStateNormal];
    
    [btn3 setFrame:CGRectMake(180,6,31,20)];
    [barView addSubview:btn3];
    
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setImage:[UIImage imageNamed:@"Keyboard Icon.png"] forState:UIControlStateNormal];
    [btn4 setFrame:CGRectMake(260, 7, 41, 20)];
    [btn4 addTarget:self action:@selector(resignKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:btn4];
//    
//    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    //[btn4 setTitle:@"Button4" forState:UIControlStateNormal];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"camera_icon_yellow.png"] forState:UIControlStateNormal];
//    [btn4 addTarget:self action:@selector(resignKeyBoard) forControlEvents:UIControlEventTouchUpInside];
//    [btn4 setTitleColor:color forState:UIControlStateNormal];
//    
//    [btn4 setFrame:CGRectMake(262, 9, 34 ,22)];
//   // [barView addSubview:btn4];
//
    [self.view addSubview:barView];
    
    //[createFloatTextField becomeFirstResponder];
    
//    bottomBar = [[BottomBarViewController alloc] initWithNibName:@"BottomBarViewController" bundle:nil];
//    [bottomBar.view setFrame:CGRectMake(0, 410, 320, 50)];
//    
//    [bottomBar.bottomScrollView setShowsHorizontalScrollIndicator:NO];
//    [bottomBar.bottomScrollView setPagingEnabled:YES];
//    //[bottomBar setContentSize:CGSizeMake(640, 40)];
//    [bottomBar.bottomScrollView setContentSize:CGSizeMake(592, 50)];
//    [bottomBar.bottomScrollView setBackgroundColor:[UIColor blackColor]];
//    //bottomBar.bottomScrollView.frame = m_appDel.bottomBarFrame;
//    
//    [self.view addSubview:bottomBar.view];
//        
//    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button4.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
//    [button4 setTitle:@"BACK" forState:UIControlStateNormal];
//    [button4 addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [button4 setTitleColor:color forState:UIControlStateNormal];
//    
//    [button4 setFrame:CGRectMake(1, 7, 273 ,36)];
//    [bottomBar.bottomScrollView addSubview:button4];
//    
//    OButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [OButton1.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
//    [OButton1 setBackgroundImage:[UIImage imageNamed:@"float_button_day.png"] forState:UIControlStateNormal];
//    [OButton1 setTitleColor:color forState:UIControlStateNormal];
//    
//    [OButton1 setFrame:CGRectMake(274, 4, 42 ,42)];
//    [OButton1 addTarget:self action:@selector(gotoHomePage:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomBar.bottomScrollView addSubview:OButton1];
//            
//    UIImageView *arrowimgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(322, 19, 11, 12)];
//    [arrowimgView1 setImage:[UIImage imageNamed:@"t1_day.png"]];
//    [bottomBar.bottomScrollView addSubview:arrowimgView1];
//    [arrowimgView1 release];
//    
//    UIImageView *arrowimgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(337, 19, 11, 12)];
//    [arrowimgView2 setImage:[UIImage imageNamed:@"t1_day.png"]];
//    [bottomBar.bottomScrollView addSubview:arrowimgView2];
//    [arrowimgView2 release];
//    
//    UIImageView *arrowimgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(352, 19, 11, 12)];
//    [arrowimgView3 setImage:[UIImage imageNamed:@"t1_day.png"]];
//    [bottomBar.bottomScrollView addSubview:arrowimgView3];
//    [arrowimgView3 release];
//    
//    UIImageView *arrowimgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(365, 19, 11, 12)];
//    [arrowimgView4 setImage:[UIImage imageNamed:@"t1_day.png"]];
//    [bottomBar.bottomScrollView addSubview:arrowimgView4];
//    [arrowimgView4 release];

    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    NSMutableArray *countArray=(NSMutableArray *)[textView.text componentsSeparatedByString:@" "];
    if ([countArray count]>1) {
        if ([countArray count]<11) {
             [numberLabel setText:[NSString stringWithFormat:@"0%d",[countArray count]-1]];
        }
        else{
        [numberLabel setText:[NSString stringWithFormat:@"%d",[countArray count]-1]];
        }

    }
    else{
        [numberLabel setText:[NSString stringWithFormat:@"00"]];
    }
    
    
    
    return YES;
}
-(void)selectPhotoType{
    
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Image floats coming soon" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [alert show];
//    [alert release];
    
    [pickImage setHidden:NO];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Photo" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Choose from Library", nil];
    [alert show];
}
-(void)resignKeyBoard
{
   // NSLog(@"resignKeyBoard method.....!");
    [createFloatTextView resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20f];
    barView.frame = CGRectMake(0, 375, 320, 35);
    [numberLabel setFrame:CGRectMake(33, 216, 254, 223)];
    [countHolder setFrame:CGRectMake(17, 228, 284, 284)];
    [UIView commitAnimations];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    

    if (alertView.tag == 999)
    {
        //NSLog(@"alertView.tag == 999") ;
        if (buttonIndex == 0)
        {
            pickImage.image = nil ;
            [pickImage setHidden:YES];
            [closeButton removeFromSuperview];
            
            [ UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            [textFloatView setFrame:CGRectMake(0, 16, 320, 254)];
            [UIView commitAnimations];
            
        }else if(buttonIndex == 1)
        {
            
        }
    }else{
    
    
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    if (buttonIndex==1) {
//        UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
//        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentModalViewController:imagePicker animated:YES];
    }
    else  if(buttonIndex==2) {

        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:imagePicker animated:YES];
    }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [pickImage setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
	    
    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
	NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0f)];//1.0f = 100% quality
    [data2 writeToFile:jpegFilePath atomically:YES];
    
    [prefimg setObject:[NSString stringWithFormat:@"%@/test.jpeg",docDir] forKey:@"image"];
    
    
    [picker dismissModalViewControllerAnimated:YES];
    
    [self movingImage];
    
    
}

-(void)movingImage{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20];
    [pickImage setFrame:CGRectMake(12, 24, 80, 80)];
    [textFloatView setFrame:CGRectMake(0, 113, 320, 254)];
    
    closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    
    [closeButton setFrame:CGRectMake(80,12, 26, 26)];
    
    [self.view addSubview:closeButton];
    [UIView commitAnimations];
    [closeButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //[pickImage addSubview:closeButton];
    [self.view setUserInteractionEnabled:YES];
    [pickImage bringSubviewToFront:closeButton];
    [pickImage setUserInteractionEnabled:YES]; 
    [closeButton setUserInteractionEnabled:YES];
}
- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: 
                      [NSString stringWithString: @"test.jpeg"] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;

}

-(void)buttonClicked
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"test.jpeg"]];
    
    NSError *error = nil;
    if(![fileManager removeItemAtPath:fullPath error:&error]) {
        //NSLog(@"Delete failed:%@", error);
    } else {
        //NSLog(@"image removed: %@", fullPath);
        [prefimg removeObjectForKey:@"image"];
        [prefimg synchronize];
    }

    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Do you want to remove \nthis image?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No",nil];


    
    alert.tag = 999 ;
     [alert show];
    [alert release];
    
    
    //NSLog(@"close button is working");
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissModalViewControllerAnimated:YES];

    
}
/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [createFloatTextView resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20f];
    barView.frame = CGRectMake(0, 360, 320, 50);
    [numberLabel setFrame:CGRectMake(33, 206, 254, 223)];
    [countHolder setFrame:CGRectMake(17, 228, 284, 284)];
    [UIView commitAnimations];

}*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    [barView setFrame:CGRectMake(0, 209, 320, 35)];
    [numberLabel setFrame:CGRectMake(33, 76, 254, 149)];
    [countHolder setFrame:CGRectMake(17, 69, 284, 284)];
    [UIView commitAnimations];
}

-(IBAction)goBack:(id)sender
{
    
    
    [prefs setObject:createFloatTextView.text forKey:@"floattext"];
    
    [self.view removeFromSuperview];
}

-(IBAction)gotoHomePage:(id)sender
{
    AppDelegate *m_appDel = [[UIApplication sharedApplication] delegate];
    
    for(int i=0;i<[m_appDel.viewsArray count];i++)
    {
        [[m_appDel.viewsArray objectAtIndex:i] removeFromSuperview];
    }
    
    [m_appDel.viewsArray removeAllObjects];
}

-(IBAction)displayTableView:(id)sender
{
    
    [createFloatTextView resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20f];
    barView.frame = CGRectMake(0, 375, 320, 35);
    [numberLabel setFrame:CGRectMake(33, 216, 254, 223)];
    [countHolder setFrame:CGRectMake(17, 228, 284, 284)];
    [UIView commitAnimations];

    if(!isPopOverPresent)
    {
        [popoverTable setHidden:NO];
        [tableBack setHidden:NO];
        isPopOverPresent = YES;
    }
    else
    {
        [popoverTable setHidden:YES];
        [tableBack setHidden:YES];
        isPopOverPresent = NO;
    }
}

#pragma UITableViewDelegates

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
    }
        
    cell.textLabel.text = [[[appDelegate.aroundData objectAtIndex:indexPath.row] objectForKey:@"Name"] uppercaseString];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.0f]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0 blue:5.0/255.0 alpha:1]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 30.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        selectedLocationIndex = indexPath.row;
    [locationLabel setText:[[[appDelegate.aroundData objectAtIndex:indexPath.row] objectForKey:@"Name"] uppercaseString]];

    [popoverTable setHidden:YES];
    [tableBack setHidden:YES];
    isPopOverPresent = NO;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
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

-(IBAction)submit:(id)sender{
    

    if (pickImage.image || createFloatTextView.text.length>0)
    {
        if (pickImage.image) 
        {
            
            [self resignKeyBoard];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            bobbleImageView.frame = CGRectMake(80, -200, 160, 160);
            [UIView commitAnimations];
            [self performSelector:@selector(removefromImage) withObject:bobbleImageView afterDelay:2];
            
            
        }
        
        else
        {
            [self resignKeyBoard];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:2];
            bobbleImageView.frame = CGRectMake(80, -200, 160, 160);
            [UIView commitAnimations];
            [self performSelector:@selector(remove) withObject:bobbleImageView afterDelay:2];
            
        }
           
    }
    else {
                

    }
}
-(void)remove
{
   [self.view removeFromSuperview];
    
   ThoughtsViewController *m_thoughtsController  = [[ThoughtsViewController alloc] initWithNibName:@"ThoughtsViewController" bundle:nil];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:[createFloatTextView text] forKey:@"float"];
    [dic setObject:[locationLabel text] forKey:@"location"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"isFrom"];

    [m_thoughtsController setFloatDic:dic];
    [m_thoughtsController setIsFromFloat:YES];
    
    if([appDelegate.viewsArray count]>0)
    {
        [appDelegate clearArray];
    }
    
    [appDelegate.viewsArray addObject:m_thoughtsController.view];
    [appDelegate.backupVC.view addSubview:m_thoughtsController.view];
   
}
-(void)removefromImage{
    
    
    [self.view removeFromSuperview];
    
    ThoughtsViewController *m_thoughtsController  = [[ThoughtsViewController alloc] initWithNibName:@"ThoughtsViewController" bundle:nil];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:[createFloatTextView text] forKey:@"float"];
    [dic setObject:[locationLabel text] forKey:@"location"];
    [m_thoughtsController setPickingImage:pickImage.image];
    [dic setObject:[NSNumber numberWithInt:2] forKey:@"isFrom"];
    
    [m_thoughtsController setFloatDic:dic];
    [m_thoughtsController setIsFromFloat:YES];
    
    if([appDelegate.viewsArray count]>0)
    {
        [appDelegate clearArray];
    }
    
    [appDelegate.viewsArray addObject:m_thoughtsController.view];
    [appDelegate.backupVC.view addSubview:m_thoughtsController.view];

    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    if (code==200) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Your thought is now floating. Look it up."  delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    
    
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Failure:" message:@"Your thought didn’t take off... Trying floating it again."  delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [appDelegate.thoughtsTab reloadData];
        
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"error is %@",[error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
//    NSString* newStr = [[[NSString alloc] initWithData:webData
//                                              encoding:NSUTF8StringEncoding] autorelease];
    
}
-(void)setSpecialValues:(id)sender
{                 
    UIButton *b=(UIButton *)sender;
    NSString *st=createFloatTextView.text;
    [createFloatTextView setText:@""];
    if (b.tag==1) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Private floats coming soon." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        //st=[NSString stringWithFormat:@"%@@",st];
    }
    else {
         st=[NSString stringWithFormat:@"%@ !",st];
        NSMutableArray *countArray=(NSMutableArray *)[st componentsSeparatedByString:@" "];
        if ([countArray count]>1) {
            if ([countArray count]<11) {
                [numberLabel setText:[NSString stringWithFormat:@"0%d",[countArray count]-1]];
            }
            else{
                [numberLabel setText:[NSString stringWithFormat:@"%d",[countArray count]-1]];
            }
        }
        else{
            [numberLabel setText:[NSString stringWithFormat:@"0"]];
        }
        

    }
    [createFloatTextView setText:st];
}




-(void)createAnimation{
    
    [createFloatTextView resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20f];
    barView.frame = CGRectMake(0, 375, 320, 35);
    [numberLabel setFrame:CGRectMake(33, 216, 254, 223)];
    [countHolder setFrame:CGRectMake(17, 228, 284, 284)];
    [UIView commitAnimations];
    
    
}
@end
