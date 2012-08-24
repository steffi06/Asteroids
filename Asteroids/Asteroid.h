//
//  Asteroid.h
//  Asteroids
//
//  Created by Stephanie Shupe on 8/23/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Asteroid : NSObject
+(Asteroid*) createAsteroidAtPosition: (CGPoint) point withView: (UIView*) view;
@property CALayer *layer;
-(void) move;
@end
