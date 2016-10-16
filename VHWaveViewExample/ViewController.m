//
//  ViewController.m
//  VHWaveView
//
//  Created by viktorhuang on 16/10/16.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "ViewController.h"

#define RGB(R,G,B)              [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#define RGBA(R,G,B,A)           [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/255.0f]

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    CGRect screenFrame         = [[UIScreen mainScreen] bounds];
    self.view                  = [[UIView alloc] initWithFrame:screenFrame];
    self.view.backgroundColor  = RGB(255, 255, 255);
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

@end
