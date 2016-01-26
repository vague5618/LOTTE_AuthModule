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

@property (nonatomic, strong) NSString *service_passwd;


@end


@implementation SpeechAuthController


-(void)viewDidAppear:(BOOL)animated
{
    
    self.selectedServiceType = SpeechRecognizerServiceTypeWeb;
    
    [self speechAuthorzing_process];
}

- (IBAction)btnclick_back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnclick_authorizing:(id)sender {

    self.selectedServiceType = SpeechRecognizerServiceTypeWeb;
    
    [self speechAuthorzing_process];
}


- (void)speechAuthorzing_process
{
//    
//    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"a22f144ea8d58babab054d6d5b18caec", SpeechRecognizerConfigKeyApiKey,
//                                   self.selectedServiceType, SpeechRecognizerConfigKeyServiceType,nil
//                                   ,SpeechRecognizerConfigKeyShowSuggestView, @(NO)];
//    
    NSDictionary * config = @{SpeechRecognizerConfigKeyApiKey : @"a22f144ea8d58babab054d6d5b18caec",
                              SpeechRecognizerConfigKeyCustomStrings : @"SpeechRecognizerDefault",
                              SpeechRecognizerConfigKeyServiceType : self.selectedServiceType,
                              SpeechRecognizerConfigKeyShowSuggestView : @(NO)};
    
    
    if ([self.selectedServiceType isEqualToString:SpeechRecognizerServiceTypeWord]) {
        [config setValue:self.service_passwd forKey:SpeechRecognizerConfigKeyUserDictionary];
    }
    
    MTSpeechRecognizerView *speechRecognizerView = [[MTSpeechRecognizerView alloc] initWithFrame:self.view.frame withConfig:config];
    
    speechRecognizerView.delegate = self;
    
    [self.view addSubview:speechRecognizerView];
    
    [speechRecognizerView show];
}

- (void) onError:(MTSpeechRecognizerError)errorCode message:(NSString *)message
{
    NSLog(@"error : %@",message);
}


- (void) onResults:(NSArray *)results confidences:(NSArray *)confidences marked:(BOOL)marked
{
    
    
    NSString * target_string = [[NSString alloc] init];
    
    target_string = [results objectAtIndex:0];
    
    if (self.service_passwd==nil)
    {
        self.service_passwd = target_string;
        NSLog(@"\n password setting %@",self.service_passwd);
    }
    
    else if([self.service_passwd isEqualToString:target_string])
    {
        NSLog(@"\n LoginSuccess");
    }
}






@end
