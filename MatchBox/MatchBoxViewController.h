//
//  MatchBoxController.h
//  MatchBox
//
//  Created by Matthew McHugh on 4/5/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FBFriendsList.h"
#import "MatchBox.h"
#import "FBFriend.h"
#import "DraggableObject.h"
#import "Match.h"

@interface MatchBoxViewController : UIViewController

@property FBFriendsList *friendsList;
@property BOOL leftFilled;
@property BOOL rightFilled;
@property CGPoint leftMatchCenterPoint;
@property CGPoint rightMatchCenterPoint;
@property FBFriend *leftFriend;
@property FBFriend *rightFriend;
@property Match *theMatch;

//- (void)setImageOfFriend: (FBFriend*)aFriend ToView: (UIView*) aView WithLabel: (UILabel*) pLabel;
//-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
- (void)setLeft: (FBFriend*) pFBFriend;
- (void)setRight: (FBFriend*) pFBFriend;
- (BOOL)matchMadeByUser;
- (void)createMatch;

@end
