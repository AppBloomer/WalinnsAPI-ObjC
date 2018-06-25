//
//  WADeviceInfo.h
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#ifndef WADeviceInfo_h
#define WADeviceInfo_h


#endif /* WADeviceInfo_h */
#import <Foundation/Foundation.h>

@interface WADeviceInfo : NSObject
    
-(id) init;
    @property (readonly) NSString *appVersion;
    @property (readonly) NSString *osName;
    @property (readonly) NSString *osVersion;
    @property (readonly) NSString *manufacturer;
    @property (readonly) NSString *model;
    @property (readonly) NSString *carrier;
    @property (readonly) NSString *screenDpi;
    @property (readonly) NSString *connectivity;
    @property (readonly) NSString *screenHeight;
    @property (readonly) NSString *screenWidth;
    @property (readonly) NSString *language;
    @property (readonly) NSString *country;
    @property (readonly) NSString *advertiserID;
    @property (readonly) NSString *vendorID;
    
    
+(NSString*) generateUUID;
    
    @end

