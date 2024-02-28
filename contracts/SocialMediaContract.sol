// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IFactoryContractNFT.sol";

contract SocialMedia {
    uint userId;
    uint postId;
    uint groupId;
    address owner = msg.sender;
    address nftFactory;

    constructor(address _nftFactory) {
        nftFactory = _nftFactory;
    }

    enum role {
        user,
        admin
    }

    struct users {
        string userName;
        uint id;
        uint postCount;
        role userRole;
    }

    struct group {
        string groupName;
        uint id;
        uint[] groupMemberIds;
    }

    struct post {
        string content;
        uint id;
        uint numberOfLikes;
        string[] comments;
    }

    mapping(address => post[]) userPosts;

    mapping(address => users) userInfo;

    mapping(address => mapping(uint => post)) eachUserPost;

    mapping(uint => group) eachgroup;

    mapping(address => bool) isRoleAdmin;

    mapping(address => bool) hasRegistered;

    function onlyOwner() private view {
        require(msg.sender == owner, "only owner can perform action");
    }

    function registerUser(string memory _userName) public {
        require(bytes(_userName).length > 3, "Username cannot be empty");
        require(msg.sender != address(0), "Address zero detected");
        require(
            !hasRegistered[msg.sender],
            "this address is already registered"
        );
        uint _id = userId + 1;
        hasRegistered[msg.sender] = true;
        IFactoryContractNFT(nftFactory).createContract();
        userInfo[msg.sender] = users(_userName, _id, 0, role.user);
        userId++;
    }

    function registerAdmin(
        address _newAdmin,
        string memory _adminUserName
    ) public {
        onlyOwner();
        require(!hasRegistered[_newAdmin], "Not a registered user");
        hasRegistered[_newAdmin] = true;
        isRoleAdmin[_newAdmin] = true;
        hasRegistered[msg.sender] = true;
        uint _id = userId + 1;
        IFactoryContractNFT(nftFactory).createContract();
        userInfo[_newAdmin] = users(_adminUserName, _id, 0, role.admin);
        userId++;
    }

    function createPost(
        string memory _content,
        string memory _tokenUri
    ) public {
        require(msg.sender != address(0), "Address zero detected");
        require(
            hasRegistered[msg.sender],
            "Register to be able to create post"
        );
        uint _postId = postId + 1;
        IFactoryContractNFT(nftFactory).safeMint(msg.sender, _tokenUri);
        eachUserPost[msg.sender][_postId] = post(
            _content,
            _postId,
            0,
            new string[](0)
        );
        postId++;
    }

    function likePost(address _postOwner, uint256 _postId) public {
        require(hasRegistered[msg.sender], "Register to be able to like post");
        eachUserPost[_postOwner][_postId].numberOfLikes += 1;
    }

    function commentOnPost(
        address _postOwner,
        uint256 _postId,
        string memory _comment
    ) public {
        require(hasRegistered[msg.sender], "Register to be able to like post");
        eachUserPost[_postOwner][_postId].comments.push(_comment);
    }

    function createGroup(string memory _groupName) external {
        require(msg.sender != address(0), "Address zero detected");
        require(
            hasRegistered[msg.sender],
            "Register to be able to create post"
        );
        uint _groupId = groupId + 1;
        uint[] memory groupMemberIds;
        eachgroup[_groupId] = group(_groupName, _groupId, groupMemberIds);
        groupId++;
    }

    function addMember(address _user) external {
        require(msg.sender != address(0), "Address zero detected");
        require(
            hasRegistered[msg.sender],
            "Register to be able to create post"
        );
        uint _groupId = groupId + 1;
        eachgroup[_groupId].groupMemberIds.push(userInfo[_user].id);
        groupId++;
    }
}
