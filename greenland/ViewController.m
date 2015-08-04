//
//  ViewController.m
//  greenland
//
//  Created by Sergey Yuryev on 04/08/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

#import "ViewController.h"
#import "Astronomy.h"
#import "Forecast.h"
#import "ApiManager.h"

/// Parallax value for background view
const static CGFloat kLoginParallaxValue = 50.0;

@interface ViewController () <UIWebViewDelegate>

/// Background view
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

/// Label for sunrise value
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;

/// Label for sunset value
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;

/// Web view for description text
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
 *  Makes initial setup for view controller
 */
- (void)initialSetup;

/**
 *  Adds parallax for background view
 */
- (void)addParallax;

/**
 *  Loads data
 */
- (void)loadData;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    [self loadData];
}

#pragma mark - View controller setup

- (void)initialSetup
{
    [self setupWebView];
    [self addParallax];
}

- (void)setupWebView
{
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    
    self.webView.delegate = self;
}

- (void)addParallax
{
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(kLoginParallaxValue);
    verticalMotionEffect.maximumRelativeValue = @(-kLoginParallaxValue);
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(kLoginParallaxValue);
    horizontalMotionEffect.maximumRelativeValue = @(-kLoginParallaxValue);
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    [self.backgroundView addMotionEffect:group];
}

#pragma mark - Data loading

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[ApiManager sharedInstance] getForecastWithCompletion:^(NSDictionary *forecastDictionary, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (!error)
        {
            NSLog(@"forecastDictionary: %@", forecastDictionary);
            Astronomy *astronomy = [[Astronomy alloc] initWithForecastDictinary:forecastDictionary];
            Forecast *forecast = [[Forecast alloc] initWithForecastDictinary:forecastDictionary];
            __strong typeof(weakSelf) blockSelf = weakSelf;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                blockSelf.sunriseLabel.text = astronomy.sunrise;
                blockSelf.sunsetLabel.text = astronomy.sunset;
                
                [self.webView loadHTMLString:[NSString stringWithFormat:@"<html><head> <style type=\"text/css\"> body { font-family: Helvetica; font-size: 15px; color: #FFFFFF;} a {color: #FFFFFF;} },</style> </head><body>%@</body></html>", forecast.forecastDescription] baseURL: nil];
            });
        }
        else
        {
            NSLog(@"Api manager error: %@", [error localizedDescription]);
        }
    }];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    return YES;
}

@end
