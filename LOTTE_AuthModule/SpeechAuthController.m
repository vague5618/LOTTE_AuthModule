//
//  SpeechAuthController.m
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

#import "SpeechAuthController.h"


@interface SpeechAuthController()

@property (weak, nonatomic) IBOutlet UIButton *btn_back;

@property (weak, nonatomic) IBOutlet UIButton *btn_authorzing;

@property (nonatomic, strong) NSString *selectedServiceType;

@end


@implementation SpeechAuthController


-(void)viewDidAppear:(BOOL)animated
{
}

- (IBAction)btnclick_back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnclick_authorizing:(id)sender {

    [self speechAuthorzing_process];
}


- (void)speechAuthorzing_process
{
    
    self.selectedServiceType = SpeechRecognizerServiceTypeWord;
    
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"a5bc9630b6c8c091405181692cbc7905", SpeechRecognizerConfigKeyApiKey,
                                   self.selectedServiceType, SpeechRecognizerConfigKeyServiceType,nil];
    
    
    if ([self.selectedServiceType isEqualToString:SpeechRecognizerServiceTypeWord]) {
        [config setValue:@"수지\n태연\n현아\n아이유\n효린" forKey:SpeechRecognizerConfigKeyUserDictionary];
    }
    
    MTSpeechRecognizerView *speechRecognizerView = [[MTSpeechRecognizerView alloc] initWithFrame:self.view.frame withConfig:config];
    
    speechRecognizerView.delegate = self;
    
    [self.view addSubview:speechRecognizerView];
    
    [speechRecognizerView show];
}

- (void) onError:(MTSpeechRecognizerError)errorCode message:(NSString *)message
{
    NSLog(message);
}

@end
