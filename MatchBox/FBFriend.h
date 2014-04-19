//
//  FBFriend.h
//  MatchBox
//
//  Created by Matthew McHugh on 4/13/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFriend : NSObject
{
    
}

@property NSString *name;
@property NSString *fbID;
@property NSString *fbPhoto;
@property int userID;

-(id) initWithName: (NSString *) friendName andFBID: (NSString *) friendFBID andFBPhoto: (NSString*) friendFBPhoto;

@end
