//
//  ViewController.m
//  FirstWatchApp
//
//  Created by Sven Anders Robbestad on 12.04.15.
//  Copyright (c) 2015 Sven Anders Robbestad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) NSUserDefaults *sharedDefaults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushButton:(id)sender {
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharedAppData"];
    [self.sharedDefaults setValue:@"test" forKey:@"message"];
    [self.sharedDefaults synchronize];
    
    NSLog(@"%@",[self.sharedDefaults valueForKey:@"message"]);
}


- (IBAction)updateMessage:(id)sender {
   // NSLog(@"%@",_inputField.text);
}


@end
