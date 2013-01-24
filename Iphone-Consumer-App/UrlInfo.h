//
//  UrlInfo.h
//  NowFloatsv1
//
//  Created by pravasis on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface UrlInfo : NSObject{
    
    NSString *dealsUrl;
    NSString *eventsUrl;
    NSString *aroundUrl;
    NSString *thoughtsUrl;
    NSString *thoughtsCommentUrl;
    NSString *thoughtsImageUrl;
    NSString *clientId;
    NSString *thoughtsImageCommentUrl;
    int commentVal;
    NSMutableDictionary *dic;
    NSString *countget;
    AppDelegate *appDelegate;
    int imageNo;
    
}
@property (nonatomic ,retain) NSString *urlString;
@property (nonatomic ,retain ) NSString *clientId;
@property (nonatomic ) int commentVal;
@property (nonatomic, copy) NSMutableDictionary *dic;
@property (nonatomic ,retain ) NSMutableDictionary *dic1;
@property (nonatomic ) int imageNo;

//-(void)parseData:(int)selectedValue;
-(void)parseData:(NSNumber *)selectedValue;
-(void)parseAllData;
-(void)parseEventAndDeals;
-(void)setNumb:(int)n;
-(void)setDictionary:(NSMutableDictionary *)dic1;
-(id)initWithSortURLs:(NSString *)sortByName;
@end
