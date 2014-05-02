//
//  Match.m
//  MatchBox
//
//  Created by Matthew McHugh on 5/1/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "Match.h"

@implementation Match

@synthesize personOne;
@synthesize personTwo;
@synthesize matchText;
@synthesize createDate;
@synthesize createUser;

-(id) initWithPersonOne: (FBFriend *) pPersonOne andPersonTwo: (FBFriend *) pPersonTwo
{
    self.personOne = pPersonOne;
    self.personTwo = pPersonTwo;
    return self;
}

@end
