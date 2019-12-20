//
//  JUntil.h
//  JupViec
//
//  Created by KienVu on 12/18/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JUntil : NSObject

+(double)timeNumberFromString:(NSString*)string;
+(NSString*)timeStringFromNumber:(double)number;

+(NSString*)stringFromDate:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END
