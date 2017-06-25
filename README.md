STDThreadKit
============

[![Build Status](https://img.shields.io/travis/macmade/STDThreadKit.svg?branch=master&style=flat)](https://travis-ci.org/macmade/STDThreadKit)
[![Coverage Status](https://img.shields.io/coveralls/macmade/STDThreadKit.svg?branch=master&style=flat)](https://coveralls.io/r/macmade/STDThreadKit?branch=master)
[![Issues](http://img.shields.io/github/issues/macmade/STDThreadKit.svg?style=flat)](https://github.com/macmade/STDThreadKit/issues)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg?style=flat)
![License](https://img.shields.io/badge/license-mit-brightgreen.svg?style=flat)
[![Contact](https://img.shields.io/badge/contact-@macmade-blue.svg?style=flat)](https://twitter.com/macmade)  
[![Donate-Patreon](https://img.shields.io/badge/donate-patreon-yellow.svg?style=flat)](https://patreon.com/macmade)
[![Donate-Gratipay](https://img.shields.io/badge/donate-gratipay-yellow.svg?style=flat)](https://www.gratipay.com/macmade)
[![Donate-Paypal](https://img.shields.io/badge/donate-paypal-yellow.svg?style=flat)](https://paypal.me/xslabs)

C++ `std::thread` API for Swift
-------------------------------

### Documentation

Documentation and API reference can be found at: http://doc.xs-labs.com/STDThreadKit/

### Rationale

Swift has several APIs to execute threads, or concurrent tasks.

#### DispatchQueues

**The obvious and recommended approach is to use [`DispatchQueue`](https://developer.apple.com/documentation/dispatch/dispatchqueue).**  
This is usually how you should deal with concurrent tasks in Swift.

However, using `DispatchQueue` **doesn't always guarantee** your task will be executed in a separated thread.

Take a look at the following example, assuming we're currently on the main queue:

```swift
DispatchQueue.global( qos: .userInitiated ).sync
{}
```
    
You might think that your code will be executed on the specified global queue, and that the main queue will wait until completion before resuming execution.

But actually, as we called `sync`, `DispatchQueue` is **clever enough** to see there's no reason to execute the closure on the global queue, and will simply execute it from the main queue.

As stated in the documentation for [sync](https://developer.apple.com/documentation/dispatch/dispatchqueue/1452870-sync):

> As an optimization, this function invokes the block on the current thread when possible.

While this is absolutely great, and leads to less overheads, you sometimes want **real threads**.

#### NSThread

The other approach is to use the good old Objective-C's [`NSThread`](https://developer.apple.com/documentation/foundation/nsthread?language=objc) API, exposed as [`Thread`](https://developer.apple.com/documentation/foundation/thread) in Swift.

Unfortunately, `NSThread` can be **a pain when it comes to synchronization**, as there's no way to join a thread.

#### C++11 threads

Since C++11, the C++ standard library supports threads, using `std::stread`.  
The API is very simple, but still efficient and complete, as threads can be **detached or joined very easily**.

But as it's C++, there's unfortunately no way to use them directly from Swift.

STDThreadKit
------------

**STDThreadKit** solves these issues by exposing a Swift API for `std::thread`:

```swift
open class STDThread: NSObject
{
    open class var hardwareConcurrency: UInt32 { get }
    
    public init( closure: @escaping () -> Swift.Void )
    
    open var joinable: Bool { get }
    
    open func join()   throws
    open func detach() throws
}
```

Meaning you can easily use the C++ `std::thread` API from Swift, like:

```swift
import Foundation
import STDThreadKit

var foo    = false
let thread = STDThread
{
    sleep( 1 )
    
    foo = true
}

thread.join()

```

License
-------

**STDThreadKit** is released under the terms of the MIT license.

Repository Infos
----------------

    Owner:          Jean-David Gadina - XS-Labs
    Web:            www.xs-labs.com
    Blog:           www.noxeos.com
    Twitter:        @macmade
    GitHub:         github.com/macmade
    LinkedIn:       ch.linkedin.com/in/macmade/
    StackOverflow:  stackoverflow.com/users/182676/macmade
