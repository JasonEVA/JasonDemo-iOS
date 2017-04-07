//
//  JasonDemoTests.m
//  JasonDemoTests
//
//  Created by jasonwang on 16/3/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JasonDemoTests : XCTestCase

@end

@implementation JasonDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for(int i=0;i<10000;i++)
        {
            NSLog(@"%d",i);
        }
        // Put the code you want to measure the time of here.
    }];
}

@end
