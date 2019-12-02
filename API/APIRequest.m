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
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    config.timeoutIntervalForResource = 60.0;
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSString* realPhoneStr = [NSString stringWithFormat:@"%lld", [phoneNum longLongValue]];
    NSDictionary* paramDict = [[NSDictionary alloc]initWithObjectsAndKeys:realPhoneStr, @"phone", @"register", @"type", nil];
    NSMutableURLRequest* request = [self createURLRequest:API_GETOTP withParam:paramDict];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSNumber* otpNum = [resultDict objectForKey:@"otp"];
            if (otpNum)
            {
                NSString* otpStr = [otpNum stringValue];
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
                completionHandler(otpStr, error);
                NSLog(@"GET_OTP success");
            } else
                NSLog(@"GET_OTP fail");
        }
        
    }]resume];
}

- (void)requestAPIRegister:(NSString*)phoneNum password:(NSString*)password completionHandler:(nonnull void (^)(User * user, NSError * error))completionHandler
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
    NSMutableURLRequest* request = [self createURLRequest:API_LOGIN withParam:paramDict];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (data)
        {
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSNumber* userTokenNum = [resultDict objectForKey:@"token"];
            if (userTokenNum)
            {
                NSString* strToken = [userTokenNum stringValue];
                error = [NSError errorWithDomain:@"test_domain" code:200 userInfo:@{NSLocalizedDescriptionKey:@"successful operation"}];     //test
                completionHandler(strToken, error);
                NSLog(@"GET_OTP success");
            } else
                NSLog(@"GET_OTP fail");
        }
        
    }]resume];
}
@end
