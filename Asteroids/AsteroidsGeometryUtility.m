//
//  AsteroidsGeometryUtility.m
//  Asteroids
//
//  Created by Stephanie Shupe on 8/23/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import "AsteroidsGeometryUtility.h"

@implementation AsteroidsGeometryUtility

+(CGPoint)randomPointWithRect:(CGRect)rect {
    double xPos = ((double) arc4random() / UINT_MAX) * (rect.size.width);
    double yPos = ((double) arc4random() / UINT_MAX) * (rect.size.height);
    
    return CGPointMake(xPos,yPos);
}

@end
