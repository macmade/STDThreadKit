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

#import "STDThread.h"
#import <thread>
#import <system_error>

@interface STDThread()

@property( nonatomic, readwrite, assign ) std::thread * thread;

@end

@implementation STDThread

- ( instancetype )init
{
    return [ self initWithClosure: ^( void ) {} ];
}

- ( instancetype )initWithClosure: ( void ( ^ )( void ) )closure
{
    if( ( self = [ super init ] ) )
    {
        self.thread = new std::thread( [ = ] { closure(); } );
    }
    
    return self;
}

- ( void )dealloc
{
    try
    {
        self.thread->detach();
    }
    catch( ... )
    {
        delete self.thread;
    }
}

- ( BOOL )joinable
{
    return self.thread->joinable();
}

+ ( unsigned int )hardwareConcurrency
{
    return std::thread::hardware_concurrency();
}

- ( BOOL )join: ( NSError * __autoreleasing * )error
{
    try
    {
        self.thread->join();
    }
    catch( const std::system_error & e )
    {
        if( error != NULL )
        {
            *( error ) = [ NSError errorWithDomain: NSCocoaErrorDomain code: e.code().value() userInfo: @{ NSLocalizedDescriptionKey : [ NSString stringWithUTF8String: e.what() ] } ];
        }
        
        return NO;
    }
    
    return YES;
}

- ( BOOL )detach: ( NSError * __autoreleasing * )error
{
    try
    {
        self.thread->detach();
    }
    catch( const std::system_error & e )
    {
        if( error != NULL )
        {
            *( error ) = [ NSError errorWithDomain: NSCocoaErrorDomain code: e.code().value() userInfo: @{ NSLocalizedDescriptionKey : [ NSString stringWithUTF8String: e.what() ] } ];
        }
        
        return NO;
    }
    
    return YES;
}

@end
