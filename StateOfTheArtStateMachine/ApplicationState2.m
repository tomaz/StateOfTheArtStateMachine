//
//  ApplicationState2.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationContext.h"
#import "ApplicationState2.h"

@implementation ApplicationState2

- (void)executeWithCompletionBlock:(StateCompletionBlock)handler {
	__block ApplicationState2 *blockSelf = self;
	dispatch_queue_t queue = dispatch_queue_create("com.mycompany.myapplication.state1", NULL);
	dispatch_async(queue, ^{
		[blockSelf postNotificationName:GBNotifications.state2DidStart];
		
		[NSThread sleepForTimeInterval:2.0];
		
		[blockSelf postNotificationName:GBNotifications.state2DidEnd];
		
		dispatch_release(queue);
		if (handler) handler();
	});
}

@end
