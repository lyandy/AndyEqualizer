//
//  AndyEqualizerView.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyEqualizerView.h"
#import "AndyEqualizerSlider.h"
#import "AndyPlayer.h"

@interface AndyEqualizerView ()

@property (nonatomic, strong) NSMutableArray<AndyEqualizerSlider *> *sliderArrayM;

@end

@implementation AndyEqualizerView

- (NSMutableArray *)sliderArrayM
{
    if (_sliderArrayM == nil)
    {
        _sliderArrayM = [NSMutableArray array];
    }
    return _sliderArrayM;
}

+ (instancetype)equalizerViewWithPlayer:(AndyPlayer *)player
{
    return [[self alloc] initWithPlayer:player];
}

- (instancetype)initWithPlayer:(AndyPlayer *)player
{
    self = [super init];
    if (self)
    {
        self.autoresizingMask = NO;
        
        NSArray *frequencyArray = [player getFrequencyBand];
        for (int i = 0; i < frequencyArray.count; i++)
        {
            NSString *frequencyStr = nil;
            NSInteger frequency = [[frequencyArray objectAtIndex:i] integerValue];
            if (frequency >= 1000)
            {
                frequencyStr = [NSString stringWithFormat:@"%zdk", frequency / 1000];
            }
            else
            {
                frequencyStr = [NSString stringWithFormat:@"%zd", frequency];
            }

            AndyEqualizerSlider *equalizerSlider = [[AndyEqualizerSlider alloc] initWithTag:i player:player andFrequency:frequencyStr];
            
            [self addSubview:equalizerSlider];
            
            [self.sliderArrayM addObject:equalizerSlider];
        }
        
        self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        [AndyEqualizerNoteCenter addObserver:self selector:@selector(equalizerDidChanged:) name:ANDY_EQUALIZER_CHANGED_NOTIFICATION object:nil];

    }
    return self;
}

- (void)equalizerDidChanged:(NSNotification *)notification
{
    AndyEqualizerEffectModel *model = notification.object;
    
    for (int i = 0; i < self.sliderArrayM.count; i++)
    {
        AndyEqualizerSlider *equalizerSlider = self.sliderArrayM[i];
        equalizerSlider.slider.value = [model.gainArray[i] floatValue];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat commonEdgeInsets = 10;
    
    CGFloat equalizerSliderY = commonEdgeInsets;
    CGFloat equalizerSliderW = 30;
    CGFloat equalizerSliderH = self.bounds.size.height - 2 * commonEdgeInsets;
    
    CGFloat leftMargin = (self.bounds.size.width - equalizerSliderW * self.sliderArrayM.count - 2 * commonEdgeInsets) / (self.sliderArrayM.count - 1);

    NSInteger index = 0;
    for (AndyEqualizerSlider *equalizerSlider in self.sliderArrayM)
    {
        CGFloat equalizerSliderX = (equalizerSliderW + leftMargin) * index + commonEdgeInsets;
        equalizerSlider.frame = CGRectMake(equalizerSliderX, equalizerSliderY, equalizerSliderW, equalizerSliderH);
        
        index++;
    }
}

//这里强制frame最小为300
- (void)setFrame:(CGRect)frame
{
    if (frame.size.width <= 300)
    {
        frame.size.width = 300;
    }
    
    return [super setFrame:frame];
}

//当然Bounds也要设置
- (void)setBounds:(CGRect)bounds
{
    if (bounds.size.width <= 300)
    {
        bounds.size.width = 300;
    }
    
    return [super setBounds:bounds];
}

 -(void)dealloc
{
    [AndyEqualizerNoteCenter removeObserver:self];
}

@end
