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

# Selector
Parameters: nChoices

Input signal(s): in[nChoices], index

Output: out

Specification: The output out should be equal to in[index]. If index is out of bounds (not in [0, nChoices)), out should be 0.

[Solution](https://github.com/darkforest-eth/circuits/blob/master/perlin/QuinSelector.circom)

# IsNegative
NOTE: Signals are residues modulo p (the Babyjubjub prime), and there is no natural notion of “negative” numbers mod p. However, it is pretty clear that that modular arithmetic works analogously to integer arithmetic when we treat p-1 as -1. So we define a convention: “Negative” is by convention considered to be any residue in (p/2, p-1], and nonnegative is anything in [0, p/2)

Parameters: none

Input signal(s): in

Output signal(s): out

Specification: If in is negative according to our convention, out should be 1. Otherwise, out should be 0. You are free to use the CompConstant circuit, which takes a constant parameter ct, outputs 1 if in (a binary array) is strictly greater than ct when interpreted as an integer, and 0 otherwise.

[Solution](https://github.com/iden3/circomlib/blob/master/circuits/sign.circom#L23)

Understanding check: Why can’t we just use LessThan or one of the comparator circuits from the previous exercise?

A: According to [Relational operators](https://docs.circom.io/circom-language/basic-operators/#relational-operators), 

The defination of Relational operator < constrains val(z) to be not greater than p/2. Thus, if we compare x (less than p/2) with y (larger than p/2) when use Less than, what Circom does is comparing x with p - y, then maybe we will get the wrong answer.

Note: You might notice that if you input "-1" to my `IsNegative` solution, the output is wrong. This issue is caused by the conversion between the input JSON to circom input, the -1 was converted to 2^32 - 1. Check this [discussion](https://github.com/Antalpha-Labs/zkp-co-learn/discussions/50)

# LessThan
Parameters: none

Input signal(s): in[2]. Assume that it is known ahead of time that these are at most `2^252−1`.

Output signal(s): out

Specification: If in[0] is strictly less than in[1], out should be 1. Otherwise, out should be 0.

Extension 1: If you know that the input signals are at most 2^k - 1 (k ≤ 252), how can you reduce the total number of constraints that this circuit requires? Write a version of this circuit parametrized in k.

Extension 2: Write LessEqThan (tests if in[0] is ≤ in[1]), GreaterThan, and GreaterEqThan

[Solution (with extension 1)](https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L89)

# IntegerDivide
NOTE: This circuit is pretty hard!

Parameters: nbits. Use assert to assert that this is at most 126!

Input signal(s): dividend, divisor

Output signal(s): remainder, quotient

Specification: First, check that the dividend and divisor are at most nbits in bitlength. Next, compute and constrain remainder and quotient.

Extension: How would you modify the circuit to handle negative dividends?

[Solution (ignore the second parameter SQRT_P; that is extraneous)](https://github.com/darkforest-eth/circuits/blob/master/perlin/perlin.circom#L44)

Note: You might notice that if you input negative dividend to my `IntegerDivide` solution, the output is wrong. This issue is caused by the conversion between the input JSON to circom input, the -1 was converted to 2^32 - 1. All negative inputs will be converted wrongly. Check this [discussion](https://github.com/Antalpha-Labs/zkp-co-learn/discussions/50)

Note: About if-else statement error, https://github.com/Antalpha-Labs/zkp-co-learn/discussions/54 