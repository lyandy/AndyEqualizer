//
//  AndyEqualizerEffectModel.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyEqualizerEffectModel.h"

@implementation AndyEqualizerEffectModel

- (NSArray *)gainArray
{
    if (_gainArray == nil)
    {
        _gainArray = [[NSArray alloc] init];
    }
    return _gainArray;
}

@end
