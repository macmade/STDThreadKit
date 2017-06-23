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

/*!
 * @file        STDThread.swift
 * @copyright   (c) 2017, Jean-David Gadina - www.xs-labs.com
 */

import XCTest
import STDThreadKit

class STDThreadTest: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testHardwareConcurrency()
    {
        XCTAssertGreaterThan( STDThread.hardwareConcurrency, 0 )
    }
    
    func testJoinable()
    {
        let t = STDThread
        {}
        
        XCTAssertTrue( t.joinable )
        XCTAssertNoThrow( try t.detach() )
        XCTAssertFalse( t.joinable )
    }
    
    func testJoin()
    {
        var b = false
        
        let t = STDThread
        {
            sleep( 1 )
            
            b = true
        }
        
        XCTAssertNoThrow( try t.join() )
        XCTAssertTrue( b )
    }
    
    func testDetach()
    {
        let t = STDThread
        {}
        
        XCTAssertNoThrow( try t.detach() )
    }
    
    func testDoubleJoin()
    {
        let t = STDThread
        {}
        
        XCTAssertNoThrow(     try t.join() )
        XCTAssertThrowsError( try t.join() )
    }
    
    func testDoubleDetach()
    {
        let t = STDThread
        {}
        
        XCTAssertNoThrow(     try t.detach() )
        XCTAssertThrowsError( try t.detach() )
    }
    
    func testJoinDetach()
    {
        let t = STDThread
        {}
        
        XCTAssertNoThrow(     try t.join() )
        XCTAssertThrowsError( try t.detach() )
    }
    
    func testDetachJoin()
    {
        let t = STDThread
        {}
        
        XCTAssertNoThrow(     try t.detach() )
        XCTAssertThrowsError( try t.join() )
    }
}
