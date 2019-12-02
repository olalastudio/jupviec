//
//  APIRequest.h
//  JupViec
//
//  Created by Khanhlt on 11/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol APIRequestResponseDelegate <NSObject>
-(void) didReciveAPIResponse:(NSData*)data withResponse:(NSURLResponse*)response error:(NSError*)error;
@end

@interface APIRequest : NSObject

@property(nonatomic, weak) id delegate;

- (void)requestAPIGetOTP:(NSString*)phoneNum completionHandler:(void(^)(NSString* otpStr, NSError* err))completionHandler;
- (void)requestAPIRegister:(NSString*)phoneNum password:(NSString*)password completionHandler:(nonnull void (^)(User * user, NSError * error))completionHandler;
- (void)requestAPILogin:(NSString*)phoneNum password:(NSString*)password completionHandler:(nonnull void (^)(NSString * token, NSError * error))completionHandler;
@end

NS_ASSUME_NONNULL_END
