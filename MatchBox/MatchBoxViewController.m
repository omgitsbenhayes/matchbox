//
//  MatchBoxController.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/5/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "MatchBoxViewController.h"

@interface MatchBoxViewController ()
@property (weak, nonatomic) IBOutlet DraggableObject *upperLeftFriend;
@property (weak, nonatomic) IBOutlet DraggableObject *upperRightFriend;
@property (weak, nonatomic) IBOutlet DraggableObject *lowerLeftFriend;
@property (weak, nonatomic) IBOutlet DraggableObject *lowerRightFriend;
@property (weak, nonatomic) IBOutlet UILabel *upperLeftFriendText;
@property (weak, nonatomic) IBOutlet UILabel *upperRightFriendText;
@property (weak, nonatomic) IBOutlet UILabel *lowerLeftFriendText;
@property (weak, nonatomic) IBOutlet UILabel *lowerRightFriendText;
@property (weak, nonatomic) IBOutlet UIView *matchboxView;

@end

@implementation MatchBoxViewController

@synthesize friendsList;
@synthesize leftFilled;
@synthesize rightFilled;
@synthesize leftMatchCenterPoint;
@synthesize rightMatchCenterPoint;
@synthesize leftFriend;
@synthesize rightFriend;
@synthesize theMatch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //NSLog(@"Friends in  MBVC: %i", [friendsList.fbFriendsList count]);
    
    //Generate the matchbox
    self.matchboxView.layer.borderColor = [UIColor grayColor].CGColor;
    self.matchboxView.layer.borderWidth = 2.0f;
    self.matchboxView.backgroundColor = [UIColor clearColor];
    
    //Add the matchbox logo to the matchbox
    UILabel *matchboxLogo = [[UILabel alloc]init];
    matchboxLogo.center = self.matchboxView.center;
    matchboxLogo.text = @"matchbox";
    matchboxLogo.textAlignment = NSTextAlignmentCenter;
    matchboxLogo.font = [UIFont fontWithName:@"ArialMT" size:24.0f];
    matchboxLogo.textColor = [UIColor grayColor];
    matchboxLogo.frame = self.matchboxView.bounds;
    [self.matchboxView addSubview:matchboxLogo];
    
    //Generate the matchbox and set the images to the four friends
    MatchBox *mb = [[MatchBox alloc] initWithFriendsList:friendsList];
    [mb generateMatchBox];
    NSMutableArray* mbList = mb.matchboxFriends;
    FBFriend* friendOne = [mbList objectAtIndex:0];
    FBFriend* friendTwo = [mbList objectAtIndex:1];
    FBFriend* friendThree = [mbList objectAtIndex:2];
    FBFriend* friendFour = [mbList objectAtIndex:3];
    /*[self setImageOfFriend:friendOne ToView:self.upperLeftFriend WithLabel:self.upperLeftFriendText];
    [self setImageOfFriend:friendTwo ToView:self.upperRightFriend WithLabel:self.upperRightFriendText];
    [self setImageOfFriend:friendThree ToView:self.lowerLeftFriend WithLabel:self.lowerLeftFriendText];
    [self setImageOfFriend:friendFour ToView:self.lowerRightFriend WithLabel:self.lowerRightFriendText];*/
    
    self.upperLeftFriend.theFBFriend = friendOne;
    [self.upperLeftFriend setFBFriendImage];
    self.upperRightFriend.theFBFriend = friendTwo;
    [self.upperRightFriend setFBFriendImage];
    self.lowerLeftFriend.theFBFriend = friendThree;
    [self.lowerLeftFriend setFBFriendImage];
    self.lowerRightFriend.theFBFriend = friendFour;
    [self.lowerRightFriend setFBFriendImage];
    
    
    //Pass the MBVC to the Draggable images
    self.upperLeftFriend.theMatchBoxViewController = self;
    self.upperRightFriend.theMatchBoxViewController = self;
    self.lowerLeftFriend.theMatchBoxViewController = self;
    self.lowerRightFriend.theMatchBoxViewController = self;
    
    //Set the right-filled and left-filled booleans to NO
    self.leftFilled = NO;
    self.rightFilled = NO;
    
    //Set the center points of the match locations
    CGFloat x = self.matchboxView.frame.origin.x;
    CGFloat y = self.matchboxView.frame.origin.y;
    CGFloat width = self.matchboxView.frame.size.width;
    CGFloat height = self.matchboxView.frame.size.height;
    CGFloat quarterWidth = width / 4.0f;
    CGFloat halfHeight = height / 2.0f;
    CGFloat leftX = x + quarterWidth;
    CGFloat rightX = x + (3*quarterWidth);
    CGFloat leftY = y + halfHeight;
    CGFloat rightY = y + halfHeight;
    self.leftMatchCenterPoint = CGPointMake(leftX, leftY);
    self.rightMatchCenterPoint = CGPointMake(rightX, rightY);
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLeft: (FBFriend*) pFBFriend
{
    leftFriend = pFBFriend;
    leftFilled = YES;
}

- (void)setRight: (FBFriend*) pFBFriend
{
    rightFriend = pFBFriend;
    rightFilled = YES;
}

- (BOOL)matchMadeByUser
{
    if (leftFilled && rightFilled) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)createMatch
{
    theMatch = [[Match alloc] init];
    theMatch.personOne = self.leftFriend;
    theMatch.personTwo = self.rightFriend;
    [theMatch displayNamesOfMatchedIndividuals];
}

- (void)newMatchbox
{
    
}

/*
- (void)setImageOfFriend: (FBFriend*) aFriend ToView: (UIView*) aView WithLabel: (UILabel*) pLabel
{
    NSURL *imgUrl=[[NSURL alloc] initWithString:aFriend.fbPhoto];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *img = [UIImage imageWithData:imgData];
    
    //Resize image to size of the view
    img = [self imageWithImage:img scaledToSize:(CGSizeMake(aView.frame.size.width, aView.frame.size.height))];
    
    //Set the resized image to the view
    aView.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
    
    //Clear the label text
    pLabel.text = @"";
    
    //Set the gradient background of the label using a gradient layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = pLabel.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor]CGColor], (id)[[UIColor blackColor]CGColor], nil];
    [pLabel.layer insertSublayer:gradientLayer below:pLabel.layer];
    
    //Set the friend's name to the label using a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    UIFont *textFont = [UIFont fontWithName:@"ArialMT" size:12.0f];
    CGFloat offset = textFont.capHeight - textFont.xHeight;
    //NSLog(@"%f - %f = %f", textFont.capHeight, textFont.xHeight, offset);
    [textLayer setFrame:CGRectMake(pLabel.bounds.origin.x, pLabel.bounds.origin.y + offset, pLabel.bounds.size.width, pLabel.bounds.size.height - offset)];
    //[textLayer setFrame:pLabel.bounds];
    [textLayer setString:aFriend.name];
    [textLayer setFont:(__bridge CFTypeRef)textFont];
    [textLayer setFontSize:12];
    [textLayer setForegroundColor:[[UIColor whiteColor]CGColor]];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    
    //Set scaling so that the text is not blurry
    [textLayer setContentsScale:[[UIScreen mainScreen]scale]];
    
    //Add the text layer on top of the gradient layer
    [pLabel.layer insertSublayer:textLayer above:gradientLayer];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
 
 */

@end
