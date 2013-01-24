//
//  UploadFloat.h
//  NowFloatsv1
//
//  Created by Sumanta Roy on 17/09/12.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface UploadFloat : NSObject{
    
    AppDelegate *appDelegate;
    NSMutableData *webData;
    NSMutableString *floatId;
    BOOL isTextFloat;
    NSUserDefaults *prefimg;

}
-(void)uploadTextFloat:(NSString *)textFloat andLocation:(NSString *)locationName;
-(void)uploadImageFloats:(UIImage *)image andText:(NSString *)textFloat andLocation:(NSString *)locationName;
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


@end
