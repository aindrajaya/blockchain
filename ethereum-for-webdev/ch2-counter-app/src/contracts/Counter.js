import Artifacts from './combined.json'
import { getWeb3, getAccount } from '../eth/network';

export default function Counter(web3, address, options = {}){
  const name = "contracts/Counter.sol:Counter";
  const artifacts = Artifacts.contracts[name];
  const abi = JSON.parse(artifacts.abi)
  return new web3.eth.Contract(abi, address, options);
}

export async function getDeployed(){
  const web3 = getWeb3();
  const from = await getAccount();
  const addr = "address";
  return Counter(web3, addr, {from});
}