//
//  AndyEqualizerEffectModel.h
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AndyEqualizerEffectModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *gainArray;

@property (nonatomic, assign) EqualizerEffect equalizerEffect;

@end
