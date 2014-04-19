//
//  FBFriend.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "FBFriend.h"

@implementation FBFriend

@synthesize name;
@synthesize fbID;
@synthesize fbPhoto;
@synthesize userID;

-(id) initWithName: (NSString *) friendName andFBID: (NSString *) friendFBID andFBPhoto: (NSString*) friendFBPhoto{
    self.name = friendName;
    self.fbID = friendFBID;
    self.fbPhoto = friendFBPhoto;
    return self;
}

@end
