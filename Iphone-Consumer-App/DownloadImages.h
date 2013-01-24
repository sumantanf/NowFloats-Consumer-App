//
//  DownloadImages.h
//  NowFloatsv1
//
//  Created by pravasis on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadImages : UIImageView{
    
    NSURLConnection *connection;
    
    NSMutableData* data;
    
    UIActivityIndicatorView *ai;
}
-(void)initWithImageAtURL:(NSURL*)url;  

@property (nonatomic, retain) NSURLConnection *connection;

@property (nonatomic, retain) NSMutableData* data;

@property (nonatomic, retain) UIActivityIndicatorView *ai;
@end
