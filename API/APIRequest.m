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
            NSString* strOTP = [otpDict objectForKey:@"otp"];
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
    
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:phoneNum, @"phone", type, @"type", nil];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_GETOTP] withParam:paramDict];
    
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
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_REGISTER] withParam:nil];
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
    
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:phoneNum, @"username", password, @"password", nil];
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
                NSDictionary* headerDict = [httpResponse allHeaderFields];
                NSString* strToken = [headerDict objectForKey:@"Authorization"];
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
            NSString* strOTP = [otpDict objectForKey:@"otp"];
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
    
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:phoneNum, @"phone", password, @"password", token, @"token", nil];
    NSData* bodyData = [self createBodyRequest:paramDict];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_UPDATE_PASS] withParam:nil];
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
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_REQUEST] withParam:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:strToken forHTTPHeaderField:@"Authorization"];
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

- (void)requestAPIGetConfiguration:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_GET_CONFIGURATION] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get configuration:%@", resultDict);
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"get configuration fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIUpdateAccountInfo:(NSString *)phoneNum token:(NSString *)token accountInfo:(NSDictionary *)accountInfo completionHandler:(void (^)(User * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSData* bodyData = [self createBodyRequest:accountInfo];
    NSString* apiCommandStr = [API_ACCOUNT stringByAppendingPathComponent:phoneNum];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"update account info: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                User* newUser = [[User alloc]initUserWithInfoData:resultDict];
                completionHandler(newUser, error);
            }
            else
            {
                NSLog(@"update account info fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIGetAccountInfo:(NSString *)phoneNum token:(NSString *)token completionHandler:(void (^)(User * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* apiCommandStr = [API_ACCOUNT stringByAppendingPathComponent:phoneNum];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get account info: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                User* newUser = [[User alloc]initUserWithInfoData:resultDict];
                completionHandler(newUser, error);
            }
            else
            {
                NSLog(@"get account info fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIRateService:(NSString *)token idService:(NSString *)idService rateServiceInfo:(nonnull NSDictionary *)rateInfo completionHandler:(nonnull void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* apiCommandStr = [[API_REQUEST stringByAppendingPathComponent:API_RATE]stringByAppendingPathComponent:idService];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    NSData* bodyData = [self createBodyRequest:rateInfo];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:bodyData];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"rate service: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"rate service fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIGetAvailableNoti:(NSString *)phoneNum token:(NSString *)token completionHandler:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* apiCommandStr = [API_GET_AVAILABLE_NOTI stringByAppendingPathComponent:phoneNum];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get available noti: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"get available noti fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIGetNotiForID:(NSString *)idService token:(NSString *)token completionHandler:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* apiCommandStr = [API_NOTIFY stringByAppendingPathComponent:idService];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get noti for id: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"get noti for id fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIGetAllRequests:(NSString *)token completionHandler:(void (^)(NSArray * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:API_GET_ALL_REQUESTS] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSArray* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get all requests: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"get all requests fail with");
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"error message"}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}

- (void)requestAPIGetDetailRequest:(NSString *)token idService:(NSString *)idService completionHandler:(void (^)(NSDictionary * _Nullable, NSError * _Nonnull))completionHandler
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* apiCommandStr = [API_REQUEST stringByAppendingPathComponent:idService];
    NSMutableURLRequest* request = [self createURLRequest:[API_V1 stringByAppendingPathComponent:apiCommandStr] withParam:nil];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //handle response
        if (response)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"get request with id: %@", resultDict);
            
            if ([httpResponse statusCode] == 200)
            {
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];
                completionHandler(resultDict, error);
            }
            else
            {
                NSLog(@"get request with id fail with: %@", [resultDict objectForKey:@"messages"]);
                error = [NSError errorWithDomain:@"test_domain" code:[httpResponse statusCode] userInfo:@{NSLocalizedDescriptionKey:[resultDict objectForKey:@"messages"]}];
                completionHandler(nil, error);
            }
        }
    }]resume];
}
@end
