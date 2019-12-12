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

- (void)requestAPIGetOTP:(NSString *)phoneNum completionHandler:(void (^)(NSString * _Nullable, NSError * _Nonnull))completionHandler
{
    [self requestAPIGetOTPWith:phoneNum type:API_REGISTER completionHandler:^(NSDictionary *otpDict, NSError *error) {
        if (error.code == 200)
        {
            NSString* strOTP = [[otpDict objectForKey:@"otp"]stringValue];
            completionHandler(strOTP, error);
        } else if (error.code == 400)
        {
            NSLog(@"account exist");
            completionHandler(nil, error);
        }
    }];
}

- (void)requestAPIGetOTPWith:(NSString *)phoneNum type:(NSString*)type completionHandler:(void (^)(NSDictionary* _Nullable otpDict , NSError * error))completionHandler
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
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
            completionHandler(resultDict, error);
        }
        
    }]resume];
}

- (void)requestAPIRegister:(NSString *)phoneNum password:(NSString *)password completionHandler:(void (^)(User * _Nullable, NSError * _Nonnull))completionHandler
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
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"request response: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                User* newUser = [[User alloc]initUserWithInfoData:resultDict];
                completionHandler(newUser, error);
            }
            else
            {
                NSLog(@"register fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPILogin:(NSString *)phoneNum password:(NSString *)password completionHandler:(void (^)(NSString * _Nullable, NSError * _Nonnull))completionHandler
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
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"login: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                NSLog(@"login success");
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                NSString* strToken = [resultDict objectForKey:@"token"];
                completionHandler(strToken, error);
            }
            else
            {
                NSLog(@"Login fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
            
        }
        
    }]resume];
}

- (void)requestAPIForgotPassword:(NSString *)phoneNum completionHandler:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    [self requestAPIGetOTPWith:phoneNum type:API_FORGOT_PASS completionHandler:^(NSDictionary *otpDict, NSError *error) {
        if ([error code] == 200)
        {
            NSString* strOTP = [[otpDict objectForKey:@"otp"]stringValue];
            NSMutableDictionary* dict = [otpDict mutableCopy];
            [dict setObject:strOTP forKey:@"otp"];
            completionHandler(dict, error);
        }
        else
        {
            completionHandler(otpDict, error);
        }
    }];
}

- (void)requestAPIUpdatePassword:(NSString *)phoneNum password:(NSString *)password token:(NSString *)token completionHandler:(void (^)(User * _Nullable, NSError * _Nonnull))completionHandler
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
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"update pass:%@", resultDict);
            if ([httpResponse statusCode] == 200)
            {
                User* newUser = [[User alloc]initUserWithInfoData:resultDict];
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(newUser, error);
            }
            else
            {
                NSLog(@"update password fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
            
        }
    }]resume];
}

-(void)requestAPIBookService:(NSString *)strToken detailService:(NSDictionary *)detailService completionhandler:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSData* bodyData = [self createBodyRequest:detailService];
    NSMutableURLRequest* request = [self createURLRequest:API_REQUEST withParam:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[@"Bearer "stringByAppendingString:strToken] forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"update pass:%@", resultDict);
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"book service fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
    
}
@end
