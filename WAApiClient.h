//
//  WAApiClient.h
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#ifndef WAApiClient_h
#define WAApiClient_h


#endif /* WAApiClient_h */
#import <Foundation/Foundation.h>

@interface WAApiclient : NSObject
    
    @property NSString *url;
    
+ (void) pushedData:(NSDictionary *) requestData:(NSString *) flag;
    
    
    @end
