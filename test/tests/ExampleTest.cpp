/*
 * TestExampleTest.cpp
 *
 *  Created on: 21 May 2018
 *      Author: eser
 */

// CppuTest includes
#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

#include "unittest_ex.h"
// Header for unit under test


//Declare a test group
TEST_GROUP(Example) {

	// Declare a setup method.. Optional
	void setup () {

	}

	// Declare a tearDown method.. Optional
	void teardown () {

	}
};

TEST(Example, Test1) {
    /* Check two longs are equal */
    LONGS_EQUAL(1, 1);
}

TEST(Example, Test2) {
    /* Check a condition */
    CHECK(true == true);

    /* Check a string */
    STRCMP_EQUAL("HelloWorld", "HelloWorld");
}

TEST(Example, example) {
	LONGS_EQUAL(5, unittest_add(2, 3));
}

