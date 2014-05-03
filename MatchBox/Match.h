//
//  Match.h
//  MatchBox
//
//  Created by Matthew McHugh on 5/1/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBFriend.h"

@interface Match : NSObject

@property FBFriend *personOne;
@property FBFriend *personTwo;
@property NSString *matchText;
@property NSString *createUser;
@property NSDate *createDate;

-(void) displayNamesOfMatchedIndividuals;

@end
