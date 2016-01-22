//
//  SpeechAuthController.m
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

#import "SpeechAuthController.h"


@interface SpeechAuthController()

@property (nonatomic, strong) MTSpeechRecognizerClient *speechRecognizer;
@property (nonatomic, strong) NSString *selectedServiceType;


@end


@implementation SpeechAuthController


-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear loaded successfully");
    
}

@end
