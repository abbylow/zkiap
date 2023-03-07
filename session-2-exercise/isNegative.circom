pragma circom 2.1.2;

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

component main { public [in]}  = IsNegative();

/* INPUT = {
    "in": "-1"
} */