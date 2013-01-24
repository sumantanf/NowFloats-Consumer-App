//
//  UrlInfo.m
//  NowFloatsv1
//
//  Created by pravasis on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UrlInfo.h"
#import "Parser.h"

@implementation UrlInfo
@synthesize urlString;
@synthesize clientId;
@synthesize commentVal;
@synthesize dic;
@synthesize imageNo;
@synthesize dic1;
-(void)setNumb:(int)n;{
    
    commentVal=n;
   
}
-(void)setDictionary:(NSMutableDictionary *)dic1{
    
//dic=dic1;
    
}
- (id) init
{
    /* first initialize the base class */
    self = [super init]; 
   
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
  
    //NSLog(@"appdelegate %f",app.radiusVal);
    
    
    dealsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/dealFloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=nearest&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal];
    eventsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/eventFloats?lat=%f&lng=%f&radius=%f&skipEventBy=0&sortBy=latest&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal];
    aroundUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/floatingPoints/around?lat=%f&lng=%f&radius=%f",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal];

    thoughtsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/textFloats?lat=%f&lng=%f&radius=%f&skipBy=%d&sortBy=latest&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal,appDelegate.skipByValue];
    thoughtsImageUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/imgfloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=latest&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal];

    thoughtsCommentUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/comments/text/"];
       thoughtsImageCommentUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/comments/image/"];
      
    countget=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/floats/count?lat=%f&lng=%f&radius=%f&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal];
        
    return self;
}
-(id)initWithSortURLs:(NSString *)sortByName{
    self = [super init];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    dealsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/dealFloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal,sortByName];
    eventsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/eventFloats?lat=%f&lng=%f&radius=%f&skipEventBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal,sortByName];
    thoughtsUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/textFloats?lat=%f&lng=%f&radius=%f&skipBy=3&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal,sortByName];
    thoughtsImageUrl=[NSString stringWithFormat:@"https://api.withfloats.com/Discover/v1/imgfloats?lat=%f&lng=%f&radius=%f&skipBy=0&sortBy=%@&clientId=5C5C061C6B1F48129AF284A5D0CDFBDD5DC3A7547D3345CFA55C0300160A829A",[[app.locationArray objectAtIndex:0] floatValue],[[app.locationArray objectAtIndex:1] floatValue],app.radiusVal,sortByName];
    return self;
    
}


-(void)parseData:(NSNumber *)selectedValue{
    int selectedVal=[selectedValue intValue];
    Parser *m_parse = [[Parser alloc] init];
    [m_parse setSelectedView:selectedVal];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [m_parse setParent:del];
    
    if (selectedVal==1) {
        [m_parse parseUrl:dealsUrl];
    }
    else if(selectedVal==2){
        [m_parse parseUrl:eventsUrl];
    }
    else if(selectedVal==3){
        [m_parse parseUrl:aroundUrl];
    }
    else if(selectedVal==4){
        [m_parse parseUrl:thoughtsUrl];
      
    }
    else if(selectedVal==5){
        [m_parse setDictionary:dic];
        [m_parse setCommentVal:commentVal];
        [m_parse parseUrl:thoughtsCommentUrl];
        
        
    }
    else if(selectedVal==6){
      //  NSLog(@"thoughts image url: %@",thoughtsImageUrl);
        
      
        [m_parse parseUrl:thoughtsImageUrl];
        
        
    }
    else if (selectedVal==7){
    
      
         [m_parse setDic:dic];
        [m_parse parseUrl:thoughtsImageCommentUrl];
    }
    
    
    else if (selectedVal==99)
    {
    
        [m_parse parseUrl:countget];
    
    }
    
}

-(void)parseAllData{
    
    
    
    AppDelegate *appDel=[[UIApplication sharedApplication]delegate];
    [appDel.dealsData removeAllObjects];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:1] waitUntilDone:YES];
    [appDel.eventsData removeAllObjects];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:2] waitUntilDone:YES];
    [appDel.aroundData removeAllObjects];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:3] waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:4] waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:6] waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:99] waitUntilDone:YES];
    
    
}

-(void)parseEventAndDeals{
    
    AppDelegate *appDel=[[UIApplication sharedApplication]delegate];
    [appDel.dealsData removeAllObjects];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:1] waitUntilDone:YES];
    [appDel.eventsData removeAllObjects];
    [self performSelectorOnMainThread:@selector(parseData:) withObject:[NSNumber numberWithInt:2] waitUntilDone:YES];

    
    
}
-(void)parseCommentsData:(NSString *)clientVal{
    
    thoughtsCommentUrl=[NSString stringWithFormat:@"%@%@",thoughtsCommentUrl,clientVal];
}
-(void)parseSortData{
    
    
}
@end
