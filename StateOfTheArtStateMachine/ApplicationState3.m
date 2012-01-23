//
//  ApplicationState3.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationContext.h"
#import "ApplicationState3.h"

@implementation ApplicationState3

- (void)executeWithCompletionBlock:(StateCompletionBlock)handler {
	__block ApplicationState3 *blockSelf = self;
	dispatch_queue_t queue = dispatch_queue_create("com.mycompany.myapplication.state1", NULL);
	dispatch_async(queue, ^{
		[blockSelf postNotificationName:GBNotifications.state3DidStart];
		
		[NSThread sleepForTimeInterval:1.0];
		
		[blockSelf postNotificationName:GBNotifications.state3DidEnd];
		
		dispatch_release(queue);
		if (handler) handler();
	});
}

@end
