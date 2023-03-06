# [Modern ZK Crypto - Session 2 Exercises]( https://hackmd.io/@gubsheep/S1Hz96Yqo)

## Num2Bits
Parameters: nBits

Input signal(s): in

Output signal(s): b[nBits]

The output signals should be an array of bits of length nBits equivalent to the binary representation of in. b[0] is the least significant bit.

[Solution](https://github.com/iden3/circomlib/blob/master/circuits/bitify.circom#L25)

## IsZero
Parameters: none

Input signal(s): in

Output signal(s): out

Specification: If in is zero, out should be 1. If in is nonzero, out should be 0. This one is a little tricky!

[Solution](https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L24)

# IsEqual
Parameters: none

Input signal(s): in[2]

Output signal(s): out

Specification: If in[0] is equal to in[1], out should be 1. Otherwise, out should be 0.

[Solution](https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L37)