pragma circom 2.1.4;

include "circomlib/compconstant.circom";

template IsNegative(){
    signal input in;
    signal output out;

    component n2b = Num2Bits(254);
    component comp = CompConstant(10944121435919637611123202872628637544274182200208017171849102093287904247808);

    n2b.in <== in;
    comp.in <== n2b.out;
    out <== comp.out;
}

template IntegerDivide(divisor_bits) {
    signal input dividend; // -8
    signal input divisor; // 5
    signal output remainder; // 2
    signal output quotient; // -2

    component is_neg = IsNegative();
    is_neg.in <== dividend;

    signal output is_dividend_negative;
    is_dividend_negative <== is_neg.out;

    signal output dividend_adjustment;
    dividend_adjustment <== 1 + is_dividend_negative * -2; // 1 or -1

    signal output abs_dividend;
    abs_dividend <== dividend * dividend_adjustment; // 8

    signal output raw_remainder;
    raw_remainder <-- abs_dividend % divisor;
    
    signal output neg_remainder;
    neg_remainder <-- divisor - raw_remainder;

    remainder <-- (is_dividend_negative == 1 && raw_remainder != 0) ? neg_remainder : raw_remainder;
    // if (is_dividend_negative == 1 && raw_remainder != 0) {
    //     remainder <-- neg_remainder;
    // } else {
    //     remainder <-- raw_remainder;
    // }


    quotient <-- (dividend - remainder) / divisor; // (-8 - 2) / 5 = -2

    dividend === divisor * quotient + remainder; // -8 = 5 * -2 + 2

    // check that 0 <= remainder < divisor
    component remainderUpper = LessThan(divisor_bits);
    remainderUpper.in[0] <== remainder;
    remainderUpper.in[1] <== divisor;
    remainderUpper.out === 1;
}

component main = IntegerDivide(8);

/* INPUT = {
    "dividend": "19",
    "divisor": "5"
} */