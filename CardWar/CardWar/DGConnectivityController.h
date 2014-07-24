//
//  DGConnectivityController.h
//  CardWar
//
//  Created by Grzegorz Krukiewicz-Gacek on 24.07.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface DGConnectivityController : NSObject <MCSessionDelegate>

@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;

- (void)setupPeerAndSessionWithDisplayName:(NSString *)displayName;
- (void)setupMCBrowser;
- (void)advertiseSelf:(BOOL)shouldAdvertise;

@end
