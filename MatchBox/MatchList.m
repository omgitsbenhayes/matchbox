//
//  MatchList.m
//  MatchBox
//
//  Created by Matthew McHugh on 5/2/14.
//  Copyright (c) 2014 KMB. All rights reserved.
//

#import "MatchList.h"

@implementation MatchList

@synthesize matchList;

-(void) addMatch: (Match*) pMatch
{
    [matchList addObject:pMatch];
}

@end
