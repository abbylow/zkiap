# Modern ZK Crypto - Session 1 Exercises

## [ZKP for 3-coloring Demo](http://web.mit.edu/~ezyang/Public/graph/svg.html)

### Exercise 1 Question
Currently, you can only select adjacent pairs of nodes to check. 
Would the proof still be zero knowledge if you could pick arbitrary pairs of nodes to check?

### Answer
Although checking two non-adjacent pairs of nodes doesn't help to verify the 3-coloring proof, the verifier is still able to select adjacent pairs of nodes to achieve verification of the 3-coloring map proof. 
If the verifier could pick non-adjacent pairs of nodes to check, even though the displayed colorings are mixed up, the verifier might choose a pair of nodes that are having the same color (after mixing up, the same color node will be displayed as same color still). 
In that case, the verifier may be able to deduct the soluton by marking which few nodes are having the same color. 

### Exercise 2 Question 
The equation currently being used for confidence is 1-(1/E)^n, where E is the number of edges in the graph, and n is the number of trials run. Is this the correct equation? Why is there no prior?

### Answer
Let's read the below quoted text to understand the soundness of zkp: 
> Soundness: We need to show that if w provides an invalid 3-coloring of G. Then the
> Prob[Verifier returns accept] ≤ negl(n) 
> Since w is an invalide 3-coloring of G, then there exists edge ei,j such that ci = cj . 
> Thus Prob[Verifier returns reject] ≥ Prob[Verifier picks ei,j] = 1/|E|
> Once we have protocol with soundness of 1/E we can just repeat the protocol sequentially to improve the soundness.
> By sequential repetition if we repeat the protocol k times and k >> E then
> Prob[Verifier returns accept] ≤ (1 − 1/E)^k ≤ negl(n)

Note: 
> 💡 negl(n) is being used to indicate a probability that is considered negligible with respect to the security parameter n, meaning that it is sufficiently small to be considered negligible for cryptographic purposes.

> 💡 Why `Prob[Verifier returns reject] ≥ Prob[Verifier picks ei,j]`? For an invalid 3-coloring of G, there is 1 or more edges that have same colors of nodes. 

> 💡 k >> E means k is much larger than E. In this context, it means that the protocol is repeated many times, and the number of repetitions is much larger than the number of edges in the graph. The purpose of repeating the protocol sequentially is to improve the soundness, which is the probability that the verifier rejects an invalid claim by the prover. By repeating the protocol many times, the soundness can be increased to a level that is negligible with respect to the security parameter n.

`Prob[Verifier returns accept]` is the soundness error when the prover manages to lie to the verifier and make them accept an invalid proof. 
Thus, the correct equation for confidence should be `1-(1-1/E)^n`. 

Clarification: n is the number of trials run; In the quoted text, n is security parameter while they use k to represent number of trials

Reference: https://www.cs.cmu.edu/~goyal/s18/15503/scribe_notes/lecture23.pdf 

### My thoughts
Why does the confidence is only 64.47% after 15 trials? If the verifier checks a unique edge each trial, shouldn't the confidence be 100%? 

After the discussion with friends and reading some reference, the answer for the question above: 

- The simulator will recommit the proof for each trial
- Each trial is individual as the edge is randomly selected by the verifier
- We can't confirm that the committed proof is same with last trial, so that checking different edges doesn't mean all edges are definitely valid. We can only improve the soundness by repeating the verification for more times. 


## [zkmessage.xyz](https://zkmessage.xyz)

### Question 1
Explain why you need to generate and save a “secret” value.

### Answer 1
The "secret" value generation is actually creating a pair of public key and private key. To create an account in zkmessage, we have to submit our public key to the server. To verify our twitter account, we publish our public key in the tweet. The private key is the only thing that can be used to prove the ownership of the public key (and also the account).

### Question 2
Write out a plain-English explanation of what statement is being proven in ZK.

### Answer 2
When creating a thread or message, the users have to prove that: 

a. verify the membership - prove the user is part of the group by checking the hash of secret key is equal to one of the public hashes in the group

b. verify the same user created the message and the proof 

### Question 3
Log into the same zkmessage account, from a different browser or computer. Explain why zkmessage can’t just use a simple “username/password” system like most social apps.

### Answer 3
In zkmessage, secret key is similar to the password. Instead of determining a username, the "username" in zkmessage is derived from the secret key. 

When generating the zk proof, the secret key is hashed and submitted with other information like hashed message and the group. 

Imagine zkmessage uses simple “username/password” system, if some users are using the same password, the hashed password will be the same and the user may potentially forge the other identity. 
