//
//  RITViewController.m
//  19ViewsTestHW04
//
//  Created by Pronin Alexander on 01.03.14.
//  Copyright (c) 2014 Pronin Alexander. All rights reserved.
//

#import "RITViewController.h"

@interface RITViewController ()

@property (strong, nonatomic) UIView* chessboard;
@property (assign, nonatomic) NSUInteger borderOffset;
@property (assign, nonatomic) NSUInteger cellCount;
@property (assign, nonatomic) NSUInteger screenMin;
@property (assign, nonatomic) NSUInteger screenMax;
@property (assign, nonatomic) NSUInteger cellSize;
@property (assign, nonatomic) NSUInteger fieldSize;

@end

@implementation RITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeProperties];
    
    [self drawChessboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self changeColor];
    
}

#pragma mark - Helper methods

- (void) initializeProperties {
    
    self.borderOffset           = 20;
    self.cellCount              = 8;
    self.screenMin              = MIN(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.screenMax              = MAX(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    // calculate cell size and field size
    self.cellSize               = (self.screenMin - self.borderOffset * 2 - 4) / self.cellCount;
    self.fieldSize              = self.cellSize * self.cellCount + 4;
}

- (void) drawChessboard {
    // set initial coordinates
    CGRect rect;
    NSUInteger x = 0;
    NSUInteger y = 0;
    if (CGRectGetWidth(self.view.bounds) < CGRectGetHeight(self.view.bounds)) {
        // portrait or upside down
        x = (self.screenMin - self.fieldSize) / 2;
        y = (self.screenMax - self.screenMin) / 2;
    } else {
        // landscape (left or right)
        x = (self.screenMax - self.screenMin) / 2;
        y = (self.screenMin - self.fieldSize) / 2;
    }
    
    // set border (black box)
    rect = CGRectMake(x, y, self.fieldSize, self.fieldSize);
    self.chessboard = [[UIView alloc] initWithFrame:rect];
    self.chessboard.backgroundColor = [UIColor blackColor];
    self.chessboard.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.chessboard];
    
    // set white box
    rect                        = CGRectMake(
                                             1,
                                             1,
                                             CGRectGetWidth(rect) - 2,
                                             CGRectGetWidth(rect) - 2
                                             );
    
    UIView* whiteBox            = [[UIView alloc] initWithFrame:rect];
    whiteBox.backgroundColor    = [UIColor whiteColor];
    [self.chessboard addSubview:whiteBox];
    
    // draw cells
    UIView *view =  nil;
    y = 1;
    for (int i = 0; i < self.cellCount; i++) {
        
        x = self.cellSize * (i % 2) + 1;
        
        for (int j = 0; j < self.cellCount / 2; j++) {
            
            rect                    = CGRectMake(x, y, self.cellSize, self.cellSize);
            view                    = [[UIView alloc] initWithFrame:rect];
            view.backgroundColor    = [UIColor blackColor];
            [whiteBox addSubview:view];
            
            x+= self.cellSize * 2;
        }
        
        y+= self.cellSize;
    }
}

- (void) changeColor {
    
    UIColor* color;
    
    switch (arc4random() % 15) {
            
        case 0:
            color = [UIColor blackColor];
            break;
            
        case 1:
            color = [UIColor darkGrayColor];
            break;
            
        case 2:
            color = [UIColor lightGrayColor];
            break;
            
        case 3:
            color = [UIColor grayColor];
            break;
            
        case 4:
            color = [UIColor redColor];
            break;
            
        case 5:
            color = [UIColor greenColor];
            break;
            
        case 6:
            color = [UIColor blueColor];
            break;
            
        case 7:
            color = [UIColor cyanColor];
            break;
            
        case 8:
            color = [UIColor yellowColor];
            break;
            
        case 9:
            color = [UIColor magentaColor];
            break;
            
        case 10:
            color = [UIColor orangeColor];
            break;
            
        case 11:
            color = [UIColor purpleColor];
            break;
            
        case 12:
            color = [UIColor brownColor];
            break;
    }
    
    for (UIView* view in [[self.chessboard.subviews objectAtIndex:0] subviews]) {
        view.backgroundColor = color;
    }
}

- (NSString*) NSStringFromUIInterfaceOrientation:(UIInterfaceOrientation) orientation {
    
    NSString* result;
    
    switch (orientation) {
            
        case UIInterfaceOrientationPortrait:
            result = @"Portrait";
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            result = @"PortraitUpsideDown";
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            result = @"LandscapeLeft";
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            result = @"LandscapeRight";
            break;
    }
    return result;
}

@end
