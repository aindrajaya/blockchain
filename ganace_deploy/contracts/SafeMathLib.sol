pragma solidity >=0.4.21 < 0.7.2;

library SafeMathLib {
  function times(uint a, uint b) public returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function minus(uint a, uint b) public returns (uint) {
    assert(b <= a);
    return a - b;
  }

  function plus(uint a, uint b) public returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }

  function assert(bool assertion) private {
    if (!assertion) revert();
  }
}