//
//  ApplicationState.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationState.h"

@implementation ApplicationState

- (void)executeWithCompletionBlock:(StateCompletionBlock)handler {
	NSAssert(NO, @"Subclass must override and implement required behavior then invoke the given block when done!");
}

- (void)postNotificationName:(NSString *)name {
	dispatch_async(dispatch_get_main_queue(), ^{
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center postNotificationName:name object:self];
	});
}

@end
