//
//  TGGlobalClass.m
//  Taligate
//
//  Created by Soumarsi Kundu on 23/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGGlobalClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
@implementation TGGlobalClass
{
    Urlresponceblock _responce;
}

-(void)GlobalDict:(NSString *)parameter Withblock:(Urlresponceblock)responce
{
    
    NSURL *url = [NSURL URLWithString:parameter];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    connection=nil;
    _responce=[responce copy];
 
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    _responce(result,nil);

}

-(void)Userdict:(NSDictionary *)userdetails
{
    UserData = [[NSUserDefaults alloc]init];
    
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"userid"];
    [UserData setObject:[userdetails objectForKey:@"first_name"] forKey:@"firstname"];
    [UserData setObject:[userdetails objectForKey:@"last_name"] forKey:@"lastname"];
    [UserData setObject:[userdetails objectForKey:@"email"] forKey:@"email"];
    [UserData setObject:[userdetails objectForKey:@"type"] forKey:@"type"];
    [UserData setObject:@"YES" forKey:@"Logout"];
    [UserData synchronize];
}
- (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
@end
