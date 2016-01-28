//
//  SpeechAuthController.h
//  LOTTE_AuthModule
//
//  Created by Kaeul Han on 2016. 1. 22..
//  Copyright © 2016년 Jay. All rights reserved.
//

#ifndef SpeechAuthController_h
#define SpeechAuthController_h


#import <Foundation/Foundation.h>
#import <DaumSpeech/DaumSpeechRecognizer.h>
#import <UIKit/UIKit.h>


@interface SpeechAuthController : UIViewController <MTSpeechRecognizerDelegate,MTSpeechRecognizerViewDelegate>


- (IBAction)btnclick_back:(id)sender;

- (IBAction)btnclick_authorizing:(id)sender;

- (void)speechAuthorzing_process;

@end



#endif /* SpeechAuthController_h */
