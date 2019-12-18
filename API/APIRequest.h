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

- (void)requestAPIGetOTP:(NSString*)phoneNum completionHandler:(void(^)(NSString* _Nullable otpStr, NSError* err))completionHandler;
- (void)requestAPIRegister:(NSString*)phoneNum password:(NSString*)password completionHandler:(void (^)(User * _Nullable user, NSError * error))completionHandler;
- (void)requestAPILogin:(NSString*)phoneNum password:(NSString*)password completionHandler:(void (^)(NSString * _Nullable token, NSError * error))completionHandler;
- (void)requestAPIForgotPassword:(NSString*)phoneNum completionHandler:(void(^)(NSDictionary* _Nullable data, NSError* err))completionHandler;
- (void)requestAPIUpdatePassword:(NSString*)phoneNum password:(NSString*)password token:(NSString*)token completionHandler:(void(^)(User* _Nullable user, NSError* error))completionHandler;
- (void)requestAPIBookService:(NSString*)strToken detailService:(NSDictionary*)detailService completionhandler:(void(^)(NSDictionary* _Nullable serviceInfo, NSError* error))completionHandler;
- (void)requestAPIGetConfiguration:(void(^)(NSDictionary* _Nullable configurationInfo, NSError* error))completionHandler;
- (void)requestAPIUpdateAccountInfo:(NSString*)phoneNum token:(NSString*)token accountInfo:(NSDictionary*)accountInfo completionHandler:(void (^)(User * _Nullable user, NSError * error))completionHandler;
- (void)requestAPIGetAccountInfo:(NSString*)phoneNum token:(NSString*)token completionHandler:(void (^)(User * _Nullable user, NSError * error))completionHandler;
- (void)requestAPIRateService:(NSString*)token idService:(NSString*)idService rateServiceInfo:(NSDictionary*)rateInfo completionHandler:(void (^)(NSDictionary * _Nullable resultDict, NSError * error))completionHandler;
- (void)requestAPIGetAvailableNoti:(NSString*)phoneNum token:(NSString*)token completionHandler:(void (^)(NSArray * _Nullable resultDict, NSError * error))completionHandler;
- (void)requestAPIGetNotiForID:(NSString*)idService token:(NSString*)token completionHandler:(void (^)(NSDictionary * _Nullable resultDict, NSError * error))completionHandler;
- (void)requestAPIGetAllRequests:(NSString*)token completionHandler:(void (^)(NSDictionary * _Nullable resultDict, NSError * error))completionHandler;
- (void)requestAPIGetDetailRequest:(NSString*)token idService:(NSString*)idService completionHandler:(void (^)(NSDictionary * _Nullable resultDict, NSError * error))completionHandler;
@end

NS_ASSUME_NONNULL_END
