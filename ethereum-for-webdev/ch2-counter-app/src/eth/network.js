import Web3 from 'web3';

let web3;
export function getWeb3(){
  if(!Web3){
    web3 = new Web3(Web3.givenProvider);
  }
  return web3;
}

export async function getAccount(){
  const web3 = getWeb3();
  const accounts  = await web3.eth.getAccounts();
  return accounts[0]

  //for the privacy mode
  const accounts1 = await window.ethereum.enable();
  return accounts1[0];
}