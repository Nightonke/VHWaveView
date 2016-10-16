//
//  VHWaveView.m
//  VHWaveView
//
//  Created by viktorhuang on 16/9/18.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "VHWaveView.h"
#import "VHSmoothRandomCreator.h"

static CGFloat const OPTIMIZE_FRAME = 1;  // 优化帧率

@interface VHWaveView ()

@property (nonatomic, assign) BOOL hasWaving;
@property (nonatomic, assign) BOOL isWaving;

@property (nonatomic, strong) NSMutableArray<VHWave *> *waves;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *offsets;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> *shapeLayers;
@property (nonatomic, strong) NSMutableArray<CAGradientLayer *> *gradientLayers;

@end

@implementation VHWaveView

#pragma mark Public Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (nil != self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        
        self.hasWaving = NO;
        self.isWaving = NO;
        
        self.waves = [NSMutableArray array];
        self.offsets = [NSMutableArray array];
        self.shapeLayers = [NSMutableArray array];
        self.gradientLayers = [NSMutableArray array];
        
        self.waveHeight = frame.size.height;
        self.waveWidth = frame.size.width;
    }
    return self;
}

- (void)addWave:(VHWave *)wave
{
    [self.waves addObject:wave];
}

- (void)removeWave:(VHWave *)wave
{
    [self.waves removeObject:wave];
}

- (VHWave *)getWave:(int)index
{
    return [self.waves objectAtIndex:index];
}

- (NSMutableArray<VHWave *> *)getWaves
{
    return self.waves;
}

- (void)layoutSubviews
{
    [self.offsets removeAllObjects];
    [self.shapeLayers removeAllObjects];
    [self.gradientLayers removeAllObjects];
    for (VHWave *wave in self.waves)
    {
        [self.offsets addObject:[NSNumber numberWithFloat:0]];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [self.shapeLayers addObject:shapeLayer];
        
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = wave.gradientColors;
        gradientLayer.frame = self.bounds;
        gradientLayer.locations = wave.gradientLocations;
        gradientLayer.startPoint = wave.gradientStartPoint;
        gradientLayer.endPoint = wave.gradientEndPoint;
        gradientLayer.mask = shapeLayer;
        [self.gradientLayers addObject:gradientLayer];
        [self.layer addSublayer:gradientLayer];
    }
}

- (void)start
{
    if (YES == self.hasWaving)
    {
        return;
    }
    self.hasWaving = YES;
    self.isWaving = YES;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setWavePaths)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    if (NO == self.hasWaving)
    {
        return;
    }
    self.hasWaving = NO;
    self.isWaving = NO;
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (BOOL)hasActuallyWaves
{
    return self.hasWaving;
}

- (void)resume
{
    if (nil != self.displayLink && YES == self.displayLink.paused)
    {
        self.displayLink.paused = NO;
    }
}

- (void)pause
{
    if (nil != self.displayLink && NO == self.displayLink.paused)
    {
        self.displayLink.paused = YES;
    }
}

- (BOOL)isWaving
{
    return self.isWaving;
}

#pragma mark Private Methods

- (void)setWavePaths
{
    for (int i = 0; i < self.waves.count; i++)
    {
        [self setCurrentWavePath:_displayLink atIndex:i];
    }
}

- (void)setCurrentWavePath:(CADisplayLink *)displayLink atIndex:(int)index
{
    if (index >= self.offsets.count)
    {
        return;
    }
    CGFloat offset = [[self.offsets objectAtIndex:index] floatValue];
    offset += [[self.waves objectAtIndex:index] randomSpeed];
    [self.offsets setObject:[NSNumber numberWithFloat:offset] atIndexedSubscript:index];
    CGPathRef path =[self getCurrentWavePath:index];
    [self.shapeLayers objectAtIndex:index].path = path;
    if (path != NULL)
    {
        CGPathRelease(path);
        path = NULL;
    }
}

- (CGPathRef)getCurrentWavePath:(int)index
{
    VHWave *wave = [self.waves objectAtIndex:index];
    CGFloat height = [wave randomHeight] * self.waveHeight;
    CGFloat amplitude = [wave randomAmplitude];
    CGFloat trend = [wave randomTrend];
    CGFloat frequency = [wave randomFrequency];
    CGFloat offset = [self.offsets objectAtIndex:index].floatValue;
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (YES == wave.isStroke)
    {
        CGFloat strokeHeight = wave.strokeHeight;
        CGFloat ys[(int)_waveWidth + 1];
        CGFloat y = amplitude * sinf((360 / self.waveWidth) * (wave.phase * M_PI * frequency / 180) - [self.offsets objectAtIndex:index].floatValue * M_PI / 180) + height;
        CGPathMoveToPoint(path, nil, 0, y);
        ys[0] = y + strokeHeight;
        
        for (float x = 1.0f; x <= self.waveWidth ; x++)
        {
            y = amplitude * sinf((360 / self.waveWidth) * ((x + wave.phase) * M_PI * frequency / 180) - [self.offsets objectAtIndex:index].floatValue * M_PI / 180) + height - trend * (x / self.waveWidth);
            CGPathAddLineToPoint(path, nil, x, y);
            ys[(int)x] = y + strokeHeight;
        }
        
        for (float x = self.waveWidth; x >= 0; x--)
        {
            CGPathAddLineToPoint(path, nil, x, ys[(int)x]);
        }
        
        CGPathCloseSubpath(path);
    }
    else
    {
        CGPathMoveToPoint(path, nil, 0, self.frame.size.height);
//        for (CGFloat x = 0.0f; x <= self.waveWidth; x++)
//        {
//            CGFloat y = sinf(M_PI / 180 * (360 / self.waveWidth * (frequency * x - offset)));
//            y = amplitude * y - trend * (x / self.waveWidth) + height;
//            CGPathAddLineToPoint(path, nil, x, y);
//        }
        // 优化公式： y = sinf(2 * M_PI / self.waveWidth * frequency * x - 2 * M_PI / self.waveWidth * offset)
        CGFloat increment = 2 * M_PI / self.waveWidth * frequency * OPTIMIZE_FRAME;
        CGFloat minTx = -2 * M_PI / self.waveWidth * offset;
        CGFloat maxTx = 2 * M_PI / self.waveWidth * frequency * (self.waveWidth + OPTIMIZE_FRAME) + minTx;
        CGFloat y;
        CGFloat x = 0;
        CGFloat trendValue = 0;
        CGFloat incrementTrend = -trend / self.waveWidth;
        for (CGFloat tx = minTx; tx <= maxTx; tx += increment)
        {
            y = amplitude * sinf(tx) + trendValue + height;
            CGPathAddLineToPoint(path, nil, x, y);
            trendValue += incrementTrend;
            x += OPTIMIZE_FRAME;
        }
        CGPathAddLineToPoint(path, nil, self.waveWidth, self.frame.size.height);
        CGPathCloseSubpath(path);
    }
    
    return path;
}

@end
