//
//  DiceController.m
//  CardWar
//
//  Created by Marcin Mycek on 24/07/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "DiceController.h"
#import <DicePlus/DicePlus.h>
#define ON_PERIOD 200
#define CYCLE_PERIOD 200
#define BLINK_COUNT 5


@interface DiceController () <DPDiceManagerDelegate, DPDieDelegate> {
    DPDiceManager* diceManager;
    DPDie* dice;
    BOOL shouldSignalWinner;
    BOOL shouldSignalFirstPlayer;
    BOOL diceIsAvailableForAnimation;
}

@end

@implementation DiceController

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        uint8_t key[8] = {0x83, 0xed, 0x60, 0x0e, 0x5d, 0x31, 0x8f, 0xe7};
        
        diceManager = [DPDiceManager sharedDiceManager];
        diceManager.delegate = self;
        
        [diceManager setKey:key];
        [diceManager startScan];
        
        shouldSignalWinner = false;
        diceIsAvailableForAnimation = false;
    }
    
    return self;
}

-(void) signalFirstPlayerWin {
    if (diceIsAvailableForAnimation)
        [self lightDiceTeal];
    else
    {
        shouldSignalWinner = true;
        shouldSignalFirstPlayer = true;
    }
}

-(void) signalSecondPlayerWin {
    if (diceIsAvailableForAnimation)
        [self lightDiceYellow];
    else
    {
        shouldSignalWinner = true;
        shouldSignalFirstPlayer = false;
    }
}

-(void) lightDiceTeal {
    [dice startBlinkAnimationWithMask:63
                             priority:1
                                    r:0
                                    g:255
                                    b:255
                             onPeriod:ON_PERIOD
                          cyclePeriod:CYCLE_PERIOD
                           blinkCount:BLINK_COUNT];
}
-(void) lightDiceYellow {
    [dice startBlinkAnimationWithMask:63
                             priority:1
                                    r:255
                                    g:255
                                    b:0
                             onPeriod:ON_PERIOD
                          cyclePeriod:CYCLE_PERIOD
                           blinkCount:BLINK_COUNT];
}



#pragma mark DICE+ delegates

-(void)die:(DPDie *)die didRoll:(DPRoll *)roll error:(NSError *)error {
    
    if ((self.delegate) && (self.shouldUpdateOnRolls))
    {
        if (roll.flags == DPRollFlagOK) {
            [self.delegate didDetectRoll:roll.result];
        }
    }
    [self signalFirstPlayerWin];

}

- (void)die:(DPDie *)die didChangeLedState:(DPLedState *)status error:(NSError *)error
{
    if (status.isFinished)
    {
        if (shouldSignalWinner)
        {
            if (shouldSignalFirstPlayer)
                [self lightDiceTeal];
            else
                [self lightDiceYellow];
            shouldSignalWinner = false;
        } else
        {
            diceIsAvailableForAnimation = true;
        }
    }
    else
    {
        diceIsAvailableForAnimation = false;
    }
}

-(void)diceManager:(DPDiceManager *)manager didDiscoverDie:(DPDie *)die {
    dice = die;
    
    die.delegate = self;
    [diceManager stopScan];
    [diceManager connectDie:dice];
}

-(void)dieConnected:(DPDie *)die {
    [dice startRollUpdates];
    [dice startLedStateUpdates];
}

-(void)dieFailedAuthorization:(DPDie *)die error:(NSError *)error {}
-(void)diceManagerStoppedScan:(DPDiceManager *)manager {}
-(void)centralManagerDidUpdateState:(CBCentralManagerState)state {}
-(void)diceManager:(DPDiceManager *)manager didConnectDie:(DPDie *)die {}
-(void)diceManager:(DPDiceManager *)manager didDisconnectDie:(DPDie *)die error:(NSError *)error {}
-(void)diceManager:(DPDiceManager *)manager failedConnectingDie:(DPDie *)die error:(NSError *)error {}

@end
