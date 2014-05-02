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

@interface MatchBoxViewController : UIViewController

@property FBFriendsList *friendsList;

- (void)setImageOfFriend: (FBFriend*)aFriend ToView: (UIView*) aView WithLabel: (UILabel*) pLabel;
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
