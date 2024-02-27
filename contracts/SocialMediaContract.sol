// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IFactoryContractNFT.sol";


contract SocialMedia {
    uint userId;
    uint postId;
    uint groupId;
    address owner = msg.sender;

    enum role {
        user, admin
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
        users[] groupMembers;
    }

    struct post {
        string title;
        uint id;
        uint numberOfLikes;
        string[] comments;
    }

    mapping (address => post[]) userPosts;

    mapping (address => mapping (uint => post)) postInfo;

    mapping (address => users) userInfo;

    mapping (address => mapping (uint => post)) eachUserPost;

    mapping (address => bool) isRoleAdmin;

    mapping (address => bool) hasRegistered;

    mapping (address => address) nftContractAddress;

    mapping(address => mapping (address => bool)) isFollowing;

    mapping(uint256 => address) public postOwner;

    mapping(uint256 => uint256) public postLikes;

    mapping(uint256 => mapping(uint256 => string)) public postComments;
    
    uint256 public postCount;

    function onlyOwner() private  view {
      require(msg.sender == owner, "only owner can perform action");
    }

    function registerUser(string memory _userName) public {
        require(bytes(_userName).length > 3, "Username cannot be empty");
        require(msg.sender != address(0), "Address zero detected");
        require(!hasRegistered[msg.sender], "this address is already registered");
        uint _id = userId + 1;
        hasRegistered[msg.sender] = true;
        address _nftContractAddress = IFactoryContractNFT.createContract();
        nftContractAddress[msg.sender] = _nftContractAddress;
        users[msg.sender] = users(_id, _userName, 0, role.user);
        userId++;
    }

    function registerAdmin(address _newAdmin, string memory _adminUserName) public {
        onlyOwner();
        require(hasRegistered[_newAdmin], "Not a registered user");
        hasRegistered[_newAdmin] = true;
        isRoleAdmin[_newAdmin] = true;
        uint _id = userId +1;
        address _nftContractAddress = IFactoryContractNFT.createContract();
        nftContractAddress[_newAdmin] = _nftContractAddress;
        users[_newAdmin] = users(_id, _adminUserName, 0, role.admin);
        userId++;
    }

    function createPost(string memory _content, string memory tokenUri) public {
      require(msg.sender != address(0), "Address zero detected");
      require(hasRegistered[msg.sender], "Register to be able to create post");

    }

    function likePost(uint256 _postId) public {
        require(postOwner[_postId] != address(0), "Post does not exist");
        require(hasRegistered[msg.sender], "Register to be able to like post");
        postLikes[_postId]++;
    }

    function commentOnPost(uint256 _postId, string memory _comment) public {
        require(postOwner[_postId] != address(0), "Post does not exist");
        require(hasRegistered[msg.sender], "Register to be able to comment on post");
        postComments[_postId][postLikes[_postId]] = _comment;
        postLikes[_postId]++;
    }



   
}