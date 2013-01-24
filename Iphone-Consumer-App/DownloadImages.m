//
//  DownloadImages.m
//  NowFloatsv1
//
//  Created by pravasis on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadImages.h"

@implementation DownloadImages
@synthesize connection,data,ai;
-(void)initWithImageAtURL:(NSURL*)url {
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self setContentMode:UIViewContentModeScaleToFill];
    
    if (!ai){
        
        [self setAi:[[UIActivityIndicatorView alloc]   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]]; 
        
        [ai startAnimating];
        
        [ai setFrame:CGRectMake(27.5, 27.5, 20, 20)];
        
        [ai setColor:[UIColor blackColor]];
        
        [self addSubview:ai];
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];    
}


- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    
    if (data==nil) data = [[NSMutableData alloc] initWithCapacity:5000];
    
    [data appendData:incrementalData];
    
   // NSNumber *resourceLength = [NSNumber numberWithUnsignedInteger:[data length]];
    
   
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
  
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [ai removeFromSuperview];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self setImage:[UIImage imageWithData: data]];
    
    [ai removeFromSuperview];   
}

@end
