//
//  DownloadData.m
//  NowFloatsv1
//
//  Created by Sumanta Roy on 29/09/12.
//
//

#import "DownloadData.h"
#import "ViewController.h"
#import "Parser.h"
#import "UrlInfo.h"
#import "DealsViewController.h"


@implementation DownloadData
@synthesize dViewController,dealArray;



-(void)downloadData:(int)value
{
   
    switch (value) {
            
        case 1:
        [self performSelector:@selector(parseDealsData) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
            break;
        case 2:
        [self performSelector:@selector(parseEventsData) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
            break;
        case 3:
        [self performSelector:@selector(parseThoughtsData) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
            break;
            
            
        default:
            break;
    }


}

-(void)parseDealsData{
    
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:1]];
    [url release];
    
}
-(void)parseEventsData{
    
    
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:2]];
    
    [url release];
    
    
}
-(void)parseThoughtsData{
    UrlInfo *url=[[UrlInfo alloc] init];
    [url parseData:[NSNumber numberWithInt:4]];
    [url release];
}

@end
