//
//  TGGlobalClass.h
//  Taligate
//
//  Created by Soumarsi Kundu on 23/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGGlobal.h"

@interface TGGlobalClass : NSObject<NSURLConnectionDelegate>
{
    NSDictionary *DataDictionary;
    NSMutableData *responseData;
    NSURLConnection *connection;
    NSUserDefaults *UserData;
}

-(void)GlobalDict:(NSString *)parameter Withblock:(Urlresponceblock)responce;
- (BOOL)connectedToNetwork;
-(void)Userdict:(NSDictionary *)userdetails;

@end
