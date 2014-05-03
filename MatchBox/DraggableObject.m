//
//  DraggableObject.m
//  MatchBox
//
//  Created by Matthew McHugh on 5/2/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "DraggableObject.h"

@implementation DraggableObject

@synthesize startPoint;
@synthesize newPoint;
@synthesize startCenterPoint;
@synthesize theMatchBoxViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    startCenterPoint = self.center;
    startPoint = [[touches anyObject] locationInView:self];
    NSLog(@"Touches Began");
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    newPoint = [[touches anyObject] locationInView:self.superview];
    newPoint.x -= startPoint.x;
    newPoint.y -= startPoint.y;
    CGRect frame = [self frame];
    frame.origin = newPoint;
    [self setFrame:frame];
    NSLog(@"Touches Moved");
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Ended");
    
    if (theMatchBoxViewController.leftFilled == NO && [self distanceFromPoint:theMatchBoxViewController.leftMatchCenterPoint] < 30.0f) {
        NSLog(@"Left Match");
        theMatchBoxViewController.leftFilled = YES;
        self.center = CGPointMake(theMatchBoxViewController.leftMatchCenterPoint.x, theMatchBoxViewController.leftMatchCenterPoint.y);
    }
    else if (theMatchBoxViewController.rightFilled == NO && [self distanceFromPoint:theMatchBoxViewController.rightMatchCenterPoint] < 30.0f) {
        NSLog(@"Right Match");
        theMatchBoxViewController.rightFilled = YES;
        self.center = CGPointMake(theMatchBoxViewController.rightMatchCenterPoint.x, theMatchBoxViewController.rightMatchCenterPoint.y);
    }
    else{
        NSLog(@"Not Matched");
        self.center = CGPointMake(startCenterPoint.x, startCenterPoint.y);
    }
}

-(float) distanceFromPoint: (CGPoint) pPoint
{
    CGFloat dx= self.center.x - pPoint.x;
    CGFloat dy= self.center.y - pPoint.y;
    CGFloat distance= sqrt(dx*dx + dy*dy);
    NSLog(@"Distance is %f", distance);
    return distance;
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
