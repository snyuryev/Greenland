//
//  Forecast.h
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject

/// Description string value
@property (copy, readonly, nonatomic) NSString *forecastDescription;

- (instancetype)initWithForecastDictinary:(NSDictionary *)forecastDictionary;

@end
