//
//  NetworkReachability.h
//  JupViec
//
//  Created by Khanhlt on 12/17/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefines.h"
#include <netinet/in.h>
NS_ASSUME_NONNULL_BEGIN

@interface NetworkReachability : NSObject
+ (INTERNET_STATUS)internetConnectionStatus;
@end

NS_ASSUME_NONNULL_END
