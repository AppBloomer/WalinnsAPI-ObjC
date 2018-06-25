//
//  WAUtils.m
//  WalinnsAnalytics
//
//  Created by Walinns Innovation on 09/02/18.
//  Copyright © 2018 Walinns Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAUtils.h"
#import "UserDefaultsHelper.h"
#import "WAARCMacros.h"



@interface WAUtils()
    @end

@implementation WAUtils
    
+ (NSString*)generateUUID
    {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
#if __has_feature(objc_arc)
        NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
#else
        NSString *uuidStr = (NSString *) CFUUIDCreateString(kCFAllocatorDefault, uuid);
#endif
        CFRelease(uuid);
        return  uuidStr;
    }
    
+ (id) makeJSONSerializable:(id) obj
    {
        if (obj == nil) {
            return [NSNull null];
        }
        if ([obj isKindOfClass:[NSString class]] ||
            [obj isKindOfClass:[NSNull class]]) {
            return obj;
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            if (!isfinite([obj floatValue])) {
                return [NSNull null];
            } else {
                return obj;
            }
        }
        if ([obj isKindOfClass:[NSDate class]]) {
            return [obj description];
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *arr = [NSMutableArray array];
            id objCopy = [obj copy];
            for (id i in objCopy) {
                [arr addObject:[self makeJSONSerializable:i]];
            }
            objCopy;
            return [NSArray arrayWithArray:arr];
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            id objCopy = [obj copy];
            for (id key in objCopy) {
                NSString *coercedKey = [self coerceToString:key withName:@"property key"];
                dict[coercedKey] = [self makeJSONSerializable:objCopy[key]];
            }
            objCopy;
            return [NSDictionary dictionaryWithDictionary:dict];
        }
        NSString *str = [obj description];
//        WALINNS_LOG(@"WARNING: Invalid property value type, received %@, coercing to %@", [obj class], str);
        return str;
    }
    
+ (NSString *) coerceToString: (id) obj withName:(NSString *) name
    {
        NSString *coercedString;
        if (![obj isKindOfClass:[NSString class]]) {
            coercedString = [obj description];
//            WALINNS_LOG(@"WARNING: Non-string %@, received %@, coercing to %@", name, [obj class], coercedString);
        } else {
            coercedString = obj;
        }
        return coercedString;
    }
    
+ (BOOL) isEmptyString:(NSString*) str
    {
        return str == nil || [str isKindOfClass:[NSNull class]] || [str length] == 0;
    }
    
+ (NSDictionary *) validateGroups:(NSDictionary *) obj
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        id objCopy = [obj copy];
        for (id key in objCopy) {
            NSString *coercedKey = [self coerceToString:key withName:@"groupType"];
            
            id value = objCopy[key];
            if ([value isKindOfClass:[NSString class]]) {
                dict[coercedKey] = value;
            } else if ([value isKindOfClass:[NSArray class]]) {
                NSMutableArray *arr = [NSMutableArray array];
                for (id i in value) {
                    if ([i isKindOfClass:[NSArray class]]) {
//                        WALINNS_LOG(@"WARNING: Skipping nested NSArray in groupName value for groupType %@", coercedKey);
                        continue;
                    } else if ([i isKindOfClass:[NSDictionary class]]) {
//                        WALINNS_LOG(@"WARNING: Skipping nested NSDictionary in groupName value for groupType %@", coercedKey);
                        continue;
                    } else if ([i isKindOfClass:[NSString class]] || [i isKindOfClass:[NSNumber class]] || [i isKindOfClass:[NSDate class]]) {
                        [arr addObject:[self coerceToString:i withName:@"groupType"]];
                    } else {
//                        WALINNS_LOG(@"WARNING: Invalid groupName value in array for groupType %@ (received class %@). Please use NSStrings", coercedKey, [i class]);
                    }
                }
                dict[coercedKey] = [NSArray arrayWithArray:arr];
            } else if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSDate class]]){
                dict[coercedKey] = [self coerceToString:value withName:@"groupName"];
            } else {
//                WALINNS_LOG(@"WARNING: Invalid groupName value for groupType %@ (received class %@). Please use NSString or NSArray of NSStrings", coercedKey, [value class]);
            }
        }
        SAFE_ARC_RELEASE(objCopy);
        return [NSDictionary dictionaryWithDictionary:dict];
    }
    
+ (NSString*) platformDataDirectory
    {
#if TARGET_OS_TV
        return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
#else
        return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
#endif
    }
    
+(NSString *)getUTCFormateDate:(NSDate *)localDate
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:localDate];
        NSLog(@"converted date =%@", dateString);
        return dateString;
    }
+(NSString *) sessionDuration:(NSDate *)startDate{
    NSLog(@"Session func called");
    NSDate * sessionEnd = [NSDate date];
    NSLog(@"Session func called =%@" , startDate);
    
    NSTimeInterval secondsBetween = [sessionEnd timeIntervalSinceDate:startDate];
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.allowedUnits = NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
    NSString *string = [formatter stringFromTimeInterval:secondsBetween];
    NSLog(@"Start date :" , [WAUtils getUTCFormateDate:startDate]);
    NSLog(@"End date :", [WAUtils
                          getUTCFormateDate:sessionEnd]);
    NSLog(@"%@", [@"0" stringByAppendingString:string]);
    return [@"0" stringByAppendingString:string];
    
}
    @end
