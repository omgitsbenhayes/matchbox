//
//  DraggableObject.h
//  MatchBox
//
//  Created by Matthew McHugh on 5/2/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchBoxViewController.h"
#import "FBFriend.h"

@class MatchBoxViewController;
@interface DraggableObject : UIView

@property CGPoint startPoint;
@property CGPoint newPoint;
@property CGPoint startCenterPoint;
@property MatchBoxViewController *theMatchBoxViewController;
@property FBFriend *theFBFriend;

-(void) setFBFriendImage;
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
