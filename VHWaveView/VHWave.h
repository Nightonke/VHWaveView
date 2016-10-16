//
//  VHWave.h
//  VHWaveView
//
//  Created by viktorhuang on 16/9/18.
//  Copyright © 2016年 黄伟平. All rights reserved.
//
//  波浪模型，VHWaveView根据每个VHWave来画波浪

#import <UIKit/UIKit.h>

#define ARGB(argbValue) [UIColor colorWithRed:((float)((argbValue & 0x00FF0000) >> 16)) / 255.0 green:((float)((argbValue & 0x0000FF00) >> 8)) / 255.0 blue:((float)(argbValue & 0x000000FF)) / 255.0 alpha:((float)((argbValue & 0xFF000000) >> 24)) / 255.0]
#define RAND(min, max) (min + arc4random_uniform(max - min + 1))
#define RAND_COLOR ARGB((200 << 24) + (RAND(0, 255) << 16) + (RAND(0, 255) << 8) + RAND(0, 255))

/**
 *  波浪类型
 */
typedef NS_OPTIONS(NSUInteger, VHWaveType)
{
    /**
     *  所有属性都是常量
     */
    VHWaveAllConst                 = 0,
    /**
     *  速度是随机量
     */
    VHWaveSpeedRandom              = 1 << 0,
    /**
     *  振幅是随机量
     */
    VHWaveAmplitudeRandom          = 1 << 1,
    /**
     *  高度是随机量
     */
    VHWaveHeightRandom             = 1 << 2,
    /**
     *  水平位移是随机量
     */
    VHWavePhaseRandom              = 1 << 3,
    /**
     *  走势是随机量
     */
    VHWaveTrendRandom              = 1 << 4,
    /**
     *  频率是随机量
     */
    VHWaveFrequencyRandom          = 1 << 5,
    /**
     *  渐变色是随机量
     */
    VHWaveGradientColorsRandom     = 1 << 6,
    /**
     *  渐变色断点是随机量
     */
    VHWaveGradientLocationsRandom  = 1 << 7,
    /**
     *  渐变色的开始点是随机量
     */
    VHWaveGradientStartPointRandom = 1 << 8,
    /**
     *  渐变色的终点是随机量
     */
    VHWaveGradientEndPointRandom   = 1 << 9,
};

@interface VHWave : NSObject

@property (nonatomic, assign) VHWaveType type;                                  // 波浪类型
@property (nonatomic, assign) BOOL       isStroke;                              // 波浪是否为空心
@property (nonatomic, assign) CGFloat    strokeHeight;                          // 波浪如果为空心，波浪线的“宽度”，注意宽度的含义，不是线的宽度，而是上下线的绝对距离

@property (nonatomic, assign) CGFloat    speed;                                 // 波浪速度
@property (nonatomic, assign) CGFloat    minSpeed;                              // 最小波浪速度，仅在“速度是随机量”为真时有效，下面其他属性类似，不做此项解释
@property (nonatomic, assign) CGFloat    maxSpeed;                              // 最大波浪速度，仅在“速度是随机量”为真时有效，下面其他属性类似，不做此项解释
@property (nonatomic, assign) int        speedPeriod;                           // 波浪为随机时，变化的周期，下面其他属性类似，不做此项解释

@property (nonatomic, assign) CGFloat    amplitude;                             // 振幅
@property (nonatomic, assign) CGFloat    minAmplitude;
@property (nonatomic, assign) CGFloat    maxAmplitude;
@property (nonatomic, assign) int        amplitudePeriod;

@property (nonatomic, assign) CGFloat    height;                                // 高度
@property (nonatomic, assign) CGFloat    minHeight;
@property (nonatomic, assign) CGFloat    maxHeight;
@property (nonatomic, assign) int        heightPeriod;

@property (nonatomic, assign) CGFloat    phase;                                 // 水平位移
@property (nonatomic, assign) CGFloat    minPhase;
@property (nonatomic, assign) CGFloat    maxPhase;
@property (nonatomic, assign) int        phasePeriod;

@property (nonatomic, assign) CGFloat    trend;                                 // 走势
@property (nonatomic, assign) CGFloat    minTrend;
@property (nonatomic, assign) CGFloat    maxTrend;
@property (nonatomic, assign) int        trendPeriod;

@property (nonatomic, assign) CGFloat    frequency;                             // 频率
@property (nonatomic, assign) CGFloat    minFrequency;
@property (nonatomic, assign) CGFloat    maxFrequency;
@property (nonatomic, assign) int        frequencyPeriod;

@property (nonatomic, copy  ) NSArray<UIColor    *> *gradientColors;            // 渐变色，参考CAGradientLayer的官方文档
@property (nonatomic, strong) NSArray<NSNumber   *> *gradientLocations;         // 渐变色的转折点
@property (nonatomic, assign) CGPoint    gradientStartPoint;                    // 渐变色开始点
@property (nonatomic, assign) CGPoint    gradientEndPoint;                      // 渐变色结束点

/**
 *  获取随机速度
 *
 *  @return 随机速度
 */
- (CGFloat)randomSpeed;

/**
 *  获取随机振幅
 *
 *  @return 随机振幅
 */
- (CGFloat)randomAmplitude;

/**
 *  获取随机高度
 *
 *  @return 随机高度
 */
- (CGFloat)randomHeight;

/**
 *  获取随机水平位移
 *
 *  @return 随机水平位移
 */
- (CGFloat)randomPhase;

/**
 *  获取随机走势
 *
 *  @return 随即走势
 */
- (CGFloat)randomTrend;

/**
 *  获取随机频率
 *
 *  @return 随机频率
 */
- (CGFloat)randomFrequency;

@end
