//
//  WAUtils.h
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#ifndef WAUtils_h
#define WAUtils_h


#endif /* WAUtils_h */
#import <Foundation/Foundation.h>

@interface WAUtils : NSObject
    
+ (NSString*) generateUUID;
    
+ (id) makeJSONSerializable:(id) obj;
    
+ (BOOL) isEmptyString:(NSString*) str;
    
+ (NSDictionary*) validateGroups:(NSDictionary*) obj;
    
+ (NSString*) platformDataDirectory;
+ (NSString *)getUTCFormateDate:(NSDate *)localDate;
+(NSString*)sessionDuration:(NSDate *)startDate;
@end
    
