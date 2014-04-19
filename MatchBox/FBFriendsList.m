//
//  FBFriendsList.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "FBFriendsList.h"

@implementation FBFriendsList

@synthesize fbFriendsList;

-(id)init
{
    fbFriendsList = [[NSMutableArray alloc] init];
    return self;
}

-(void) addFriendToList: (FBFriend *) friend
{
    [fbFriendsList addObject:friend];
}

-(void) removeFriendFromList: (FBFriend *) friend
{
    [fbFriendsList removeObject:friend];
}

@end
