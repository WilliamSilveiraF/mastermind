# Mastermind Game

### Instructions
- The player's main objective is to guess a secret key of 4 BCD numbers in up to 16 rounds.
- If you guess the sequence, your score adds 16 points + the remaining amount of rounds.
- The points will be displayed as Hexademical (if you guess in the first round, yours points will be 1F(hexadecimal) = 31(decimal -> 31 = 16 + 15)
- The player has 10 seconds to try some sequence each round and one secret key always has differents numbers
- If the player don't try any sequence in 10 seconds, the player lose and the game displays the secret key
- The player can select 4 levels: 
- (Level 0 - each line must contain a sequence of 4 numbers from 0 to 3 in BCD)
- (Level 1 - each line must contain a sequence of 4 numbers from 0 to 5 in BCD)
- (Level 2 - each line must contain a sequence of 4 numbers from 0 to 7 in BCD)
- (Level 3 - each line must contain a sequence of 4 numbers from 0 to 9 in BCD)
- Any time the user can reset the game, returning to the init state

### Components:
- Controller - **controller.vhd**
- Datapath - **datapath.vhd**
- ROM's - **ROM0.vhd, ROM1.vhd, ROM2.vhd and ROM3.vhd**
- Multiplexers - **mux2x1.vhd, mux4x1.vhd and mux4x1bits16.vhd**
- Thermometric Decoder - **DECODER_TERMOMETRICO.vhd**
- Time counter - **Counter_time.vhd**
- Round counter - **Counter_round.vhd**
- 3 bit register - **reg3bits.vhd**
- 6 bit register - **reg6bits.vhd**
- 16 bit register - **reg16bits.vhd**
- Seven segment decoder - **decod_7seg.vhd**
- Comparators - **comp_e, Comp_0.vhd, Comp_1.vhd, Comp_2.vhd, Comp_3.vhd and CompIsEqual4.vhd**
- Summators - **soma1.vhd and Soma_P.vhd**
- Selector - **selector.vhd**
- Button - **ButtonSync.vhd**

![all text](https://github.com/WilliamSilveiraF/mastermind/blob/main/datapath.png.png)


![all text](https://github.com/WilliamSilveiraF/mastermind/blob/main/statediagram.png)