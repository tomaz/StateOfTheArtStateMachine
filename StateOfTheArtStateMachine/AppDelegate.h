//
//  AppDelegate.h
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (IBAction)pushStates1To3:(id)sender;
- (IBAction)pushStates1And3:(id)sender;
- (IBAction)pushState2:(id)sender;

@property (weak) IBOutlet NSTextField *messagesTextField;
@property (assign) IBOutlet NSWindow *window;

@end
