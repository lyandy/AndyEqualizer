//
//  AndyEqualizerTableViewController.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyEqualizerTableViewController.h"
#import "AndyEqualizerTableViewCell.h"

@interface AndyEqualizerTableViewController ()

@property (nonatomic, strong) AndyPlayer *player;
@property (nonatomic, strong) NSArray<AndyEqualizerEffectModel *> *equalizerEffectArray;

@end

@implementation AndyEqualizerTableViewController

static NSString * const equalizerEffectCellId = @"equalizerEffectCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"音效列表";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AndyEqualizerTableViewCell class]) bundle:nil] forCellReuseIdentifier:equalizerEffectCellId];
    
    }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //处理选中
    __block AndyEqualizerEffectModel *equalizerEffectModel = (AndyEqualizerEffectModel *)[[AndyJsonStore sharedJsonStore] getValueForClass:[AndyEqualizerEffectModel class] ForKey:CURRENT_EQUALIZER_EFFECT DefaultValue:nil];
    __block NSInteger indexpathRow = -1;
    
    //去找寻到底是哪个音效
    [self.player.equalizerEffectArray enumerateObjectsUsingBlock:^(AndyEqualizerEffectModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.equalizerEffect == equalizerEffectModel.equalizerEffect)
        {
            *stop = YES;
        }
        
        indexpathRow++;
    }];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexpathRow inSection:0];

    [self.tableView selectRowAtIndexPath:indexpath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (instancetype)initWithPlayer:(AndyPlayer *)andyPlayer
{
    self = [super init];
    if (self)
    {
        self.player = andyPlayer;
        self.equalizerEffectArray = andyPlayer.equalizerEffectArray;
        
        [self.tableView reloadData];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.equalizerEffectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AndyEqualizerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:equalizerEffectCellId];
    cell.equalizerEffectModel = self.equalizerEffectArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AndyEqualizerEffectModel *eem = self.equalizerEffectArray[indexPath.row];
    
    //设置当前音效
    self.player.equalizerEffect = eem.equalizerEffect;
    
    //存储当前音效
    [[AndyJsonStore sharedJsonStore] setOrUpdateValue:eem ForKey:CURRENT_EQUALIZER_EFFECT];
}

- (void)dealloc
{
    AndyLog(@"%@ 释放了", self);
}

@end
