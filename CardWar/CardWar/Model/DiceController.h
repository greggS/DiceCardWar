//
//  DiceController.h
//  CardWar
//
//  Created by Marcin Mycek on 24/07/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DiceControllerDelegate <NSObject>

- (void)didDetectRoll:(int)roll;

@end

@interface DiceController : NSObject

@property (nonatomic, weak) id<DiceControllerDelegate> delegate;

@property (nonatomic) bool shouldUpdateOnRolls;

- (void) signalFirstPlayerWin;
- (void) signalSecondPlayerWin;

@end
