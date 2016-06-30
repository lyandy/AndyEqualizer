//
//  AndyMainTableViewController.m
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyMainTableViewController.h"
#import "AndyPlayViewController.h"
#import "SongModel.h"

@interface AndyMainTableViewController ()

@property (nonatomic, strong) NSMutableArray *songArrayM;
@property (nonatomic, copy) NSString *currentSongUUID;
@property (nonatomic, strong) AndyPlayer *player;

@end

@implementation AndyMainTableViewController

static NSString * const songCellId = @"songCellId";

- (NSMutableArray *)songArrayM
{
    if (_songArrayM == nil)
    {
        _songArrayM = [NSMutableArray array];
    }
    return _songArrayM;
}

- (AndyPlayer *)player
{
    if (_player == nil)
    {
        _player = [[AndyPlayer alloc] init];
    }
    return _player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"歌曲列表";

    [self setupSongsData];
}

- (void)setupSongsData
{
    SongModel *sm1 = [[SongModel alloc] init];
    sm1.songName = @"那些年";
    sm1.uuid = [[NSUUID UUID] UUIDString];;
    sm1.songURLPath = [[NSBundle mainBundle] URLForResource:sm1.songName withExtension:@"mp3"];
    
    [self.songArrayM addObject:sm1];
    
    SongModel *sm2 = [[SongModel alloc] init];
    sm2.songName = @"夜空中最亮的星";
    sm2.uuid = [[NSUUID UUID] UUIDString];;
    sm2.songURLPath = [[NSBundle mainBundle] URLForResource:sm2.songName withExtension:@"mp3"];
    
    [self.songArrayM addObject:sm2];
    
    SongModel *sm3 = [[SongModel alloc] init];
    sm3.songName = @"IF YOU";
    sm3.uuid = [[NSUUID UUID] UUIDString];
    sm3.songURLPath = [[NSBundle mainBundle] URLForResource:sm3.songName withExtension:@"mp3"];
    
    [self.songArrayM addObject:sm3];
    
    SongModel *sm4 = [[SongModel alloc] init];
    sm4.songName = @"test";
    sm4.uuid = [[NSUUID UUID] UUIDString];;
    sm4.songURLPath = [[NSBundle mainBundle] URLForResource:sm4.songName withExtension:@"mp3"];
    
    [self.songArrayM addObject:sm4];
    
    SongModel *sm5 = [[SongModel alloc] init];
    sm5.songName = @"我的天空";
    sm5.uuid = [[NSUUID UUID] UUIDString];
    sm5.songURLPath = [[NSBundle mainBundle] URLForResource:sm5.songName withExtension:@"mp3"];
    
    [self.songArrayM addObject:sm5];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songCellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:songCellId];
    }
    
    SongModel *sm = self.songArrayM[indexPath.row];
    
    cell.textLabel.text = sm.songName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SongModel *sm = self.songArrayM[indexPath.row];
    if (![self.currentSongUUID isEqualToString:sm.uuid])
    {
        //此处开始新的歌曲播放
        [[AndyDictStore sharedDictStore] setOrUpdateValue:sm.songName ForKey:CURRENT_PLAY_SONG_NAME];
        
        [self.player freeMemory];
        
        //设置歌曲播放路径
        [self.player setSongURLPath:sm.songURLPath];
        //开始播放音乐
        [self.player startAUGraph];
        
        //暂停音乐
        //[self.player pauseAUGraph];
    }
    else
    {
        //发现点击的是同一歌曲，则什么也不做，直接跳转
    }
    
    //记录当前播放歌曲的uuid
    self.currentSongUUID = sm.uuid;
    
    AndyPlayViewController *playVc = [[AndyPlayViewController alloc] initWithPlayer:self.player];
    
    [self.navigationController pushViewController:playVc animated:YES];
}



@end
