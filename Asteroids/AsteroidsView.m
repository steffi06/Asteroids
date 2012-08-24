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
        
        [self generateAsteroids];
//        for (int i = 0; i < 20; ++i){
//            Asteroid *nextAsteroid = [Asteroid createAsteroidAtPosition:[AsteroidsGeometryUtility randomPointWithRect:frame] withView: self];
//            [self.asteroids addObject: nextAsteroid];
//        }
//        
//        for (Asteroid *asteroid in self.asteroids) {
//            [asteroid move];
//        }
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector (generateAsteroids) userInfo:nil repeats:YES];
    NSLog(@"%@",timer);
    return self;
}

-(void)destroyAsteroidSubLayer:(CALayer *)asteroidLayer {
    [asteroidLayer removeFromSuperlayer];
    NSLog(@"Destroyed sublayer");
}

-(void)generateAsteroids {

    
    if (self.asteroids.count < 30) {
        NSLog(@"Generate!");
        for (int i = 0; i < 7 ; ++i) {
            Asteroid *nextAsteroid = [Asteroid createAsteroidAtPosition:[AsteroidsGeometryUtility randomPointWithRect:self.frame] withView:self];
            [self.asteroids addObject: nextAsteroid];
            [nextAsteroid move];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchedPoint = [[touches anyObject] locationInView:self];
    NSLog(@"Touch recognized");
    Asteroid *asteroidToRemove;

    for (Asteroid* asteroid in self.asteroids){
//        NSLog(@"Inside asteroids loop!");
//        NSLog(@"%@", asteroid.layer);
        CALayer *presLayer = [asteroid.layer presentationLayer];
        if (CGRectContainsPoint(presLayer.frame, touchedPoint) ) {
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
