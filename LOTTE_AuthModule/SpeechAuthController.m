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


@end


@implementation SpeechAuthController


-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear loaded successfully");
    
}

- (IBAction)clickbtn_back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
