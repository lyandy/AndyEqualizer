//
//  AndyPlayViewController.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyPlayViewController.h"
#import "AndyEqualizerTableViewController.h"

@interface AndyPlayViewController ()<AndyPlayerDelegate>

@property (nonatomic, strong) AndyPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *songTitleSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *songTimeSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *songEqualizerSummaryLabel;
@property (weak, nonatomic) IBOutlet UISlider *songSlider;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *songTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *songEqualizerLabel;

@property (nonatomic, weak) AndyEqualizerView *equalizerView;

@end

@implementation AndyPlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupSubViews];
    
    [self setupAutoLayout];
}

- (void)setupNavBar
{
    self.navigationItem.title = @"歌曲播放";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择音效" style:UIBarButtonItemStylePlain target:self action:@selector(selectEqualizer:)];
}

- (void)selectEqualizer:(UIBarButtonItem *)item
{
    AndyEqualizerTableViewController *equalizerVc = [[AndyEqualizerTableViewController alloc] initWithPlayer:self.player];
    [self.navigationController pushViewController:equalizerVc animated:YES];
}

- (void)setupSubViews
{
    @weakify(self);
    //RAC监听通知
    [[AndyEqualizerNoteCenter rac_addObserverForName:ANDY_EQUALIZER_CHANGED_NOTIFICATION object:nil] subscribeNext:^(NSNotification * notification) {
        
        @strongify(self);
        
        AndyEqualizerEffectModel *model = notification.object;
        
        self.songEqualizerLabel.text  = model.name;
    }];
    
    self.songTitleLabel.text = (NSString *)[[AndyDictStore sharedDictStore] getValueForKey:CURRENT_PLAY_SONG_NAME DefaultValue:@"未知"];
    
    AndyEqualizerView *equalizerView = [AndyEqualizerView equalizerViewWithPlayer:self.player];
    [self.view addSubview:equalizerView];
    self.equalizerView = equalizerView;
    
    //设置已存储的音效
    __block AndyEqualizerEffectModel *equalizerEffectModel = (AndyEqualizerEffectModel *)[[AndyJsonStore sharedJsonStore] getValueForClass:[AndyEqualizerEffectModel class] ForKey:CURRENT_EQUALIZER_EFFECT DefaultValue:nil];
    if (equalizerEffectModel == nil)
    {
        //去找寻一个默认的音效
        [self.player.equalizerEffectArray enumerateObjectsUsingBlock:^(AndyEqualizerEffectModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.equalizerEffect == EqualizerEffectDefault)
            {
                equalizerEffectModel = obj;
                
                [[AndyJsonStore sharedJsonStore] setOrUpdateValue:equalizerEffectModel ForKey:CURRENT_EQUALIZER_EFFECT];
                
                *stop = YES;
            }
        }];
    }
    self.player.equalizerEffect = equalizerEffectModel.equalizerEffect;
}

- (void)setupAutoLayout
{
    CGFloat commonVerticalMargin = 20;
    CGFloat commonHorizontalMargin = 30;
    
    [self.songTitleSummaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(commonHorizontalMargin);
        make.top.equalTo(self.view.top).offset(commonVerticalMargin + 64);
    }];
    
    [self.songTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songTitleSummaryLabel.right);
        make.top.equalTo(self.songTitleSummaryLabel.top);
    }];
    
    [self.songTimeSummaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songTitleSummaryLabel.left);
        make.top.equalTo(self.songTitleSummaryLabel.bottom).offset(commonVerticalMargin);
    }];
    
    [self.songTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songTimeSummaryLabel.right);
        make.top.equalTo(self.songTimeSummaryLabel.top);
    }];
    
    [self.songEqualizerSummaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songTitleSummaryLabel.left);
        make.top.equalTo(self.songTimeSummaryLabel.bottom).offset(commonVerticalMargin);
    }];
    
    [self.songEqualizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songEqualizerSummaryLabel.right);
        make.top.equalTo(self.songEqualizerSummaryLabel.top);
    }];
    
    [self.songSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([[UIScreen mainScreen] bounds].size.width - 2 * commonHorizontalMargin);
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.songEqualizerSummaryLabel.bottom).offset(commonVerticalMargin);
    }];
    
    [self.equalizerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.width).offset(-2 * 5);
        make.top.equalTo(self.songSlider.bottom).offset(2 * commonVerticalMargin);
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(self.view.bottom).offset(- commonVerticalMargin);
    }];
}

//歌曲播放进度代理
- (void)updateCurrentTime:(float)time
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.songTimeLabel.text = [NSString stringWithFormat:@"%d 秒",(int)time];
        
        self.songSlider.maximumValue = self.player.duration;
        self.songSlider.minimumValue = 0;
        
        if (!self.songSlider.isTracking)
        {
            self.songSlider.value = time;
        }
    });
}
- (IBAction)setSongTime:(UISlider *)sender
{
    [self.player setTime:sender.value];
}

- (instancetype)initWithPlayer:(AndyPlayer *)andyPlayer
{
    self = [super init];
    if (self)
    {
        self.player = andyPlayer;
        self.player.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.player.delegate = nil;
    [AndyEqualizerNoteCenter removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






















