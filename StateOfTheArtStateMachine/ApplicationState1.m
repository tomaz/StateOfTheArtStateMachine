//
//  ApplicationState1.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationContext.h"
#import "ApplicationState1.h"

@implementation ApplicationState1

- (void)executeWithCompletionBlock:(StateCompletionBlock)handler {
	__block ApplicationState1 *blockSelf = self;
	dispatch_queue_t queue = dispatch_queue_create("com.mycompany.myapplication.state1", NULL);
	dispatch_async(queue, ^{
		[blockSelf postNotificationName:GBNotifications.state1DidStart];
		
		[NSThread sleepForTimeInterval:3.0];
		
		[blockSelf postNotificationName:GBNotifications.state1DidEnd];
		
		dispatch_release(queue);
		if (handler) handler();
	});
}

@end
