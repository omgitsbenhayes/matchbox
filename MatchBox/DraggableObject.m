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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setCenter:(CGPoint)center
{
    self.startCenterPoint = center;
    NSLog(@"Center Point Set");
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
