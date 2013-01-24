//
//  Parser.m
//  NowFloatsv1
//
//  Created by pravasis on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"
#import "AppDelegate.h"

@implementation Parser

@synthesize parent,selectedView;
@synthesize commentVal;
@synthesize  dic;
-(void)parseUrl:(NSString *)url{

    data=[[NSMutableData alloc] initWithCapacity:1];

    if (dic) {
       
        
        url=[NSString stringWithFormat:@"%@%@",url,[dic objectForKey:@"_id"]];
    }
   
    
         NSURL *urlValue=[NSURL URLWithString:url];
    
 
    if (selectedView==99)
    {
       // NSLog(@"url is: %@",urlValue);
    }
    
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:urlValue];
    
    NSURLConnection *connection;
    connection=[NSURLConnection connectionWithRequest:theRequest delegate:self];
    //[connection release];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
    appDelegate.isInternet=YES;;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (selectedView==3)
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        int code = [httpResponse statusCode];
        [parent setAroundResposeCode:code];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1{
    [data appendData:data1];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
   // responseData=[[NSMutableData alloc] initWithCapacity:1];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

   
	data = nil;
    
    if (selectedView==1) {
    
        NSMutableArray  *latestDeals = [(NSDictionary*)[responseString JSONValue] objectForKey:@"OfflineDeals"];
        [parent getData:latestDeals];
      
    }
    
    
  else if(selectedView==2)
  {
      NSMutableArray *eventData=[responseString JSONValue];
    
     [parent getEventData:eventData];
  }
    
  else if (selectedView==3){
      NSMutableArray *eventData=[responseString JSONValue];
      
      
      [parent getArrounData:eventData];
  }
  else if (selectedView==4){
      NSMutableArray *eventData=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
      
      
      [parent getThoughData:eventData];
      NSMutableArray *eventdata2=[[responseString JSONValue] objectForKey:@"TextFloats"];
     
      [parent getThoughTextFloatData:eventdata2];

  }
  else if (selectedView==5){

      if ([responseString length]) {
          
          NSMutableArray *eventData=[[responseString JSONValue] objectForKey:@"Comments"];
          [parent getThoughtsComment:eventData];
      }
      else {
          NSMutableArray *event=[[NSMutableArray alloc] initWithCapacity:0];
          
         [parent getThoughtsComment:event];
      }

      
      
  }
  else if (selectedView==6)
  {
      
      NSMutableArray *eventData=[[responseString JSONValue] objectForKey:@"ImageFloats"] ;
      
      [parent getThoughtsImageData:eventData];
      
      NSMutableArray *ownerDet=[[responseString JSONValue] objectForKey:@"OwnerDetails"];
      [parent getImageOwnerDetails:ownerDet];
      //[parent getThoughtsComment:eventData];
      
  }
  else if (selectedView ==7){

     // NSLog(@"image comments: %@",imageComments);
      
      if ([responseString length]) {
           NSMutableArray *imageComments=[[responseString JSONValue] objectForKey:@"Comments"];

         [parent getImageCommentsData:imageComments];
      }
      else {
       
          NSMutableArray *temp=[[NSMutableArray alloc] initWithCapacity:1];
          [parent getImageCommentsData:temp];
          
      }
       }
    
    
    else if (selectedView==99)
        
    {
        NSMutableDictionary *countdic=[responseString JSONValue];
        
        [parent parsecdata:countdic];
    
       // NSLog(@"hai from parse done");
    
    }
    
    
    
}
-(void)setDictionary:(NSMutableDictionary *)dic1{
    
    dic=dic1;
    
}


@end
