//
//  AppDelegate.m
//  FirstWatchApp
//
//  Created by Sven Anders Robbestad on 12.04.15.
//  Copyright (c) 2015 Sven Anders Robbestad. All rights reserved.
//


#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSDictionary *dict;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSUserDefaults *sharedDefaults;

@end

@implementation AppDelegate
@synthesize dict=_dict;

double timerInterval = 1.0f;

- (NSTimer *) timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)onTick:(NSTimer*)timer
{
  /*  NSLog(@"Tick...");
    NSLog(@"counter");
    NSDictionary *dict = @{@"key" : @"5 secs"};
    _dict=dict;
    NSLog(@"dict %@",_dict);
    [self.sharedDefaults setValue:@"test" forKey:@"message"];
    [self.sharedDefaults synchronize];
*/
    NSDictionary *dict = @{@"key" : @"hei"};
    _dict=dict;

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharedAppData"];
    NSString *msg = [self.sharedDefaults valueForKey:@"message"];
    NSDictionary *dict = @{@"key" : msg};
    _dict=dict;

    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *replyInfo))reply
{
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharedAppData"];
    NSString *msg = [self.sharedDefaults valueForKey:@"message"];

    /*    NSDictionary *di = @{@"key" : @"More PhoneData"};
     _dict=di;
     [self.sharedDefaults setValue:@"test" forKey:@"message"];
     [self.sharedDefaults synchronize];

     */
//    NSLog(@"%@",msg);
    
//    [self.sharedDefaults setObject:_dict forKey:@"message"];
   reply(_dict);
}

@end

