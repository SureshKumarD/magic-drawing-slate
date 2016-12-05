//
//  DrawingView.m
//  MagicDrawingSlate
//
//  Created by Suresh on 12/5/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView() {
    NSMutableArray *drawingPoints;
    UIImage *drawImage;
}

@end
@implementation DrawingView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        drawingPoints = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        drawingPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =  (UITouch *)touches.allObjects.firstObject;
    NSValue *pointValue = [NSValue valueWithCGPoint:[touch locationInView:self]];
    [drawingPoints addObject:pointValue];
   
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =  (UITouch *)touches.allObjects.firstObject;
    NSValue *pointValue = [NSValue valueWithCGPoint:[touch locationInView:self]];
    [drawingPoints addObject:pointValue];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    [drawingPoints removeAllObjects];
}

- (CGPoint)getPointFromValue:(NSValue *)nsValue {
    return [nsValue CGPointValue];
}

- (CGPoint)getMidPointFromA:(NSValue *)A B:(NSValue *)B {
    CGPoint pointA = [self getPointFromValue:A];
    CGPoint pointB = [self getPointFromValue:B];
    return CGPointMake((pointA.x + pointB.x)/2, (pointA.y + pointB.y)/2);
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blueColor] setStroke];
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineWidth     = 3.0f;
    if(drawImage) {
        [drawImage drawInRect:self.bounds];
    }
    if([drawingPoints count] > 0) {
       
        [path moveToPoint:[self getPointFromValue:drawingPoints.firstObject]];
        [path addLineToPoint:
         [self getMidPointFromA:drawingPoints.firstObject
                              B:[drawingPoints objectAtIndex:1]]];
        for(int i = 1; i<[drawingPoints count] -1; i++) {
    
            [path addQuadCurveToPoint: [self getMidPointFromA:[drawingPoints objectAtIndex:i] B:[drawingPoints objectAtIndex:i+1]] controlPoint:[self getPointFromValue:[drawingPoints objectAtIndex:i]]];
        }
        [path addLineToPoint:[self getPointFromValue:[drawingPoints lastObject]]];
        [path stroke];
    }
    
}

@end
