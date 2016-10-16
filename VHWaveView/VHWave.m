//
//  VHWave.m
//  VHWaveView
//
//  Created by viktorhuang on 16/9/18.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHWave.h"
#import "VHSmoothRandomCreator.h"

@interface VHWave ()

@property (nonatomic, strong) VHSmoothRandomCreator *speedRandomCreator;
@property (nonatomic, strong) VHSmoothRandomCreator *amplitudeRandomCreator;
@property (nonatomic, strong) VHSmoothRandomCreator *heightRandomCreator;
@property (nonatomic, strong) VHSmoothRandomCreator *phaseRandomCreator;
@property (nonatomic, strong) VHSmoothRandomCreator *trendRandomCreator;
@property (nonatomic, strong) VHSmoothRandomCreator *frequencyRandomCreator;

@end

@implementation VHWave

- (instancetype)init
{
    self = [super init];
    if (nil != self)
    {
        self.type = VHWaveAllConst;
        self.isStroke = NO;
        self.strokeHeight = 2;
        
        self.speedRandomCreator = nil;
        self.speed = 2;
        self.minSpeed = 1;
        self.maxSpeed = 3;
        self.speedPeriod = 100;
        
        self.amplitudeRandomCreator = nil;
        self.amplitude = 22;
        self.minAmplitude = 25;
        self.maxAmplitude = 40;
        self.amplitudePeriod = 200;
        
        self.heightRandomCreator = nil;
        self.height = 0.5;
        self.minHeight = 0.3;
        self.maxHeight = 0.7;
        self.heightPeriod = 300;
        
        self.phaseRandomCreator = nil;
        self.phase = 0;
        self.minPhase = 0;
        self.maxPhase = 0;
        self.phasePeriod = 100;
        
        self.trendRandomCreator = nil;
        self.trend = 0;
        self.minTrend = -80;
        self.maxTrend = 80;
        self.trendPeriod = 300;
        
        self.frequencyRandomCreator = nil;
        self.frequency = 1;
        self.minFrequency = 0.5;
        self.maxFrequency = 1.5;
        self.frequencyPeriod = 300;
        
        self.gradientColors = [NSArray arrayWithObjects:(id)RAND_COLOR.CGColor, (id)RAND_COLOR.CGColor, nil];
        self.gradientLocations = [NSArray arrayWithObjects:@(0.5), nil];
        self.gradientStartPoint = CGPointMake(0, 0);
        self.gradientEndPoint = CGPointMake(0, 1);
    }
    return self;
}

- (void)setAmplitudePeriod:(int)amplitudePeriod
{
    if (amplitudePeriod < 0)
    {
        return;
    }
    [self.amplitudeRandomCreator setNextPeriod:amplitudePeriod];
    _amplitudePeriod = amplitudePeriod;
}

- (void)setMaxFrequency:(CGFloat)maxFrequency
{
    _maxFrequency = maxFrequency;
    if (nil == self.frequencyRandomCreator)
    {
        self.frequencyRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxFrequency withMin:self.minFrequency withPeriod:self.frequencyPeriod];
    }
    self.frequencyRandomCreator.maxValue = _maxFrequency;
    [self.frequencyRandomCreator setNextPeriod:300];
}

- (void)setMinFrequency:(CGFloat)minFrequency
{
    _minFrequency = minFrequency;
    if (nil == self.frequencyRandomCreator)
    {
        self.frequencyRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxFrequency withMin:self.minFrequency withPeriod:self.frequencyPeriod];
    }
    self.frequencyRandomCreator.minValue = _minFrequency;
}

- (void)setMaxSpeed:(CGFloat)maxSpeed
{
    _maxSpeed = maxSpeed;
    if (nil == self.speedRandomCreator)
    {
        self.speedRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxSpeed withMin:self.minSpeed withPeriod:self.speedPeriod];
    }
    self.speedRandomCreator.maxValue = _maxSpeed;
//    [self.speedRandomCreator setNextPeriod:300];
}

- (void)setMinSpeed:(CGFloat)minSpeed
{
    _minSpeed = minSpeed;
    if (nil == self.speedRandomCreator)
    {
        self.speedRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxSpeed withMin:self.minSpeed withPeriod:self.speedPeriod];
    }
    self.speedRandomCreator.minValue = _minSpeed;
}

- (CGFloat)randomSpeed
{
    if ((self.type & VHWaveSpeedRandom) == 0)
    {
        return self.speed;
    }
    if (nil == self.speedRandomCreator)
    {
        self.speedRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxSpeed withMin:self.minSpeed withPeriod:self.speedPeriod];
    }
    return [self.speedRandomCreator random];
}

- (CGFloat)randomAmplitude
{
    if ((self.type & VHWaveAmplitudeRandom) == 0)
    {
        return self.amplitude;
    }
    if (nil == self.amplitudeRandomCreator)
    {
        self.amplitudeRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxAmplitude withMin:self.minAmplitude withPeriod:self.amplitudePeriod];
    }
    return [self.amplitudeRandomCreator random];
}

- (CGFloat)randomHeight
{
    if ((self.type & VHWaveHeightRandom) == 0)
    {
        return self.height;
    }
    if (nil == self.heightRandomCreator)
    {
        self.heightRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxHeight withMin:self.minHeight withPeriod:self.heightPeriod];
    }
    return [self.heightRandomCreator random];
}

- (CGFloat)randomPhase
{
    if ((self.type & VHWavePhaseRandom) == 0)
    {
        return self.phase;
    }
    if (nil == self.phaseRandomCreator)
    {
        self.phaseRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxPhase withMin:self.minPhase withPeriod:self.phasePeriod];
    }
    return [self.phaseRandomCreator random];
}

- (CGFloat)randomTrend
{
    if ((self.type & VHWaveTrendRandom) == 0)
    {
        return self.trend;
    }
    if (nil == self.trendRandomCreator)
    {
        self.trendRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxTrend withMin:self.minTrend withPeriod:self.trendPeriod];
    }
    return [self.trendRandomCreator random];
}

- (CGFloat)randomFrequency
{
    if ((self.type & VHWaveFrequencyRandom) == 0)
    {
        return self.frequency;
    }
    if (nil == self.frequencyRandomCreator)
    {
        self.frequencyRandomCreator = [[VHSmoothRandomCreator alloc] initWithMax:self.maxFrequency withMin:self.minFrequency withPeriod:self.frequencyPeriod];
    }
    return [self.frequencyRandomCreator random];
}

@end
