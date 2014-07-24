//
//  DGCard.h
//  CardWar
//
//  Created by Grzegorz Krukiewicz-Gacek on 24.07.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int
{
    Two = 2,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Jack,
    Queen,
    King,
    Ace
} CardType;

typedef enum : int
{
    Heart = 0,
    Spades,
    Club,
    Dimonds
} CardColor;

@interface DGCard : NSObject <NSCoding>

@property (nonatomic, assign) CardType type;
@property (nonatomic, assign) CardColor color;

- (instancetype)initWithType:(CardType)type andColor:(CardColor)color;

@end
