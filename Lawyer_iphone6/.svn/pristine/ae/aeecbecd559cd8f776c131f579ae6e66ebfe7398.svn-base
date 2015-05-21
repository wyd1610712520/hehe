//
//  AudioViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "AudioViewController.h"

#import <AVFoundation/AVFoundation.h>



@interface AudioViewController ()<AVAudioSessionDelegate,AVAudioRecorderDelegate>{
    NSTimer *_timer;
    AVAudioRecorder *_audioRecoder;
    
    NSString *_soundFilePath;
    NSURL *_soundFileURL;
    NSData *_data;
    
    BOOL recording;
    NSInteger _time;
}

@end

@implementation AudioViewController

@synthesize delegate = _delegate;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"录音" color:nil];
    
    NSString *name = [NSString stringWithFormat:@"%@.caf",[self.view getCurrentDate]];
    
    NSString *tempDir = NSTemporaryDirectory ();
    _soundFilePath = [tempDir stringByAppendingString:name];
    _soundFileURL = [[NSURL alloc] initFileURLWithPath: _soundFilePath];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive: YES error: nil];
    
    _data = [[NSData alloc] initWithContentsOfURL:_soundFileURL];
    
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord
     error: nil];
    NSDictionary *recordSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
     [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
     [NSNumber numberWithInt: AVAudioQualityMax],
     AVEncoderAudioQualityKey,
     nil];
    
    AVAudioRecorder *newRecorder =
    [[AVAudioRecorder alloc] initWithURL: _soundFileURL
                                settings: recordSettings
                                   error: nil];
    _audioRecoder = newRecorder;
    
    _time = 0;
    _audioRecoder.delegate = self;
}

- (void)touchResetEvent{
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setRightButton:nil title:@"重置" target:self action:@selector(touchResetEvent)];
    [self setDismissButton];
    
    
}

- (IBAction)touchRecordEvent:(UIButton*)sender{
    if (sender.selected) {
        [_audioRecoder pause];
        sender.selected = NO;
        _hintLabel.text = @"点击开始录音";
    }
    else{
    
        [_audioRecoder prepareToRecord];
        [_audioRecoder record];
        
        _hintLabel.text = @"点击暂停录音";
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calculate) userInfo:nil repeats:YES];
        
        sender.selected = YES;
    }
}

- (void)calculate{
    _time ++;
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (_time / 60), (_time % 60)];
}

- (IBAction)touchSaveEvent:(UIButton*)sender{
    _hintLabel.text = @"点击开始录音";
    [_audioRecoder stop];
    _playButton.selected = NO;
    _audioRecoder = nil;
    [[AVAudioSession sharedInstance] setActive: NO error: nil];
    [_timer invalidate];
    _timeLabel.text = @"00:00";
    _time = 0;
    
    
    if ([_delegate respondsToSelector:@selector(audioViewController:path:)]) {
        [_delegate audioViewController:self path:_soundFilePath];
        
        NSFileManager *fileManeger = [NSFileManager defaultManager];
        if ([fileManeger removeItemAtURL:_soundFileURL error:nil] == YES) {
            NSString *tempDir = NSTemporaryDirectory ();
            NSString *name = [NSString stringWithFormat:@"%@.caf",[self.view getCurrentDate]];
            _soundFilePath = [tempDir stringByAppendingString:name];
            _soundFileURL = [[NSURL alloc] initFileURLWithPath: _soundFilePath];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
}



@end
