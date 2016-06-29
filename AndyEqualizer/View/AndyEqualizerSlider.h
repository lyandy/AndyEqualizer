//
//  AndyEqualizerSlider.h
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AndyEqualizerSlider : UIView

@property (nonatomic, weak) UISlider *slider;

- (instancetype)initWithTag:(NSInteger)tag player:(AndyPlayer *)player  andFrequency:(NSString *)frequency;

@end
