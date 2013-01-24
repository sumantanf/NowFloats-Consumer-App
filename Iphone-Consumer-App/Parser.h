//
//  Parser.h
//  NowFloatsv1
//
//  Created by pravasis on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "JSON.h"
#import <UIKit/UIKit.h>

@interface Parser : NSObject <NSXMLParserDelegate,NSURLConnectionDelegate>{
    
    NSMutableData *data;
    NSMutableData *responseData;
     NSMutableDictionary *dic;
}
@property (nonatomic,retain) id parent;
@property (nonatomic ) int selectedView;
@property (nonatomic ) int commentVal;
@property (nonatomic, copy) NSMutableDictionary *dic;

-(void)parseUrl:(NSString *)url;

-(void)setDictionary:(NSMutableDictionary *)dic1;
@end
