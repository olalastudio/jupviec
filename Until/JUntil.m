//
//  JUntil.m
//  JupViec
//
//  Created by KienVu on 12/18/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "JUntil.h"

@implementation JUntil

+(double)timeNumberFromString:(NSString*)string
{
    if ([string isEqualToString:@"00:00"]){return 0;}
    else if ([string isEqualToString:@"00:30"]){return 0.5;}
    else if ([string isEqualToString:@"01:00"]){return 1.0;}
    else if ([string isEqualToString:@"01:30"]){return 1.5;}
    else if ([string isEqualToString:@"02:00"]){return 2.0;}
    else if ([string isEqualToString:@"02:30"]){return 2.5;}
    else if ([string isEqualToString:@"03:00"]){ return 3.0;}
    else if ([string isEqualToString:@"03:30"]){ return 3.5;}
    else if ([string isEqualToString:@"04:00"]){ return 4.0;}
    else if ([string isEqualToString:@"04:30"]){ return 4.5;}
    else if ([string isEqualToString:@"05:00"]){ return 5.0;}
    else if ([string isEqualToString:@"05:30"]){ return 5.5;}
    else if ([string isEqualToString:@"06:00"]){ return 6.0;}
    else if ([string isEqualToString:@"06:30"]){ return 6.0;}
    else if ([string isEqualToString:@"07:00"]){ return 7.0;}
    else if ([string isEqualToString:@"07:30"]){ return 7.5;}
    else if ([string isEqualToString:@"08:00"]){ return 8.0;}
    else if ([string isEqualToString:@"08:30"]){ return 8.5;}
    else if ([string isEqualToString:@"09:00"]){ return 9.0;}
    else if ([string isEqualToString:@"09:30"]){ return 9.5;}
    else if ([string isEqualToString:@"10:00"]){ return 10.0;}
    else if ([string isEqualToString:@"10:30"]){ return 10.5;}
    else if ([string isEqualToString:@"11:00"]){ return 11.0;}
    else if ([string isEqualToString:@"11:30"]){ return 11.5;}
    else if ([string isEqualToString:@"12:00"]){ return 12.0;}
    else if ([string isEqualToString:@"12:30"]){ return 12.5;}
    else if ([string isEqualToString:@"13:00"]){ return 13.0;}
    else if ([string isEqualToString:@"13:30"]){ return 13.5;}
    else if ([string isEqualToString:@"14:00"]){ return 14.0;}
    else if ([string isEqualToString:@"14:30"]){ return 14.5;}
    else if ([string isEqualToString:@"15:00"]){ return 15.0;}
    else if ([string isEqualToString:@"15:30"]){ return 15.5;}
    else if ([string isEqualToString:@"16:00"]){ return 16.0;}
    else if ([string isEqualToString:@"16:30"]){ return 16.5;}
    else if ([string isEqualToString:@"17:00"]){ return 17.0;}
    else if ([string isEqualToString:@"17:30"]){ return 17.5;}
    else if ([string isEqualToString:@"18:00"]){ return 18.0;}
    else if ([string isEqualToString:@"18:30"]){ return 18.5;}
    else if ([string isEqualToString:@"19:00"]){ return 19.0;}
    else if ([string isEqualToString:@"19:30"]){ return 19.5;}
    else if ([string isEqualToString:@"20:00"]){ return 20.0;}
    else if ([string isEqualToString:@"20:30"]){ return 20.5;}
    else if ([string isEqualToString:@"21:00"]){ return 21.0;}
    else if ([string isEqualToString:@"21:30"]){ return 21.5;}
    else if ([string isEqualToString:@"22:00"]){ return 22.0;}
    else if ([string isEqualToString:@"22:30"]){ return 22.5;}
    else if ([string isEqualToString:@"23:00"]){ return 23.0;}
    else if ([string isEqualToString:@"23:30"]){ return 23.5;}
    
    return 0;
}

@end
