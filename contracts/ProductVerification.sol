//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Product_Lib{
  
  struct Product {
    string name;
    uint256 DateofApplication;
    uint256 totalincome;
    uint256 dateofbirth;
    string otherasset;
    string sibling;
    address totalsizeofplot;
    string copyofitr;
    string qrCode;
  }
}

contract Product_Exist {
  function checkSerialNumber(Product_Lib.Product[] memory product) public pure {
    require(product.length == 0, "Given serial ID is already taken");
  }
}

contract Product_Exist_For_Updating {
  function exist(Product_Lib.Product[] memory product) public pure {
    require(product.length != 0, "This item is not in the List");
  }
}


contract ProductVerification { 
    
    uint256 counter;
    address ownerHash;
    
    constructor() public {
      require(msg.sender != address(0), "no-owner-provided");
      ownerHash = msg.sender;
      counter = 100000;
    }
     
    mapping(uint => Product_Lib.Product[]) public products;
    
    event ErrorLogging(string reason);
    function addProduct(string memory _name, uint256 _manufacturingDate, uint256 _transferDate, uint256 _expiryDate, string memory _currentOwner, string memory _licenseNumber, string memory _qrCode,string memory _medicineID, address _currentOwnerHash ) public payable{
    
      Product_Exist exist = new Product_Exist();
      
      try exist.checkSerialNumber(products[counter]){
        products[counter].push(Product_Lib.Product(_name, _manufacturingDate, _transferDate, _expiryDate, _currentOwner, _licenseNumber, _currentOwnerHash, _medicineID, _qrCode));
        incrementcounter(); 
      } 
      catch Error(string memory reason){
        emit  ErrorLogging(reason);
      }
    }
    
    event ErrorLoggingWhileUpdating(string reason);
    function updateOwnership(uint256 index, uint256 _transferDate,string memory _updateOwner, string memory _licenseNumber, address _updateOwnerHash) public payable{
      Product_Lib.Product[] memory product = products[index];
      
      Product_Exist_For_Updating updating_allowed = new Product_Exist_For_Updating();

      try updating_allowed.exist(product){
        products[index].push(Product_Lib.Product(product[0].name, product[0].manufacturingDate, _transferDate, product[0].expiryDate, _updateOwner, _licenseNumber, _updateOwnerHash, product[0].MedicineID, product[0].qrCode));
      }

      catch Error(string memory reason){
        emit  ErrorLoggingWhileUpdating(reason);
      }
    }

    function returnSize() public view returns(uint){
      return counter;
    }

    function returnDetails(uint index) public view returns(Product_Lib.Product[] memory){
      return products[index];
    }

    function currentOwner(uint index) public view returns(Product_Lib.Product memory){
      Product_Lib.Product[] memory product = products[index];
      uint256 len = product.length;
      if(len!=0){
        return product[len-1];
      }else{
        Product_Lib.Product memory dummyProduct;
        return dummyProduct;
      }
    }

    function incrementcounter() private{
      counter++;
    }
}