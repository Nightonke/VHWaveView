//
//  QMSmoothRandomCreator.m
//  QMWaveView
//
//  Created by viktorhuang on 16/9/19.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHSmoothRandomCreator.h"

@interface VHSmoothRandomCreator ()

@property (nonatomic, assign) float lastRandom;
@property (nonatomic, assign) float currentRandom;
@property (nonatomic, assign) BOOL lastRandomIsUnknown;
@property (nonatomic, assign) int step;
@property (nonatomic, assign) int newPeriod;

@end

@implementation VHSmoothRandomCreator

- (instancetype)init
{
    self = [super init];
    if (nil != self)
    {
        self.lastRandom = 0;
        self.lastRandomIsUnknown = YES;
        self.period = 100;
        self.newPeriod = self.period;
        self.step = 0;
    }
    return self;
}

- (instancetype)initWithMax:(float)maxValue withMin:(float)minValue
{
    self = [self init];
    if (nil != self)
    {
        self.maxValue = maxValue;
        self.minValue = minValue;
    }
    return self;
}

- (instancetype)initWithMax:(float)maxValue withMin:(float)minValue withPeriod:(int)period
{
    self = [self init];
    if (nil != self)
    {
        self.maxValue = maxValue;
        self.minValue = minValue;
        self.period = period;
    }
    return self;
}

- (float)random
{
    if (self.lastRandomIsUnknown)
    {
        [self calculateRandom];
        self.lastRandom = self.currentRandom;
        [self calculateRandom];
        self.step = 0;
        self.lastRandomIsUnknown = NO;
    }
    else
    {
        if (self.step == self.period)
        {
            if (self.period != self.newPeriod)
            {
                _period = _newPeriod;
            }
            self.lastRandom = self.currentRandom;
            [self calculateRandom];
            self.step = 0;
        }
    }
    return (self.currentRandom - self.lastRandom) * (self.step++) / self.period + self.lastRandom;
}

- (void)calculateRandom
{
    self.currentRandom = (((float)arc4random() / 0x100000000) * (self.maxValue - self.minValue) + self.minValue);
}

- (void)setPeriod:(int)period
{
    if (period <= 0)
    {
        return;
    }
    _period = period;
    _newPeriod = period;
}

- (void)setNextPeriod:(int)newPeriod
{
    if (newPeriod <= 0)
    {
        return;
    }
    self.newPeriod = newPeriod;
}

@end
