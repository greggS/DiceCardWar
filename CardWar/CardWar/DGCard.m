//
//  DGCard.m
//  CardWar
//
//  Created by Grzegorz Krukiewicz-Gacek on 24.07.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "DGCard.h"

#define CARD_TYPE_KEY   @"ctk"
#define CARD_COLOR_KEY  @"cck"

@implementation DGCard

- (instancetype)initWithType:(CardType)type andColor:(CardColor)color
{
    self = [super init];
    
    if (self)
    {
        self.type = type;
        self.color = color;
    }
    
    return self;
}

#pragma mark - NSCoding protocol

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.type = [aDecoder decodeIntForKey:CARD_TYPE_KEY];
        self.color = [aDecoder decodeIntForKey:CARD_COLOR_KEY];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.type forKey:CARD_TYPE_KEY];
    [aCoder encodeInt:self.color forKey:CARD_COLOR_KEY];
}


@end
