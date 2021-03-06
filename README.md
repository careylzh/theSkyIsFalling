# Elementary FPGA for Arcade Game (School Proj)
Demo             |  Description
:-------------------------:|:-------------------------:
![50.002 Computational Structures 2019 Demo](https://github.com/careylzh/theSkyIsFalling/blob/master/theSkyIsFalling.gif) | <div align="left">Virgin attempt at using a simple FPGA + HDL to create an old school arcade game.<br/> <br/> __Software__: Alchitry Labs, PlanAhead Synthesizer, no test bench <br/> __Hardware__: Mojo v3 by Alchitry Labs (Spartan 6 XC6SLX9 FPGA, super relatively low-end FPGA) <br/> __"Programming" Language Used__: Lucid (simplified verilog) <br/> <br/> Thank you Prof Natalie Agus for your assistance. Assistance is an understatement <br/> <br/> _this project is deprecated:_ <br/> no comments <br/> various mem architecture in diff versions, but the TLDR is that we tried block ram 512 DFFs instead of the current design</div>

The LED matrix works by receiving 64 bits of serial data in one clock cycle. So it requires 32 clock cycles to render one image onto the the board. On hindsight, it was a bad decision to use this particular LED matrix as rookies, because this matrix was a counterfeit and the IMPLICATION was that the bit addressing for the first half and second half of the board (in vertial orientation) were swapped, which meant that our images were upside down + inverted from the middle. Our Prof spent lots of time debugging and writing the driver of the matrix, while we worked on the state logic. 

Please look at this repo for working code written by Prof Nat: https://github.com/natalieagus/SampleAlchitryProjects/tree/master/MatrixLEDTest

Do note that this project is written in Lucid HDL, which means that code is only compatible with Alchitry IDE, which translates Lucid HDL into Verilog. 

![50.002 Computational Structures 2019 Project Poster](https://github.com/careylzh/theSkyIsFalling/blob/master/50.002%20FPGA%201D%20Poster%20SUTD%202019.png)

