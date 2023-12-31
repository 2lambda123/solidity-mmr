// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

import {StatelessMmrHelpers} from "../src/lib/StatelessMmrHelpers.sol";

contract StatelessMmrHelpersLib_Test is Test {
    function testGetHeightRevert() public {
        vm.expectRevert("index must be at least 1");
        StatelessMmrHelpers.getHeight(0);
    }

    function testHeight() public {
        assertEq(StatelessMmrHelpers.getHeight(1), 0);
        assertEq(StatelessMmrHelpers.getHeight(2), 0);
        assertEq(StatelessMmrHelpers.getHeight(3), 1);
        assertEq(StatelessMmrHelpers.getHeight(7), 2);
        assertEq(StatelessMmrHelpers.getHeight(8), 0);
        assertEq(StatelessMmrHelpers.getHeight(46), 3);
        assertEq(StatelessMmrHelpers.getHeight(49), 1);
    }

    function testBitLength() public {
        assertEq(StatelessMmrHelpers.bitLength(0), 0);
        assertEq(StatelessMmrHelpers.bitLength(1), 1);
        assertEq(StatelessMmrHelpers.bitLength(2), 2);
        assertEq(StatelessMmrHelpers.bitLength(5), 3);
        assertEq(StatelessMmrHelpers.bitLength(7), 3);
        assertEq(StatelessMmrHelpers.bitLength(8), 4);
    }

    function testAllOnes() public {
        assertEq(StatelessMmrHelpers.allOnes(0), 0);
        assertEq(StatelessMmrHelpers.allOnes(1), 1);
        assertEq(StatelessMmrHelpers.allOnes(2), 3);
        assertEq(StatelessMmrHelpers.allOnes(3), 7);
        assertEq(StatelessMmrHelpers.allOnes(4), 15);
        assertEq(StatelessMmrHelpers.allOnes(5), 31);
        assertEq(StatelessMmrHelpers.allOnes(6), 63);
        assertEq(StatelessMmrHelpers.allOnes(7), 127);
        assertEq(StatelessMmrHelpers.allOnes(8), 255);
    }

    function testArrayDoesNotContain() public {
        bytes32[] memory arr = new bytes32[](0);

        assertFalse(StatelessMmrHelpers.arrayContains(0x0, arr));
    }

    function testArrayContains() public {
        bytes32[] memory arr = new bytes32[](3);
        arr[0] = 0x0;
        arr[1] = bytes32(uint(1));
        arr[2] = bytes32(uint(2));

        assertTrue(StatelessMmrHelpers.arrayContains(0x0, arr));
        assertTrue(StatelessMmrHelpers.arrayContains(bytes32(uint(1)), arr));
        assertTrue(StatelessMmrHelpers.arrayContains(bytes32(uint(2)), arr));
        assertFalse(StatelessMmrHelpers.arrayContains(bytes32(uint(42)), arr));
    }
}
