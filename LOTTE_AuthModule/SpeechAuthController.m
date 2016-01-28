
//
//  SpeechAuthController.m
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

#import "SpeechAuthController.h"
#import "LOTTE_AuthModule-Swift.h"


@interface SpeechAuthController()

@property (weak, nonatomic) IBOutlet UIButton *btn_back;

@property (weak, nonatomic) IBOutlet UIButton *btn_authorzing;

@property (weak, nonatomic) IBOutlet UIButton *btn_reset;

@property (nonatomic, strong) NSString *selectedServiceType;

@property (nonatomic, strong) NSString *service_passwd;

@property (nonatomic, strong) NSString *service_status;

@end


@implementation SpeechAuthController

-(void)viewDidAppear:(BOOL)animated
{
    self.service_passwd = [GlobalManager get_dict];
    
    self.service_status = @"";
    
    if([self.service_passwd isEqualToString:@""])
    {
        UIAlertView *init_alertView = [[UIAlertView alloc] initWithTitle:@"암호 초기화"
                                                        message:@"세팅작업이 필요합니다."
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"등록",nil];
        
        init_alertView.tag = 1;
        
        [init_alertView show];
    }
}

- (IBAction)btnclick_back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btnclick_authorizing:(id)sender {
    
    self.selectedServiceType = SpeechRecognizerServiceTypeWeb;
    
    [self speechAuthorzing_process];
}


- (IBAction)btnclick_reset:(id)sender {

    
    UIAlertView *reset_alertView = [[UIAlertView alloc] initWithTitle:@"암호 재설정"
                                                             message:@"기존 암호를 확인 후 재설정합니다."
                                                            delegate:self
                                                   cancelButtonTitle:@"취소"
                                                   otherButtonTitles:@"확인",nil];
    
    
    reset_alertView.tag = 3;
    
    [reset_alertView show];
    
}


- (void)speechAuthorzing_process
{
    
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
    
    
    if ([self.service_passwd isEqualToString:@""] && [self.service_status isEqualToString:@"reset_success"])
    {
        self.service_passwd = target_string;
        [GlobalManager set_dict: target_string];
        [self success_reset];
        
    }
    
    else if ([self.service_passwd isEqualToString:@""])
    {
        self.service_passwd = target_string;
        [GlobalManager set_dict: target_string];
    }
    
    else if([self.service_passwd isEqualToString:target_string] && [self.service_status isEqualToString:@"reset"])
    {
        self.service_status = @"reset_success";
        self.service_passwd =@"";
        [GlobalManager set_dict:@""];
        
        [self speechAuthorzing_process];
    }
    
    else if([self.service_passwd isEqualToString:target_string])
    {
        NSLog(@" LoginSuccess");
        [self moveToWebView];
    }
    
    else
    {
        
        UIAlertView *fail_alertView = [[UIAlertView alloc] initWithTitle:@"로그인 실패"
                                                                 message:@"암호가 틀렸습니다."
                                                                delegate:self
                                                       cancelButtonTitle:@"취소"
                                                       otherButtonTitles:@"재시도",@"Id/Pwd 로그인",nil];
        
        fail_alertView.tag = 2;
        
        [fail_alertView show];

    }
}


- (void) moveToWebView
{
    UIViewController * targetController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
    [self presentViewController: targetController animated: false completion: nil];
}


- (void) moveToLoginView
{
    UIViewController * targetController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginAuth"];
    [self presentViewController: targetController animated: false completion: nil];
}

- (void) success_reset
{
    
    
    UIAlertView *success_alertView = [[UIAlertView alloc] initWithTitle:@"암호 재설정"
                                                              message:@"암호가 변경되었습니다."
                                                             delegate:self
                                                    cancelButtonTitle:@"확인"
                                                       otherButtonTitles:nil, nil];
    
    
    [success_alertView show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == 1)
    {
        if (buttonIndex == 0) {
            
        }
        else if (buttonIndex == 1) {
            
            self.selectedServiceType = SpeechRecognizerServiceTypeWeb;
            
            [self speechAuthorzing_process];
        }
    }
    
    
    else if(alertView.tag == 2)
    {
        if (buttonIndex == 0) {
            
        }
        else if (buttonIndex == 1) {
            
            self.selectedServiceType = SpeechRecognizerServiceTypeWeb;
            
            [self speechAuthorzing_process];
        }
        else if(buttonIndex ==2)
        {
            [self moveToLoginView];
        }
    }
    
    else if(alertView.tag == 3)
    {
        if(buttonIndex==0){
            
        }
        else if(buttonIndex == 1)
        {

            self.service_status =@"reset";
            
            [self speechAuthorzing_process];
        }
    }
}


@end
