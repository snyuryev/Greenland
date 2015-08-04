//
//  ApiManager.h
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

/**
 *  Returns api manager singleton
 *
 *  @return Shared instance for api maneger
 */
+ (instancetype)sharedInstance;


- (void)getForecastWithCompletion:(void (^)(NSDictionary *forecastDictionary, NSError *error))completion;

@end
