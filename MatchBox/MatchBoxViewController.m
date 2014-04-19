//
//  MatchBoxController.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/5/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "MatchBoxViewController.h"

@interface MatchBoxViewController ()
@property (weak, nonatomic) IBOutlet UIView *upperLeftFriend;
@property (weak, nonatomic) IBOutlet UIView *upperRightFriend;
@property (weak, nonatomic) IBOutlet UIView *lowerLeftFriend;
@property (weak, nonatomic) IBOutlet UIView *lowerRightFriend;

@end

@implementation MatchBoxViewController

@synthesize friendsList;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Friends in  MBVC: %i", [friendsList.fbFriendsList count]);
    
    MatchBox *mb = [[MatchBox alloc] initWithFriendsList:friendsList];
    [mb generateMatchBox];
    NSMutableArray* mbList = mb.matchboxFriends;
    FBFriend* friendOne = [mbList objectAtIndex:0];
    FBFriend* friendTwo = [mbList objectAtIndex:1];
    FBFriend* friendThree = [mbList objectAtIndex:2];
    FBFriend* friendFour = [mbList objectAtIndex:3];
    [self setImageOfFriend:friendOne ToView:self.upperLeftFriend];
    [self setImageOfFriend:friendTwo ToView:self.upperRightFriend];
    [self setImageOfFriend:friendThree ToView:self.lowerLeftFriend];
    [self setImageOfFriend:friendFour ToView:self.lowerRightFriend];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImageOfFriend: (FBFriend*) aFriend ToView: (UIView*) aView
{
    NSURL *imgUrl=[[NSURL alloc] initWithString:aFriend.fbPhoto];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *img = [UIImage imageWithData:imgData];
    aView.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
}

@end
