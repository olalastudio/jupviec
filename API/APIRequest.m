//
//  APIRequest.m
//  JupViec
//
//  Created by Khanhlt on 11/27/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "APIRequest.h"
#import "CommonDefines.h"

@implementation APIRequest

@synthesize delegate;

-(id)init
{
    self = [super init];
    if (self) {
        delegate = self;
    }
    return self;
}

-(NSMutableURLRequest*)createURLRequest:(NSString*)commandStr withParam:(NSDictionary*)paramDict
{
    NSMutableURLRequest *urlRequest = nil;
    NSString* urlStr = [ADDRESS_SERVER stringByAppendingPathComponent:commandStr];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLComponents* urlComponents = [[NSURLComponents alloc]initWithURL:url resolvingAgainstBaseURL:YES];
    NSMutableArray* queryItems = [[NSMutableArray alloc]init];
    NSArray* keyArr = [paramDict allKeys];
    for (NSString* keyStr in keyArr)
    {
        NSURLQueryItem* queryItem = [[NSURLQueryItem alloc]initWithName:keyStr value:[paramDict objectForKey:keyStr]];
        [queryItems addObject:queryItem];
    }
    
    if ([queryItems count] > 0)
    {
        [urlComponents setQueryItems:queryItems];
        urlRequest = [NSMutableURLRequest requestWithURL:[urlComponents URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    } else
        urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    return urlRequest;
}
-(NSData*)createBodyRequest:(NSDictionary*)bodyDataDict
{
    NSData* bodyData = [NSJSONSerialization dataWithJSONObject:bodyDataDict options:NSJSONWritingPrettyPrinted error:nil];
    
    return bodyData;
}

- (void)requestAPIGetOTP:(NSString *)phoneNum completionHandler:(void (^)(NSString * _Nonnull, NSError * _Nonnull))completionHandler
{
    [self requestAPIGetOTPWith:phoneNum type:API_REGISTER completionHandler:^(NSDictionary *otpDict, NSError *error) {
        if (error)
        {
            NSString* strOTP = [[otpDict objectForKey:@"otp"]stringValue];
            completionHandler(strOTP, error);
        }
    }];
}

- (void)requestAPIGetOTPWith:(NSString *)phoneNum type:(NSString*)type completionHandler:(void (^)(NSDictionary* otpDict , NSError * error))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* realPhoneStr = [NSString stringWithFormat:@"%lld", [phoneNum longLongValue]];
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:realPhoneStr, @"phone", type, @"type", nil];
    NSMutableURLRequest* request = [self createURLRequest:API_GETOTP withParam:paramDict];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            if (resultDict)
            {
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
                completionHandler(resultDict, error);
            } else
            {
                error = [NSError errorWithDomain:@"test_domain" code:400 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
                completionHandler(nil, error);
            }
        }
        
    }]resume];
}

- (void)requestAPIRegister:(NSString*)phoneNum password:(NSString*)password completionHandler:(void (^)(User * user, NSError * error))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:phoneNum, @"phone", password, @"password", nil];
    NSData* bodyData = [self createBodyRequest:paramDict];
    NSMutableURLRequest* request = [self createURLRequest:API_REGISTER withParam:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            User* newUser = [[User alloc]initUserWithInfoData:resultDict];
            error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
            completionHandler(newUser, error);
        }
    }]resume];
}

- (void)requestAPILogin:(NSString *)phoneNum password:(NSString *)password completionHandler:(void (^)(NSString * _Nonnull, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* realPhoneStr = [NSString stringWithFormat:@"%lld", [phoneNum longLongValue]];
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:realPhoneStr, @"phone", password, @"password", nil];
    NSData* bodyData = [self createBodyRequest:paramDict];
    NSMutableURLRequest* request = [self createURLRequest:API_LOGIN withParam:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString* strToken = [resultDict objectForKey:@"token"];
            if (strToken)
            {
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
                completionHandler(strToken, error);
                NSLog(@"GET_OTP success");
            } else
                NSLog(@"GET_OTP fail");
        }
        
    }]resume];
}

- (void)requestAPIForgotPassword:(NSString *)phoneNum completionHandler:(void (^)(NSDictionary * _Nonnull, NSError * _Nonnull))completionHandler
{
    [self requestAPIGetOTPWith:phoneNum type:API_FORGOT_PASS completionHandler:^(NSDictionary *otpDict, NSError *error) {
        if (error)
        {
            NSLog(@"%@", otpDict);
            NSString* strOTP = [[otpDict objectForKey:@"otp"]stringValue];
            NSMutableDictionary* dict = [otpDict mutableCopy];
            [dict setObject:strOTP forKey:@"otp"];
            completionHandler(dict, error);
        }
    }];
}

- (void)requestAPIUpdatePassword:(NSString *)phoneNum password:(NSString *)password token:(NSString *)token completionHandler:(void (^)(User * _Nonnull, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* realPhoneStr = [NSString stringWithFormat:@"%lld", [phoneNum longLongValue]];
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:realPhoneStr, @"phone", password, @"password", token, @"token", nil];
    NSData* bodyData = [self createBodyRequest:paramDict];
    NSMutableURLRequest* request = [self createURLRequest:API_UPDATE_PASS withParam:nil];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"update pass:%@", resultDict);
            User* newUser = [[User alloc]initUserWithInfoData:resultDict];
            error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
            completionHandler(newUser, error);
        }
    }]resume];
}
@end
