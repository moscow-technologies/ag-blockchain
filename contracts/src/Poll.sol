pragma solidity ^0.4.11;

import "./Owned.sol";

contract Poll is Owned {
	string public Name;
	string public Description;
	address[] _questions;
	uint[] _questionIds;

	function Poll(string name, string description) Owned() {
		Name = name;
		Description = description;
	}

	event QuestionAdded(address questionAddress);

	function addQuestion(
		uint id,
		uint versionId,
		string name, 
		string answers, 
		uint[] answerIds) onlyOwner() returns (address) {
		address questionAddress = new PollQuestion(id, versionId, name, answers, answerIds);
		var question = PollQuestion(questionAddress);
		question.changeOwner(msg.sender);
		_questions.push(questionAddress);
		_questionIds.push(id);

		QuestionAdded(questionAddress);

		return questionAddress;
	}

	function QuestionsAddress() constant returns (address[] questionAddress) {
		return _questions;
	}

	function QuestionIds() constant returns (uint[] questionIds) {
		return _questionIds;
	}
}

contract PollQuestion is Owned {	
	uint public QuestionId;
	uint _voterCount;
	mapping(uint => Version) public _versions;

	uint _currentVersion;
	uint[] _versionsExisting;
	mapping (string => uint) _userVersionsVotes;
	mapping (string => bool) _userVersionsVotesExistence;

	event VersionAdded(uint questionId, uint versionId);
	event VersionError(uint questionId, uint versionId);
	event VoteError(uint questionId, uint versionId, string userKey, uint code);	

	function PollQuestion(uint id, uint versionId, string name, string answers, uint[] answerIds) Owned() {
		QuestionId = id;
		_currentVersion = 0;
		_versionsExisting = new uint[](0);
		addVersion(versionId, name, answers, answerIds);
	}

	struct Version {
		bool Exists;
		string Answers;	
		string Name;

		uint[] AnswerIds;
		uint[] Results;

		mapping (string => uint[]) Votes;
		mapping (string => string) AnswerValues1;
		mapping (string => string) AnswerValues2;
	}

	 function addVersion(uint versionId, string name, string answers, uint[] answerIds) onlyOwner() {
		if (_versions[versionId].Exists == true) {
			VersionError(QuestionId, versionId);
			return;
		}

		_currentVersion = versionId;
		_versionsExisting.push(versionId);
		_versions[versionId].Exists = true;
		_versions[versionId].Answers = answers;
		_versions[versionId].Name = name;
		_versions[versionId].AnswerIds = answerIds;
		_versions[versionId].Results = new uint[](0);
		for (uint i = 0; i < answerIds.length; i++) {
			 _versions[versionId].Results.push(0);
		}

		VersionAdded(QuestionId, _currentVersion);
	}

	function CurrentVersion() constant returns (uint result) {
		return _currentVersion;
	}

	function AllExistingVersions() constant returns(uint[]) {
		return _versionsExisting;
	}

	function vote(uint version, string userKey, uint[] options, string customAnswer, string customAnswer2) onlyOwner() {
		if (_userVersionsVotesExistence[userKey] == true) {
			VoteError(QuestionId, version, userKey, 1);
			return;
		}

		voteInternal(version, userKey, options, customAnswer, customAnswer2);
	}

	function voteInternal(uint version, string userKey, uint[] options, string customAnswer, string customAnswer2) private {
		if (version > _currentVersion) {
			VoteError(QuestionId, version, userKey, 2);
			return;
		}
	
		_voterCount++;
		_versions[version].Votes[userKey] = options;
		_versions[version].AnswerValues1[userKey] = customAnswer;
		_versions[version].AnswerValues2[userKey] = customAnswer2;
		_userVersionsVotesExistence[userKey] = true;
		_userVersionsVotes[userKey] = version;

		for (uint i = 0; i < options.length; i++) {
			_versions[version].Results[options[i]] += 1;
		}
	}

	function CurrentVersionTitle() constant returns (string) {
		return _versions[_currentVersion].Name;
	}

	function VoterCount() constant returns(uint) {
		return _voterCount;
	}

	function CurrentVersionResults() constant returns (uint[] results) {
		return ResultsByVersion(_currentVersion);
	}

	function ResultsByVersion(uint version) constant returns (uint[] results) {
		return _versions[version].Results;
	}

	function VoteOfUser(string voter) constant returns (uint[] results, string value1, string value2) {
		var version = _versions[_userVersionsVotes[voter]];
		return (version.Votes[voter], version.AnswerValues1[voter], version.AnswerValues2[voter]);
	}

	function AnswersByVersion(uint version) constant returns (string results) {
		return _versions[version].Answers;
	}

	function AnswerIdsByVersion(uint version) constant returns (uint[] results) {
		return _versions[version].AnswerIds;
	}
}