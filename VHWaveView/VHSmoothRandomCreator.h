//
//  QMSmoothRandomCreator.h
//  QMWaveView
//
//  Created by viktorhuang on 16/9/19.
//  Copyright © 2016年 黄伟平. All rights reserved.
//
//  随机数平滑化获取器
//  设定最大值、最小值，然后设置period，周期之意
//  然后每次调用random方法，便能获取平滑的随机值，而不是突变的随机值
//  获取period次之后，刷新下一个随机值

#import <Foundation/Foundation.h>

@interface VHSmoothRandomCreator : NSObject

@property (nonatomic, assign) float maxValue;  // 随机数的最大值
@property (nonatomic, assign) float minValue;  // 随机数的最小值
@property (nonatomic, assign) int   period;    // 随机数变化周期

/**
 *  获取下一个随机值
 *
 *  @return 随机值
 */
- (float)random;

- (instancetype)initWithMax:(float)maxValue withMin:(float)minValue;

- (instancetype)initWithMax:(float)maxValue withMin:(float)minValue withPeriod:(int)period;

/**
 *  设置
 *
 *  @param newPeriod 下一个周期，当前周期运行完之后，会切换到下一个周期
 */
- (void)setNextPeriod:(int)newPeriod;

@end
