import Web3 from "web3";
import { abi, networks } from "../../../build/contracts/ProductVerification.json"
let name = document.getElementById('name').value;
let manufacturing = document.getElementById('mdate').value;
let transfer = document.getElementById('tdate').value;
let expiry = document.getElementById('edate').value;
let role = document.getElementById('role').value;
let currentOwnerLincense = document.getElementById('coln').value;
let currentOwnerHash = document.getElementById('coh').value;
let medicineID = document.getElementById('medicineID').value;
let OwnerLincense = document.getElementById('oln').value;


const web3 = new Web3(window.ethereum);
const contract = new web3.eth.Contract(abi, networks[1680983828029].address);
async function addProduct(){
    contract.methods.addProduct(name, manufacturing, transfer, expiry,role, OwnerLincense, medicineID,localStorage.setItem("account")).send(
        {from:localStorage.setItem("account")},
        (error, result) => {
            console.log(error, result);
        }
    );
}

addProduct();