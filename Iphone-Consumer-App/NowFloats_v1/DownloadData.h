//
//  DownloadData.h
//  NowFloatsv1
//
//  Created by Sumanta Roy on 29/09/12.
//
//

#import <Foundation/Foundation.h>
#import "UrlInfo.h"
#import "Parser.h"
#import "ViewController.h"
#import "AppDelegate.h"
//#import "DealsViewController.h"

@interface DownloadData : NSObject


@property (nonatomic,retain ) DealsViewController *dViewController;



@property(nonatomic,retain) NSMutableArray *dealArray;


-(void)downloadData:(int)value;
-(void)parseDealsData;


@end
