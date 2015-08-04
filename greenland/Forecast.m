//
//  Forecast.m
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import "Forecast.h"

@interface Forecast ()

@property (copy, readwrite, nonatomic) NSString *forecastDescription;

@end

@implementation Forecast

- (instancetype)initWithForecastDictinary:(NSDictionary *)forecastDictionary
{
    self = [super init];
    
    if (self) {
        NSDictionary *item = [[[[forecastDictionary objectForKey:kJSONQuery] objectForKey:kJSONResults] objectForKey:kJSONChannel] objectForKey:kJSONItem];
        _forecastDescription = [item objectForKey:kJSONDescription];
    }
    return self;
}

@end
