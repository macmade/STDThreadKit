/*******************************************************************************
 * The MIT License (MIT)
 * 
 * Copyright (c) 2017 Jean-David Gadina - www.xs-labs.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

#ifndef __has_feature
#define __has_feature( _x_ ) 0
#endif

#if __has_feature( modules )
@import Foundation;
#else
#import <Foundation/Foundation.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 * Objective-C wrapper class for C++ `std::thread`
 */
@interface STDThread: NSObject

/**
 * Designated initializer.
 * 
 * Note that initializing a `STDThread` object will launch a new thread
 * immediately.
 * 
 * @param       closure     The closure/block to execute in the new thread.
 * @returns     The initialized instance.
 */
- ( instancetype )initWithClosure: ( void ( ^ )( void ) )closure NS_DESIGNATED_INITIALIZER;

/**
 * Whether the thread is joinable.
 */
@property( nonatomic, readonly ) BOOL joinable;

/**
 * The number of concurrent threads supported by the implementation.
 * The value should be considered only a hint.
 */
@property( class, nonatomic, readonly ) unsigned int hardwareConcurrency;

/**
 * Waits for a thread to finish its execution.
 * 
 * @param       error   An optional error object indicating any error upon
 *                      return.
 * @returns     YES if the thread was successcvully joined, otherwise NO.
 */
- ( BOOL )join: ( NSError * __autoreleasing * _Nullable )error;

/**
 * Permits the thread to execute independently from the thread handle.
 * 
 * @param       error   An optional error object indicating any error upon
 *                      return.
 * @returns     YES if the thread was successcvully detached, otherwise NO.
 */
- ( BOOL )detach: ( NSError * __autoreleasing * _Nullable )error;

@end

NS_ASSUME_NONNULL_END
