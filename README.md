PhysicalKeyboardNotifications
=============================

An easy way to receive notifications on iPhone simulator when physical keyboard is pressed. 
Useful for debugging or playing with the interface and application logic directly from the keyboard.

Based on the idea from: https://github.com/cloudkite/Commando

Installation
============
Using Cocoapods, just add to your Podfile:
<pre>
pod 'PhysicalKeyboardNotifications'
</pre>

Dependencies
============
JRSwizzle - https://github.com/rentzsch/jrswizzle

Usage
=============
- Install using Cocapods or adding the files directly into your proyect
- Add to your <code>.pch</code> the file <code>PhysicalKeyboardNotifications.h</code>
- Add as observer for PKNKeyUpNotification or PKNKeyDownNotification
<pre>
[[NSNotificationCenter defaultCenter] addObserver:self  
                                                 selector:@selector(onKeyboardKeyDownNotification:)  
                                                     name:PKNKeyDownNotification  
                                                   object:nil];  
</pre>

- In the notification observer method recover from userInfo dictionary the pressed keyValue or a NSString representing the char

<pre>
- (void)onKeyboardKeyDownNotification:(NSNotification*)notification
{
    PKNKeyInputCode keyCode = [notification.userInfo[PKNKeyInputCodeNotificationUserInfoKey] shortValue];
    NSString *keyChar = notification.userInfo[PKNKeyInputCharNotificationUserInfoKey];
    NSLog(@"KEY UP: %hd, CHAR: %@", keyCode, keyChar);
}
</pre>

- Special keys as space, return, delete or arrows will return and empty string in the key <code>PKNKeyInputCharNotificationUserInfoKey</code>
but don't panic there are several macro defined values to compare their keyCodes in <code>PkNDefines.h</code>



