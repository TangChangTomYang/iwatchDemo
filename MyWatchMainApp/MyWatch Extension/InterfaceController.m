//
//  InterfaceController.m
//  MyWatch Extension
//
//  Created by yangrui on 2018/7/6.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController ()

@end


@implementation InterfaceController

- (IBAction)recordBtnClick {
    [self startRecord];
}





/**
 需要注意的是想要在Watch上录制音频，必须打开App Groups这个功能，然后提供Groups路径给系统来存储文件。
 系统提供的录音的方法支持wav/mp4/m4a三种录音格式，只需要在保存时提供相应的后缀名就可以了，
 */
-(void)startRecord{
    
    NSURL *containerUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.forLettincn"];
   
    NSURL *fileUrl = [containerUrl URLByAppendingPathComponent:@"record.wav" ];
    
    NSLog(@"fileUrl: %@", fileUrl);
    NSLog(@"fileUrlPath: %@", fileUrl.absoluteString);
    
    NSDictionary *optionDic = @{WKAudioRecorderControllerOptionsActionTitleKey :@"发送",
                                WKAudioRecorderControllerOptionsMaximumDurationKey:@(30)
                                };
    
    
    
    [self presentAudioRecorderControllerWithOutputURL:fileUrl
                                               preset:WKAudioRecorderPresetHighQualityAudio
                                              options:optionDic
                                           completion:^(BOOL didSave, NSError * _Nullable error) {
                                               
                                               NSLog(@"didSave : %d,error: %@",didSave, error);
                                               
                                
        
    }];
}


//+ (BOOL)convertFromWavToMp3WithData:(NSData *)data
//{
//    NSString *cachePath = [NSFileManager cacheDiretory];
//    NSString *wavPath = [NSString stringWithFormat:@"%@/watchRecorder.wav",cachePath];
//    NSString *mp3Path = [NSString stringWithFormat:@"%@/watchRecorder.mp3",cachePath];
//
//    if (![data writeToURL:[NSURL fileURLWithPath:wavPath] atomically:YES]) {
//        return NO;
//    }
//
//    int read, write;
//
//    FILE *pcm = fopen([wavPath cStringUsingEncoding:NSUTF8StringEncoding], "rb");  //source
//    //skip file header
//    FILE *mp3 = fopen([mp3Path cStringUsingEncoding:NSUTF8StringEncoding], "wb");  //output
//
//    if (!pcm || !mp3)
//    {
//        fclose(mp3);
//        fclose(pcm);
//        return NO;
//    }
//
//    const int PCM_SIZE = 8192;
//    const int MP3_SIZE = 8192;
//    short int pcm_buffer[PCM_SIZE*2];
//    unsigned char mp3_buffer[MP3_SIZE];
//
//    lame_t lame = lame_init();
//    lame_set_in_samplerate(lame, 22050);
//    lame_set_VBR(lame, vbr_default);
//    lame_init_params(lame);
//
//    do {
//        read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
//        if (read == 0)
//            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
//        else
//            write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//
//        fwrite(mp3_buffer, write, 1, mp3);
//
//    } while (read != 0);
//
//    lame_close(lame);
//    fclose(mp3);
//    fclose(pcm);
//
//    return YES;
//}

//在调试上面的方法过程中，出现过音频被压缩的情况，后来发现是录制音频时的WKAudioRecorderPresetHighQualityAudio 参数与转换方法中的lame_set_in_samplerate(lame, 22050)参数造成的，这两个相对应的参数是我一次次试出来的，具体的原理还是不懂，只大概知道是音频赫兹之类的问题。所以如果恰好你了解这块，请给我解答一下，万分感谢。



//-(float)duration{
//    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:mp3Path] options:nil];
//    
//    CMTime audioDuration = audioAsset.duration;
//    
//    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
//}




- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
 
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



