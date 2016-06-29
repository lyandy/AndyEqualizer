//
//  AndyEqualizerTableViewCell.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/29.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyEqualizerTableViewCell.h"

@interface AndyEqualizerTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation AndyEqualizerTableViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupAutoLayout];
    
    self.selectedIndicator.backgroundColor = AndyRGBColor(219, 21, 26);
}

- (void)setupAutoLayout
{
    [self.selectedIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left);
        make.top.equalTo(self.contentView.top);
        make.bottom.equalTo(self.contentView.bottom);
        make.width.equalTo(5);
    }];
}

- (void)setEqualizerEffectModel:(AndyEqualizerEffectModel *)equalizerEffectModel
{
    _equalizerEffectModel = equalizerEffectModel;
    self.textLabel.text = equalizerEffectModel.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.andy_Y = 2;
    self.textLabel.andy_Height = self.contentView.andy_Height - 2 * self.textLabel.andy_Y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : AndyRGBColor(78, 78, 78);
}

@end
