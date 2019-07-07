# E-Voting System using Azure Blockchain

## Introduction

Blockchain-the revolutionary technology was first introduced by Satoshi Nakamoto in his whitepaper 'Bitcoin: A Peer-to-Peer Electronic Cash System' introducing the first cryptocurrency. While the technology has revolutionalized the idea of digital currency, it also finds it's applications in other fields like Supply Chain Management and Asset Transfers to name a few.

What makes blockchain unique is it's inherent architecture that supports a decentralized distributed and immutable ledger.

The key features are:
1. Decentralization
2. Transparency
3. Immutability
4. Distributed and P2P Network
5. Security and Anonymity

Democracy is the best form of government, while many argue, might be true in theory. However, it creates another set of problems like-
1. Delay in results
2. Vote Tampering
3. Threat to security and privacy
4. Corruption
5. Bribes for Votes

While not all the problems could be solved by technology, we intend to use the blockchain technology to address the issues of decentralization, transparency, security and privacy.

## The Idea

The project intends to simulate the Election System in India.

<img src="Voter's Portal.png"> 

### Voter Registration and Authentication

#### The Registration Phase
The portal will be a webapp to carry out the registration process. The functionalities include:
1. Registration of New Voter
2. Modify/change Details such as address, city
3. Removal of Voter(due to death or any other reason as stated in the constitution)

Voters would use this portal to register or see/verify the details that the Election Commision(EC) maintains. The databse ould be maintained in blockchain via a smart contract so as to ensure privacy and security of personal data.

#### Election Phase

Once the voter registration phase gets over, the election phase begins. EC will share the credentials to respective voters and request to verify. It is similar to current process of verification of the credentials by to-door service where a person comes and asks for signatures on the voters' list. On successful validation by the voter, EC would issue a JWT token to the voter to cast his/her vote.

### Candidate Registration And Authentication

The portal will be similar as the voter's portal but would intend to carry out the registration of the candidates. On authentication, each candidate/ party will be given a unique identification number to be used in the entire election process. The database would be maintained in another smart contract for similar reasons.

### The Election Process via CastYourVote DApp

The DApp would include following functionalities:
1. View the Candidates' details in the voter's constituency
2. Know the manifestos of a candidate
3. Track the activities that a candidate is involved in during the election process.
4. Complaint Portal: For the voters to report any malpractices being carried out in his/her area.
5. Cast his/her vote

The DApp would also host the live results of the elections during the voting process thus revealing the results immediately.

## Relevance and Scalability of the Idea

1. Any person can vote from anywhere provided he/she is a registered voter without any hassle of going to the election polls.

2. The voting process could be modelled in an object oriented way modelling all levels of ministers: 
                           Constituency -> City -> State -> Country
   
   Thus, all kinds of elections: State Elections, Central Elections can be hosted via this project.
   
3. Since all kinds of databases have been maintained on blockchain technology, privacy and security of data has been inherently    ensured.
4. Tracking of live activites of a candidate would help the voters to take an informed decision.
5. The project would help to smoothly carry out the Election Process in India however can be extended to simple votings being carried in different organizations (for example, members of an Executive Committee)

## Challenges

Not everyone in India is tech literate. This poses as one of the major challenges of an E-Voting System. To extend the process to the rural parts of India, fingerprints might be used instead of JWTs to carry out the process. However, the challenge remains an area to be explored for us.

# Authors

1. [Rohit Jain]("https://github.com/Rohit2706")
2. Sarthak Sehgal
3. Srujana

College: BITS Pilani, Pilani
Team Name: Chai mein Duba Biscuit