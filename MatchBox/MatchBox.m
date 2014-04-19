//
//  MatchBox.m
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "MatchBox.h"

@implementation MatchBox

@synthesize matchboxFriends;
@synthesize userFriendList;

-(id) initWithFriendsList: (FBFriendsList *) list{
    //NSLog(@"Count of passed list: %d", [list.fbFriendsList count]);
    self.userFriendList = list;
    return self;
}

-(void) generateMatchBox
{
    int friendCount = [self.userFriendList.fbFriendsList count];
    //NSLog(@"Friend Count: %d", friendCount);
    NSMutableArray *positionsUsed = [[NSMutableArray alloc] init];
    matchboxFriends = [[NSMutableArray alloc] init];
    if(friendCount >= 4){
        for (int i =0; i < 4; i++) {
            //generate random number
            int randomNum = (arc4random() % friendCount);
            NSLog(@"Random Number is %i", randomNum);
            if ([positionsUsed count] < 1) {
                FBFriend *friend = [[FBFriend alloc] init];
                friend = [userFriendList.fbFriendsList objectAtIndex:randomNum];
                [matchboxFriends addObject:friend];
                NSLog(@"%@: %@ added to MatchBox", friend.fbID, friend.name);
            }
            else{
                for (int x = 0; x < [positionsUsed count]; x++) {
                    // check if randomly generated number has already been used
                    int numAtIndex = (int) [positionsUsed objectAtIndex:x];
                    BOOL duplicate = YES;
                    while (duplicate) {
                        if (randomNum == numAtIndex) {
                            NSLog(@"Number %d already in use", randomNum);
                            duplicate = YES;
                        }
                        else{
                            duplicate = NO;
                            FBFriend *friend = [[FBFriend alloc] init];
                            friend = [userFriendList.fbFriendsList objectAtIndex:randomNum];
                            [matchboxFriends addObject:friend];
                            NSLog(@"%@: %@ added to MatchBox", friend.fbID, friend.name);
                        }
                    }
                }
            }
            
        }
    }
    else{
        NSLog(@"You have less than 4 friends");
    }
}

@end
