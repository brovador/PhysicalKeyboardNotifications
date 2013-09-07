//
//  PKNCommandsManager.h
//  KeyboardCommands
//
//  Created by Jesús on 07/09/13.
//  Copyright (c) 2013 Jesús. All rights reserved.
//

#import "PKNDefines.h"

@interface PKNCommandsManager : NSObject

+ (instancetype)sharedManager;
- (void)handleKeyDown:(PKNKeyInputCode)key withEventFlags:(PKNEventFlags)flags;
- (void)handleKeyUp:(PKNKeyInputCode)key withEventFlags:(PKNEventFlags)flags;

@end
