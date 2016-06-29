//
//  AndyEqualizerSlider.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyEqualizerSlider.h"
#import "AndyPlayer.h"

#define FrequencyLabelFont [UIFont systemFontOfSize:13]

@interface AndyEqualizerSlider ()

@property (nonatomic, weak) UILabel *frequencyLabel;
@property (nonatomic, strong) AndyPlayer *player;

@end

@implementation AndyEqualizerSlider

- (instancetype)initWithTag:(NSInteger)tag player:(AndyPlayer *)player andFrequency:(NSString *)frequency
{
    self = [super init];
    if (self)
    {
        UISlider *slider = [[UISlider alloc] init];
        slider.maximumValue = 12.0f;
        slider.minimumValue = -12.0f;
        slider.value = 0.0f;
        slider.tag = tag;
        [slider addTarget:self action:@selector(setEqualizerValue:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        self.slider = slider;
        
        UILabel *frequencyLabel = [[UILabel alloc] init];
        //frequencyLabel.textColor = [UIColor whiteColor];
        frequencyLabel.text = frequency;
        frequencyLabel.font = FrequencyLabelFont;
        [self addSubview:frequencyLabel];
        self.frequencyLabel = frequencyLabel;
        
        self.player = player;
    }
    return self;
}

- (void)setEqualizerValue:(UISlider *)slider
{
    [self.player setEQ:(float)slider.tag gain:slider.value];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableDictionary *frequencyLabelM = [NSMutableDictionary dictionary];
    frequencyLabelM[NSFontAttributeName] = FrequencyLabelFont;
    CGSize frequencyLabelSize = [self.frequencyLabel.text sizeWithAttributes:frequencyLabelM];
    
    CGFloat sliderY = 0;
    CGFloat sliderW = 30;
    CGFloat sliderH = self.bounds.size.height - frequencyLabelSize.height;
    CGFloat sliderX = (self.bounds.size.width - sliderW) / 2;
    self.slider.transform = CGAffineTransformMakeRotation(-M_PI/2);
    self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
    
    CGFloat frequencyLabelX = (self.bounds.size.width - frequencyLabelSize.width) / 2;
    CGFloat frequencyLabelY = (self.bounds.size.height
                               - frequencyLabelSize.height);
    self.frequencyLabel.frame = CGRectMake(frequencyLabelX, frequencyLabelY, frequencyLabelSize.width, frequencyLabelSize.height);
}

//这里强制frame最小为100
- (void)setFrame:(CGRect)frame
{
    if (frame.size.height <= 100)
    {
        frame.size.height = 100;
    }
    
    return [super setFrame:frame];
}

//当然Bounds也要设置
- (void)setBounds:(CGRect)bounds
{
    if (bounds.size.height <= 100)
    {
        bounds.size.height = 100;
    }
    
    return [super setBounds:bounds];
}

@end
