//
//  MatchBox.h
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBFriendsList.h"
#import "FBFriend.h"

@interface MatchBox : NSObject
{
    
}

@property NSMutableArray *matchboxFriends;
@property FBFriendsList *userFriendList;

-(void) generateMatchBox;
-(id) initWithFriendsList: (FBFriendsList *) list;

@end
