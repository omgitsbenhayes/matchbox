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
@synthesize theFBFriend;

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
    
    if (theMatchBoxViewController.leftFilled == NO && [self distanceFromPoint:theMatchBoxViewController.leftMatchCenterPoint] < 70.0f) {
        NSLog(@"Left Match");
        [theMatchBoxViewController setLeft:theFBFriend];
        self.center = CGPointMake(theMatchBoxViewController.leftMatchCenterPoint.x, theMatchBoxViewController.leftMatchCenterPoint.y);
        if ([theMatchBoxViewController matchMadeByUser]) {
            [theMatchBoxViewController createMatch];
        }
    }
    else if (theMatchBoxViewController.rightFilled == NO && [self distanceFromPoint:theMatchBoxViewController.rightMatchCenterPoint] < 70.0f) {
        NSLog(@"Right Match");
        [theMatchBoxViewController setRight:theFBFriend];
        self.center = CGPointMake(theMatchBoxViewController.rightMatchCenterPoint.x, theMatchBoxViewController.rightMatchCenterPoint.y);
        if ([theMatchBoxViewController matchMadeByUser]) {
            [theMatchBoxViewController createMatch];
        }
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

-(void) setFBFriendImage
{
    NSURL *imgUrl=[[NSURL alloc] initWithString:theFBFriend.fbPhoto];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *img = [UIImage imageWithData:imgData];
    
    //Resize image to size of the view
    img = [self imageWithImage:img scaledToSize:(CGSizeMake(self.frame.size.width, self.frame.size.height))];
    
    //Set the resized image to the view
    self.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
    
    //Generate the frame of the name label
    CGFloat nameLabelWidth = self.bounds.size.width;
    CGFloat nameLabelHeight = 20.0f;
    CGFloat nameLabelX = 0.0f;
    CGFloat nameLabelY = (self.bounds.size.height - nameLabelHeight);
    
    //Create and add the name label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelWidth, nameLabelHeight)];
    [self addSubview:nameLabel];
    
    //Clear the label text
    nameLabel.text = @"";
    
    //Set the gradient background of the label using a gradient layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = nameLabel.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor]CGColor], (id)[[UIColor blackColor]CGColor], nil];
    [nameLabel.layer insertSublayer:gradientLayer below:nameLabel.layer];
    
    //Set the friend's name to the label using a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    UIFont *textFont = [UIFont fontWithName:@"ArialMT" size:12.0f];
    CGFloat offset = textFont.capHeight - textFont.xHeight;
    //NSLog(@"%f - %f = %f", textFont.capHeight, textFont.xHeight, offset);
    [textLayer setFrame:CGRectMake(nameLabel.bounds.origin.x, nameLabel.bounds.origin.y + offset, nameLabel.bounds.size.width, nameLabel.bounds.size.height - offset)];
    //[textLayer setFrame:pLabel.bounds];
    [textLayer setString:theFBFriend.name];
    [textLayer setFont:(__bridge CFTypeRef)textFont];
    [textLayer setFontSize:12];
    [textLayer setForegroundColor:[[UIColor whiteColor]CGColor]];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    
    //Set scaling so that the text is not blurry
    [textLayer setContentsScale:[[UIScreen mainScreen]scale]];
    
    //Add the text layer on top of the gradient layer
    [nameLabel.layer insertSublayer:textLayer above:gradientLayer];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
