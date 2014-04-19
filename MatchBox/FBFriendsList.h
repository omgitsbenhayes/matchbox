//
//  FBFriendsList.h
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBFriend.h"

@interface FBFriendsList : NSObject
{
    
}

@property NSMutableArray *fbFriendsList;

-(void) addFriendToList: (FBFriend *) friend;
-(void) removeFriendFromList: (FBFriend *) friend;

@end
