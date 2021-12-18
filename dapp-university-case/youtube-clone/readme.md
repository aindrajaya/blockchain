<!-- PROJECT SHIELDS -->
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/aindrajaya/blockchain">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Youtube Clone</h3>

  <p align="center">
    Counter App with Blockchain Ethereum Integration for Learning Purpose
    <br />
    <a href="https://github.com/aindrajaya/counter-dapp"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/aindrajaya/counter-dapp">View Demo</a>
    ·
    <a href="https://github.com/aindrajaya/counter-dapp/issues">Report Bug</a>
    ·
    <a href="https://github.com/aindrajaya/counter-dapp/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About the Counter dApps (Decentralized Applications)
[![Product Name Screen Shot][product-screenshot]](https://example.com)

So this project is my result of my [Project-based learning](https://www.pblworks.org/what-is-pbl) to explore more deep about Decentralize application that build on [Ethereum](https://ethereum.org/en/) networks, and to know on how the simple example Ethereum blockchain integration on the  website application.

Here's why and my purpose for this Learning Repository:
* Counter app is most simple case study to learn on how the website application works
* And I also want to make it more clear on how Integrate each functions on our website developer that can be store on the Ethereum blockchain networks.

And not forget to say thanks to [spalladion](https://github.com/spalladino) for the great counter dApps repository. Your repository inspired me to add more complex implementation about this dApp projects.

A list of commonly used resources that I find helpful are listed in the acknowledgements.

### Built With
This projects is built with
* [React](https://reactjs.org/)
* [Redux-saga](https://redux-saga.js.org/)
* [Ethereum](https://ethereum.org/en/)



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them. (if you haven't any `npm` installation before)
* npm
  ```sh
  npm install
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/aindrajaya/counter-dapp.git
   ```
2. Install NPM packages
   ```sh
   npm install
   ```
3. Compile the smart contract from `contratcs/Coutner.sol`
   ```sh
   npm run compile
   ```
4. Running the Ganache-cli
   ```sh
   ganache-cli
   ```   
5. add the `.env` file to your local environment
   ```dosini
   PROVIDER_URL=ws://localhost:8545
   ```
6. you can also add your own choice local address from ganache-cli
   ```dosini
   FROM='your address from ganache-cli'
   ```  



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/aindrajaya/counter-dapp/issues) for a list of proposed features (and known issues).



<!-- CONTACT -->
## Contact
Arista - [@Arista_Indra](https://twitter.com/Arista_Indra) - arista.indrajay@gmail.com

Project Link: [Counter dApp](https://github.com/aindrajaya/counter-dapp)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [React](https://reactjs.org/)
* [Redux-saga](https://redux-saga.js.org/)
* [Ethereum](https://ethereum.org/en/)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[stars-shield]: https://img.shields.io/github/stars/aindrajaya/counter-dapp.svg?style=for-the-badge
[stars-url]: https://github.com/aindrajaya/counter-dapp/stargazers
[issues-shield]: https://img.shields.io/github/issues/aindrajaya/counter-dapp.svg?style=for-the-badge
[issues-url]: https://github.com/aindrajaya/counter-dapp/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/aindrajaya
[product-screenshot]: images/screenshot.png