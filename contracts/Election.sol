pragma solidity ^0.5.16;

contract Election {
	
	// Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	// Store accounts that have voted
	mapping(address => bool) public voters;

	// Store Candidate
	// Fetch Candidate
	mapping(uint => Candidate) public candidates;

	// Store Candidates Count
	uint public candidatesCount;

	// Voted Event
	event votedEvent (
		uint indexed _candidateID
	);

	// Constructor
	constructor () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote (uint _candidateID) public {

		// Require that the account hasn't voted before
		require(!voters[msg.sender]);

		// Require that the vote goes for a valid candidate
		require(_candidateID > 0 && _candidateID <= candidatesCount);

		// Record that voter has voted
		voters[msg.sender] = true;

		// Update candidate vote count
		candidates[_candidateID].voteCount ++;

		// Trigger voted event
		emit votedEvent(_candidateID);

	}

}