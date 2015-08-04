//
//  ApiManager.m
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager


#pragma mark - Lifecycle

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Api methods

- (void)getForecastWithCompletion:(void (^)(NSDictionary *forecastDictionary, NSError *error))completion
{
    NSString *urlString = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22greenland%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            NSLog(@"session error is %@", [error localizedDescription]);
            completion(nil, error);
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError)
        {
            NSLog(@"json error is %@", [jsonError localizedDescription]);
            completion(nil, error);
        }
        
        if (![dictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"json is not a dictionary");
            completion(nil, error);
        }
        
        completion(dictionary, nil);
        
    }] resume];
}


@end
