//
//  QMWaveView.h
//  QMWaveView
//
//  Created by viktorhuang on 16/9/18.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMWave.h"

@interface VHWaveView : UIView

/**
 *  增加一个波浪
 *
 *  @param wave 波浪
 */
- (void)addWave:(QMWave *)wave;

/**
 *  去掉一个波浪
 *
 *  @param wave 波浪
 */
- (void)removeWave:(QMWave *)wave;

/**
 *  根据下标获取波浪
 *
 *  @param index 下标
 *
 *  @return 波浪
 */
- (QMWave *)getWave:(int)index;

/**
 *  获取所有的波浪
 *
 *  @return 所有的波浪
 */
- (NSMutableArray<QMWave *> *)getWaves;

/**
 *  开始在QMWaveView上增加波浪的layer并开始波动
 *  注意，所有对wave的修改，都应该在这个函数之前做
 */
- (void)start;

/**
 *  去掉QMWaveView的所有波浪layer并停止波动
 */
- (void)stop;

/**
 *  是否有波浪的layer
 *
 *  @return 是／否
 */
- (BOOL)hasActuallyWaves;

/**
 *  恢复波动
 */
- (void)resume;

/**
 *  暂停波动
 */
- (void)pause;

/**
 *  是否正在波动
 *
 *  @return 是／否
 */
- (BOOL)isWaving;

@end
