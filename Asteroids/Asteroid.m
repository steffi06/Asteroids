//
//  Asteroid.m
//  Asteroids
//
//  Created by Stephanie Shupe on 8/23/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>
#import "AsteroidsGeometryUtility.h"

@interface Asteroid ()


@end

@implementation Asteroid
+(Asteroid*) createAsteroidAtPosition: (CGPoint) point withView: (UIView*) view{
    Asteroid *asteroid = [Asteroid new];
    
    asteroid.layer = [CALayer new];
    asteroid.layer.bounds = CGRectMake( 0 , 0 , 50 , 30 );
    asteroid.layer.position = point;
    
    asteroid.layer.delegate = asteroid;
    [asteroid.layer setNeedsDisplay];
    
    [view.layer addSublayer:asteroid.layer];
    
    return asteroid;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, [UIColor darkGrayColor].CGColor);
    CGContextFillEllipseInRect(ctx, layer.bounds);
}

-(void)move {
    [CATransaction begin];
    [CATransaction setAnimationDuration: ((double)arc4random()/UINT_MAX + 1)*200];
    [CATransaction setCompletionBlock:^{
        [self move];
    }];
    
    CAKeyframeAnimation *animKeyFrame = [CAKeyframeAnimation animationWithKeyPath: @"position"];

    
    CGPoint randomPoint = [AsteroidsGeometryUtility randomPointWithRect: self.layer.superlayer.bounds];
//    double posX = randomPoint.x *3;
//    double posY = randomPoint.y *3;
    
    float radius = hypotf(self.layer.position.x - randomPoint.x, self.layer.position.y - randomPoint.y);
    
    
    CGMutablePathRef newPath = CGPathCreateMutable();
    CGPathAddArc(newPath, NULL, self.layer.position.x, self.layer.position.y, radius, 180, M_PI , YES);
    
//    CGPathMoveToPoint(newPath, NULL, self.layer.position.x, self.layer.position.y);
//    CGPathAddQuadCurveToPoint(newPath, NULL, (self.layer.position.x +randomPoint.x)/2, (self.layer.position.y + randomPoint.y)/2, randomPoint.x, randomPoint.y);

//    CGPathAddLineToPoint(newPath, NULL, randomPoint.x, randomPoint.y);
    animKeyFrame.path = newPath;


    [self.layer addAnimation:animKeyFrame forKey:@"position"];
    self.layer.position = CGPathGetCurrentPoint(newPath);
    
    
    [CATransaction commit];
}


@end

