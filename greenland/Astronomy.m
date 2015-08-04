//
//  Astronomy.m
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import "Astronomy.h"

@interface Astronomy ()

@property (copy, readwrite, nonatomic) NSString *sunrise;
@property (copy, readwrite, nonatomic) NSString *sunset;

@end

@implementation Astronomy

- (instancetype)initWithForecastDictinary:(NSDictionary *)forecastDictionary
{
    self = [super init];
    
    if (self) {
        NSDictionary *astronomy = [[[[forecastDictionary objectForKey:kJSONQuery] objectForKey:kJSONResults] objectForKey:kJSONChannel] objectForKey:kJSONAstronomy];
        _sunrise = [astronomy objectForKey:kJSONSunrise];
        _sunset = [astronomy objectForKey:kJSONSunset];
    }
    return self;
}

@end
