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
- (void)requestAPIRegister:(NSString*)phoneNum password:(NSString*)password completionHandler:(void (^)(User * user, NSError * error))completionHandler;
- (void)requestAPILogin:(NSString*)phoneNum password:(NSString*)password completionHandler:(void (^)(NSString * token, NSError * error))completionHandler;
- (void)requestAPIForgotPassword:(NSString*)phoneNum completionHandler:(void(^)(NSDictionary* data, NSError* err))completionHandler;
- (void)requestAPIUpdatePassword:(NSString*)phoneNum password:(NSString*)password token:(NSString*)token completionHandler:(void(^)(User* user, NSError* error))completionHandler;
@end

NS_ASSUME_NONNULL_END
