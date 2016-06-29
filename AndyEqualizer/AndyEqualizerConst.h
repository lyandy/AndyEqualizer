//
//  AndyEqualizerConst.h
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AndyEqualizerNoteCenter [NSNotificationCenter defaultCenter]

typedef enum : NSInteger
{
    //自定义
    EqualizerEffectPersonal,
    //默认
    EqualizerEffectDefault,
    //超重低音
    EqualizerEffectFullBass,
    //完美人声
    EqualizerEffectPerfectVoice,
    //现场还原
    EqualizerEffectLive,
    //流行
    EqualizerEffectPopular,
    //摇滚
    EqualizerEffectRock,
    //民谣
    EqualizerEffectFolk,
    //电子/舞曲
    EqualizerEffectDance,
    //蓝调/爵士
    EqualizerEffectJazz,
    //古典
    EqualizerEffectClassic,
    //重金属
    EqualizerEffectMetal
} EqualizerEffect;

UIKIT_EXTERN NSString * const ANDY_EQUALIZER_CHANGED_NOTIFICATION;



