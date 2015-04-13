//
//  InterfaceController.m
//  FirstWatchApp WatchKit Extension
//
//  Created by Sven Anders Robbestad on 12.04.15.
//  Copyright (c) 2015 Sven Anders Robbestad. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (strong, nonatomic) NSUserDefaults *sharedDefaults;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *mainLbl;

- (IBAction)btnDataRequested;
@end


@implementation InterfaceController
@synthesize mainLbl=_mainLbl;
double timerInterval = 1.0f;

- (NSTimer *) timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharedAppData"];

    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // Configure interface objects here.
    [_mainLbl setHidden:NO];
}

- (NSString *)sharedMessage {
    NSString *message = [self.sharedDefaults objectForKey:@"message"];
    NSLog(@"message: %@",message);
    return message;
}

-(void)onTick:(NSTimer*)timer
{
    /* NSString* message=[self sharedMessage];
    NSLog(@"%@",message);
    
    
   
    NSLog(@"Tick...");
    [WKInterfaceController openParentApplication:[NSDictionary dictionary] reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@",replyInfo);
        NSLog(@"error: %@",error);
        NSString *strData = replyInfo[@"key"];
        if(![@"" isEqualToString:strData]){
                [_mainLbl setText:strData];
        }
       
        [_mainLbl setHidden:NO];
    }];
    */
}

- (void)application:(UIApplication *)application
handleWatchKitExtensionRequest:(NSDictionary *)userInfo
              reply:(void (^)(NSDictionary *replyInfo))reply{
    NSLog(@"reply %@",reply);
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSLog(@"%@ will activate", self);
    
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharedAppData"];
    NSString* message=[self sharedMessage];
    NSLog(@"%@",message);

    [WKInterfaceController openParentApplication:[NSDictionary dictionary] reply:^(NSDictionary *replyInfo, NSError *error) {
        
        NSString *strData = replyInfo[@"key"];
        [_mainLbl setText:strData];
        [_mainLbl setHidden:NO];
    }];
    
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

/* Request the data from the parent application. */
- (IBAction)btnDataRequested
{
    [WKInterfaceController openParentApplication:[NSDictionary dictionary] reply:^(NSDictionary *replyInfo, NSError *error) {
        
        NSString *strData = replyInfo[@"key"];
        [_mainLbl setText:strData];
        [_mainLbl setHidden:NO];
    }];
}


@end