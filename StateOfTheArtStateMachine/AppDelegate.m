//
//  AppDelegate.m
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationContext.h"
#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSMutableString *messages;
@property (nonatomic, strong) ApplicationContext *applicationContext;
@end

#pragma mark -

@implementation AppDelegate

@synthesize window = _window;
@synthesize messagesTextField = _messagesTextField;
@synthesize messages = _messages;
@synthesize applicationContext = _applicationContext;

#pragma mark - Initialization & disposal

- (id)init {
	self = [super init];
	if (self) {
		self.messages = [NSMutableString string];
	}
	return self;
}

#pragma mark - Application lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	__block AppDelegate *blockSelf = self;
	
	// Hook up all model notifications - no need to cleanup as this will remain active until the app terminates...
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserverForName:GBNotifications.contextDidPush object:nil queue:nil usingBlock:^(NSNotification *note) {
		[blockSelf.messages appendString:@"--- Pushed state!\n"];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];
	
	__block NSUInteger state1Count = 0;
	[center addObserverForName:GBNotifications.state1DidStart object:nil queue:nil usingBlock:^(NSNotification *note) {
		state1Count++;
		[blockSelf.messages appendFormat:@"State 1 did start (%lu)\n", state1Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];
	[center addObserverForName:GBNotifications.state1DidEnd object:nil queue:nil usingBlock:^(NSNotification *note) {
		[blockSelf.messages appendFormat:@"State 1 did end (%lu)\n", state1Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];

	__block NSUInteger state2Count = 0;
	[center addObserverForName:GBNotifications.state2DidStart object:nil queue:nil usingBlock:^(NSNotification *note) {
		state2Count++;
		[blockSelf.messages appendFormat:@"State 2 did start (%lu)\n", state2Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];
	[center addObserverForName:GBNotifications.state2DidEnd object:nil queue:nil usingBlock:^(NSNotification *note) {
		[blockSelf.messages appendFormat:@"State 2 did end (%lu)\n", state2Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];

	__block NSUInteger state3Count = 0;
	[center addObserverForName:GBNotifications.state3DidStart object:nil queue:nil usingBlock:^(NSNotification *note) {
		state3Count++;
		[blockSelf.messages appendFormat:@"State 3 did start (%lu)\n", state3Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];
	[center addObserverForName:GBNotifications.state3DidEnd object:nil queue:nil usingBlock:^(NSNotification *note) {
		[blockSelf.messages appendFormat:@"State 3 did end (%lu)\n", state3Count];
		[blockSelf.messagesTextField setStringValue:blockSelf.messages];
	}];
	
	// Invoke default behavior on startup.
	ApplicationContext *context = self.applicationContext;
	[context pushState:context.state1 completionBlock:^{
		[context executeState:context.state2 completionBlock:^{
			[context executeState:context.state3 completionBlock:^{
			}];
		}];
	}];
}

#pragma mark - User actions

- (IBAction)pushStates1To3:(id)sender {
	NSLog(@"User pressed push states 1-3 button!");
	ApplicationContext *context = self.applicationContext;
	[context pushState:context.state1 completionBlock:^{
		[context executeState:context.state2 completionBlock:^{
			[context executeState:context.state3 completionBlock:^{
			}];
		}];
	}];
}

- (IBAction)pushStates1And3:(id)sender {
	NSLog(@"User pressed push states 1 & 3 button!");
	ApplicationContext *context = self.applicationContext;
	[context pushState:context.state1 completionBlock:^{
		[context executeState:context.state3 completionBlock:^{
		}];
	}];
}

- (IBAction)pushState2:(id)sender {
	NSLog(@"User pressed push state 2 button!");
	ApplicationContext *context = self.applicationContext;
	[context pushState:context.state2 completionBlock:^{
	}];
}

#pragma mark - Properties

- (ApplicationContext *)applicationContext {
	if (_applicationContext) return _applicationContext;
	_applicationContext = [[ApplicationContext alloc] init];
	return _applicationContext;
}

@end
