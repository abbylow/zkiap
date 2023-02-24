# Modern ZK Crypto - Session 1 Exercises

## [ZKP for 3-coloring Demo](http://web.mit.edu/~ezyang/Public/graph/svg.html)

### Exercise 1 

#### Question
Currently, you can only select adjacent pairs of nodes to check. 
Would the proof still be zero knowledge if you could pick arbitrary pairs of nodes to check?

#### Answer
Although checking two non-adjacent pairs of nodes doesn't help to verify the 3-coloring proof, the verifier is still able to select adjacent pairs of nodes to achieve verification of the 3-coloring map proof. 
If the verifier could pick non-adjacent pairs of nodes to check, even though the displayed colorings are mixed up, the verifier might choose a pair of nodes that are having the same color (after mixing up, the same color node will be displayed as same color still). 
In that case, the verifier may be able to deduct the soluton by marking which few nodes are having the same color. 
