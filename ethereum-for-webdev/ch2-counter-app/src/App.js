import './App.css';
import React, {Component} from 'react';
import Counter from './components/Counter';

//import the getDeployed function from the Counter contract interface
import { getDeployed } from './contracts/Counter';


class App extends Component {
  state = {counter: null}

  //will get the state from the deployed Counter contracts
  async componentDidMount(){
    const counter = await getDeployed()
    this.setState({counter})
  }

  render(){
    const {counter} = this.state;
    return (
      <div className="App">
        {/* checkt the counter state, if not null show the Counter component */}
        {counter && <Counter contract={counter}/>}
      </div>
    );
  }
}

export default App;
