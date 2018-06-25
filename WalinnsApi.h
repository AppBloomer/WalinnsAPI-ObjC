//
//  WalinnsAPI.h
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//
#ifndef WalinnsApi_h
#define WalinnsApi_h


#endif /* WalinnsApi_h */

#import <Foundation/Foundation.h>

@interface WalinnsApi : NSObject
    
    @property NSString *url;
    
    @property (nonatomic, strong, readonly) NSString *apiKey;
    @property (nonatomic, strong, readonly) NSString *deviceId;
    @property (nonatomic, strong, readonly) NSString *instanceName;
    
    
+ (WalinnsApi *)instance;
    
+ (WalinnsApi *)instanceWithName:(NSString*) instanceName;
    
- (void)initializeToken:(NSString*) apiKey;
    
- (void)setDeviceId:(NSString*) deviceId;
    
- (NSString*)getDeviceId;
    
- (void)regenerateDeviceId;
    
- (void)trackEvent:(NSString *)event_name:(NSString *)event_type;
    
-(void)track:(NSString *)screen_name;
    
-(void)sendPush_Token:(NSString *)push_token;
    
- (void)graphUser:(NSDictionary *)fbGraphUser;
    
@end
