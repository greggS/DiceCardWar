//
//  DiceController.m
//  CardWar
//
//  Created by Marcin Mycek on 24/07/14.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "DiceController.h"
#import <DicePlus/DicePlus.h>


@interface DiceController () <DPDiceManagerDelegate, DPDieDelegate> {
    DPDiceManager* diceManager;
    DPDie* dice;
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
    }
    
    return self;
}

#pragma mark DICE+ delegates
-(void)die:(DPDie *)die didRoll:(DPRoll *)roll error:(NSError *)error {
    
    NSLog(@"Good and bad rolls: %i", roll.result);
    // Checking for good rolls
    if (roll.flags == DPRollFlagOK) {
        NSLog(@"Good rolls: %i", roll.result);
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
}

-(void)dieFailedAuthorization:(DPDie *)die error:(NSError *)error {}
-(void)diceManagerStoppedScan:(DPDiceManager *)manager {}
-(void)centralManagerDidUpdateState:(CBCentralManagerState)state {}
-(void)diceManager:(DPDiceManager *)manager didConnectDie:(DPDie *)die {}
-(void)diceManager:(DPDiceManager *)manager didDisconnectDie:(DPDie *)die error:(NSError *)error {}
-(void)diceManager:(DPDiceManager *)manager failedConnectingDie:(DPDie *)die error:(NSError *)error {}

@end
