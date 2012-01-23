//
//  ApplicationContext.h
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationState1.h"
#import "ApplicationState2.h"
#import "ApplicationState3.h"

extern const struct GBNotifications {
	__unsafe_unretained NSString *contextDidPush;
	__unsafe_unretained NSString *state1DidStart;
	__unsafe_unretained NSString *state1DidEnd;
	__unsafe_unretained NSString *state2DidStart;
	__unsafe_unretained NSString *state2DidEnd;
	__unsafe_unretained NSString *state3DidStart;
	__unsafe_unretained NSString *state3DidEnd;
} GBNotifications;

@interface ApplicationContext : NSObject

- (void)pushState:(ApplicationState *)state completionBlock:(StateCompletionBlock)handler;
- (void)executeState:(ApplicationState *)state completionBlock:(StateCompletionBlock)handler;

@property (nonatomic, strong) ApplicationState1 *state1;
@property (nonatomic, strong) ApplicationState2 *state2;
@property (nonatomic, strong) ApplicationState3 *state3;

@end
