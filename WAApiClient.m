//
//  WAApiClient.m
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#import "WAApiClient.h"
#import "UserDefaultsHelper.h"

@interface WAApiclient()
    @end

@implementation WAApiclient : NSObject
    
    
+(void) pushedData:(NSDictionary*) requesData :(NSString *) flag{
    NSError *error;
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSString *project_token = [UserDefaultsHelper getStringForKey:@"project_token"];
    NSString *str =  @"https://wa.track.app.walinns.com/";
    str = [str stringByAppendingString:flag];
    NSURL *urll = [NSURL URLWithString:str];
    NSLog(@"Final URL =%@", urll);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urll
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:project_token forHTTPHeaderField:@"Authorization"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requesData options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            if([flag  isEqual: @"devices"]){
                [UserDefaultsHelper setStringForKey:@"authenticated" :@"device"];
            }
        }
        else
        {
            NSLog(@"Errorrrrrr = %@" , error);
        }
    }];
    
    [postDataTask resume];
}
    
    @end


