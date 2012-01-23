//
//  ApplicationState.h
//  StateOfTheArtStateMachine
//
//  Created by Tomaž Kragelj on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StateCompletionBlock)(void);

@interface ApplicationState : NSObject

// Used by ApplicationContext, no need to invoke manually!
- (void)executeWithCompletionBlock:(StateCompletionBlock)handler;

// User by subclasses.
- (void)postNotificationName:(NSString *)name;

@end
