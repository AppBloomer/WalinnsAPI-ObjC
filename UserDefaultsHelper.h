//
//  UserDefaultsHelper.h
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#ifndef UserDefaultsHelper_h
#define UserDefaultsHelper_h


#endif /* UserDefaultsHelper_h */
#import <Foundation/Foundation.h>

@interface UserDefaultsHelper : NSObject
+(NSString*)getStringForKey:(NSString*)key;
+(void)setStringForKey:(NSString*)value:(NSString*)key;
+(NSDate*)getDateForKey:(NSString*)key;
+(void)setDateForKey:(NSDate*)date:(NSString*)key;
    
@end
