//
//  AsteroidsView.m
//  Asteroids
//
//  Created by Stephanie Shupe on 8/23/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import "AsteroidsView.h"
#import "Asteroid.h"
#import "AsteroidsGeometryUtility.h"
#import <QuartzCore/QuartzCore.h>

@interface AsteroidsView()

@property (strong) NSMutableArray *asteroids;

@end

@implementation AsteroidsView
@synthesize asteroids = _asteroids;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.asteroids = [NSMutableArray new];
        
        for (int i = 0; i < 20; ++i){
            Asteroid *nextAsteroid = [Asteroid createAsteroidAtPosition:[AsteroidsGeometryUtility randomPointWithRect:frame] withView: self];
            [self.asteroids addObject: nextAsteroid];
        }
        
        for (Asteroid *asteroid in self.asteroids) {
            [asteroid move];
        }
    }
    
    return self;
}

-(void)destroyAsteroidSubLayer:(CALayer *)asteroidLayer {
    [asteroidLayer removeFromSuperlayer];
    NSLog(@"Destroyed sublayer");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchedPoint = [[touches anyObject] locationInView:self];
    NSLog(@"Touch recognized");
    Asteroid *asteroidToRemove;
    for (Asteroid* asteroid in self.asteroids){
//        NSLog(@"Inside asteroids loop!");
//        NSLog(@"%@", asteroid.layer);
        if (CGRectContainsPoint(asteroid.layer.frame, touchedPoint) ) {
            NSLog(@"Contained point found");
//            [self.asteroids removeObject:asteroid];
            [self destroyAsteroidSubLayer:asteroid.layer];
            asteroidToRemove = asteroid;
        }
    }
    [self.asteroids removeObject: asteroidToRemove];
    NSLog(@"%d", self.asteroids.count);
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
