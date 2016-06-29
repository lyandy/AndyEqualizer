//
//  SongModel.h
//  AndyEqualizer_Test
//
//  Created by 李扬 on 16/6/28.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject

@property (nonatomic, copy) NSString *songName;

@property (nonatomic, strong) NSURL *songURLPath;

@property (nonatomic, copy) NSString *uuid;

@end
