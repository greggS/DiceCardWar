//
//  DGCardShuffler.m
//  CardWar
//
//  Created by Grzegorz Krukiewicz-Gacek on 24.07.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "DGCardShuffler.h"
#import "DGCard.h"

@implementation DGCardShuffler

+ (NSDictionary *)shuffledCardSets
{
    NSMutableArray *deck = [NSMutableArray array];
    
    for (int i = 2; i < 15; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            CardType type = (CardType)i;
            CardColor color = (CardColor)j;
            DGCard *card = [[DGCard alloc] initWithType:type andColor:color];
            
            [deck addObject:card];
        }
    }
    
    for (int i = [deck count] - 1; i > 0 ; i--)
    {
        int randomInt1 = arc4random_uniform(i + 1);
        [deck exchangeObjectAtIndex:randomInt1 withObjectAtIndex:i];
    }
    
    NSMutableArray *firstUserArray = [NSMutableArray array];
    NSMutableArray *secondUserArray = [NSMutableArray array];
    
    for (int i = 0; i < deck.count; i++)
    {
        if (i%2 == 0)
        {
            [firstUserArray addObject:[deck objectAtIndex:i]];
        }
        else
        {
            [secondUserArray addObject:[deck objectAtIndex:i]];
        }
    }
    
    return @{FIRST_USER_CARDS_KEY: [NSArray arrayWithArray:firstUserArray],
             SECOND_USER_CARDS_KEY : [NSArray arrayWithArray:secondUserArray]};
}

@end
