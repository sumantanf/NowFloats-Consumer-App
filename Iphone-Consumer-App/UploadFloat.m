//
//  UploadFloat.m
//  NowFloatsv1
//
//  Created by Sumanta Roy on 17/09/12.
//
//

#import "UploadFloat.h"
#import "JSON.h"

@implementation UploadFloat

-(void)uploadTextFloat:(NSString *)textFloat andLocation:(NSString *)locationName{
    isTextFloat=YES;
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    webData=[[NSMutableData alloc] initWithCapacity:1];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:1];
    //[dic setValue:@"5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A" forKey:@"clientId"];
    [dic setValue:[appDelegate.locationArray objectAtIndex:0] forKey:@"lat"];
    [dic setValue:[appDelegate.locationArray objectAtIndex:1] forKey:@"lng"];
    [dic setValue:locationName forKey:@"NearByLocationName"];
    [dic setValue:[NSNumber numberWithInt:14] forKey:@"height"];
    [dic setValue:[NSNumber numberWithBool:NO] forKey:@"IsLocationSpecificFloat"];
    [dic setValue:[NSNumber numberWithInt:7] forKey:@"DefaultExpiryPeriod"];
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"] forKey:@"OwnerId"];
    
    [dic setValue:textFloat forKey:@"FloatMessage"];
    
    [dic setValue:[NSNumber numberWithFloat:1.0] forKey:@"hError"];
    
    NSString *newurlString=[dic JSONRepresentation];
    
    
    NSString *url=@"https://api.withfloats.com/Discover/v1/float/createText?clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A";
    NSData *postData = [newurlString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *theConnection;
    
    theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
-(void)uploadImageFloats:(UIImage *)image andText:(NSString *)textFloat andLocation:(NSString *)locationName
{

       
    NSString *uuid = [[NSProcessInfo processInfo] globallyUniqueString];
    
    NSRange range = NSMakeRange (0, 36);
        
    uuid=[uuid substringWithRange:range];
        
    NSCharacterSet *removeCharSet = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    uuid = [[uuid componentsSeparatedByCharactersInSet: removeCharSet] componentsJoinedByString: @""];
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImage *img=[image copy];
    NSData *postData = UIImageJPEGRepresentation(img, 1.0);
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSString *post = [NSString stringWithFormat:@"https://api.withfloats.com/Discover/float/createImage?lat=%f&lng=%f&loc=%@&msg=%@&reqType=parallel&owner=%@&reqtId=%@&totalChunks=1&currentChunkNumber=1",[[appDelegate.locationArray objectAtIndex:0] floatValue],[[appDelegate.locationArray objectAtIndex:1] floatValue],locationName,textFloat,[[NSUserDefaults standardUserDefaults] objectForKey:@"_id"],uuid];

    post=[post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"binary/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setCachePolicy:NSURLCacheStorageAllowed];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *theConnection;
    theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];


    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
    if (code==200)
    {
        prefimg=[NSUserDefaults standardUserDefaults];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"WooHoo" message:@"Your thought is now floating.\n Look it up."  delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        
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
            
    }
    
    
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Your thought didn’t take off... Trying floating it again."  delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [appDelegate.thoughtsTab reloadData];
    
    
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
        floatId = [[[NSMutableString alloc] initWithData:webData
                                                 encoding:NSUTF8StringEncoding] autorelease];
    
    [floatId replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [floatId length])];
    if (isTextFloat) {
        if ([appDelegate.thoughsTextFloats count]) {
            NSMutableDictionary *dic= (NSMutableDictionary *)[appDelegate.thoughsTextFloats objectAtIndex:0];
            
            [dic setObject:floatId forKey:@"_id"];
            [appDelegate.thoughsTextFloats replaceObjectAtIndex:0 withObject:dic];
        }
       
        //[dic release];
        [appDelegate.thoughtsTab reloadData];

    }
    
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
