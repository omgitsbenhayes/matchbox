//
//  ViewController.h
//  MatchBox
//
//  Created by Matthew McHugh on 4/5/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFriendsList.h"
#import "FBFriend.h"
//#import "MatchBox.h"
#import "MatchBoxViewController.h"

@interface ViewController : UIViewController

@property FBFriendsList* friendsList;
@property BOOL firstTime;
@property BOOL friendsLoaded;

-(void) generateFriendsList: (NSArray *) list;

@end
