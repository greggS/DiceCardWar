//
//  DGCardShuffler.h
//  CardWar
//
//  Created by Grzegorz Krukiewicz-Gacek on 24.07.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIRST_USER_CARDS_KEY    @"fuck"
#define SECOND_USER_CARDS_KEY   @"suck"

@interface DGCardShuffler : NSObject

+ (NSDictionary *)shuffledCardSets;

@end
