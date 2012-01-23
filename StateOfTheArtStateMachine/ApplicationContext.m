//
//  ApplicationContext.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationContext.h"

const struct GBNotifications GBNotifications = {
	.contextDidPush = @"GBContextDidPushNotification",
	.state1DidStart = @"GBState1DidStartNotification",
	.state1DidEnd = @"GBState1DidEndNotification",
	.state2DidStart = @"GBState2DidStartNotification",
	.state2DidEnd = @"GBState2DidEndNotification",
	.state3DidStart = @"GBState3DidStartNotification",
	.state3DidEnd = @"GBState3DidEndNotification",
};

#pragma mark -

@interface ApplicationContext ()
@property (nonatomic, assign) dispatch_queue_t pushStatesQueue;
@end

#pragma mark -
@implementation ApplicationContext

@synthesize pushStatesQueue = _pushStatesQueue;
@synthesize state1 = _state1;
@synthesize state2 = _state2;
@synthesize state3 = _state3;

#pragma mark - Context implementation

- (void)pushState:(ApplicationState *)state completionBlock:(StateCompletionBlock)handler {
	NSLog(@"Pushing state %@...", state);
	__block ApplicationContext *blockSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center postNotificationName:GBNotifications.contextDidPush object:blockSelf];
	});
	dispatch_async(self.pushStatesQueue, ^{
		NSLog(@"Executing state %@ from push queue...", state);
		[blockSelf executeState:state completionBlock:handler];
	});
}

- (void)executeState:(ApplicationState *)state completionBlock:(StateCompletionBlock)handler {
	NSLog(@"Executing state %@...", state);
	// Setup the state before executing it if needed - for example pass it parameters etc., nothing to do in this simple example.
	[state executeWithCompletionBlock:^{
		// Perform any cleanup necessary for you application needs, nothing to do in this simple example.
		if (handler) handler();
	}];
}

#pragma mark - States initialization

- (ApplicationState1 *)state1 {
	if (_state1) return _state1;
	_state1 = [[ApplicationState1 alloc] init];
	return _state1;
}

- (ApplicationState2 *)state2 {
	if (_state2) return _state2;
	_state2 = [[ApplicationState2 alloc] init];
	return _state2;
}

- (ApplicationState3 *)state3 {
	if (_state3) return _state3;
	_state3 = [[ApplicationState3 alloc] init];
	return _state3;
}

#pragma mark - Push queue handling

- (dispatch_queue_t)pushStatesQueue {
	if (_pushStatesQueue) return _pushStatesQueue;
	_pushStatesQueue = dispatch_queue_create("com.mycompany.myapplication.context", NULL);
	return _pushStatesQueue;
}

@end
