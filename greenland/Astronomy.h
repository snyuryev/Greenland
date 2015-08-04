//
//  Astronomy.h
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Astronomy : NSObject

/// Sunrise string value
@property (copy, readonly, nonatomic) NSString *sunrise;

/// Sunset string value
@property (copy, readonly, nonatomic) NSString *sunset;

/**
 *  Returns astronomy object
 *
 *  @param forecastDictionary Forecast dictionary with data
 *
 *  @return Astronomy object
 */
- (instancetype)initWithForecastDictinary:(NSDictionary *)forecastDictionary;

@end
