library ieee;
use ieee.std_Logic_1164.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is


signal code, user, s_dec_term, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0); 
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4_1, h6_1, h7_1: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal time_c, X, s_soma, F: std_Logic_vector(3 downto 0);
signal P, P_reg, E, E_reg: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal end_gamee, end_timee, cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic;

component reg3bits is port (
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(2 downto 0);
    Q: out std_logic_vector(2 downto 0));
end component;

component reg16bits is port(   
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(15 downto 0);
    Q: out std_logic_vector(15 downto 0));
end component;

component reg6bits is port(
    CLK_500hz: in std_logic;
    EN: in std_logic;
    RST: in std_logic;
    D: in std_logic_vector(5 downto 0);
    Q: out std_logic_vector(5 downto 0));
end component;

component ROM0 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM1 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM2 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component ROM3 is port(
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end component;

component mux4x1bits16 is port (
    in00, in01, in10, in11: in std_logic_vector(15 downto 0);
    SEL_MUX_ROM: in std_logic_vector(1 downto 0);
    dataout: out std_logic_vector(15 downto 0));
end component;

component Comp_0 is port (        
    USER: in std_logic_vector(3 downto 0);
    CODE: in std_logic_vector(3 downto 0);
    ISEQUAL: out std_logic);
end component;

component Comp_1 is port (        
    USER: in std_logic_vector(7 downto 4);
    CODE: in std_logic_vector(7 downto 4);
    ISEQUAL: out std_logic);
end component;

component Comp_2 is port (        
    USER: in std_logic_vector(11 downto 8);
    CODE: in std_logic_vector(11 downto 8);
    ISEQUAL: out std_logic);
end component;

component Comp_3 is port (        
    USER: in std_logic_vector(15 downto 12);
    CODE: in std_logic_vector(15 downto 12);
    ISEQUAL: out std_logic);
end component;

component Soma_P is port (
    P0, P1, P2, P3: in std_logic;
    P: out std_logic_vector(2 downto 0));
end component;

component comp_e is port (    
    inc, inu: in  std_logic_vector(15 downto 0);
    E : out std_logic_vector(2 downto 0));
end component;

component bcd7seg is port (
    bcd_in:  in std_logic_vector(3 downto 0);
    out_7seg:  out std_logic_vector(6 downto 0));
end component;

component CompIsEqual4 is port (
    P: in std_logic_vector(2 downto 0);
    EndGame: out std_logic);
end component;

component Counter_round is port (
    RST: in std_logic;
    EN: in std_logic;
    CLK_500hz: in std_logic;
    EndRound: out std_logic;
    X: out std_logic_vector(3 downto 0));
end component;

component DECODER_TERMOMETRICO is port (
    X:  in std_logic_vector(3 downto 0);
    TERMO:  out std_logic_vector(15 downto 0));
end component;

begin

end_game <= end_gamee; --ao interligar a saida do comp=4, usar o signal end_gamee para evitar erros
end_time <= end_timee; --ao interligar a saida do counter_time, usar o signal end_timee para evitar erros


    -- Set user choice with reg16bits component
    reguser: reg16bits port map(
                                CLK_500hz => Clock500,
                                EN => E2,
                                RST => R2, 
                                D => Switches(15 downto 0),
                                Q => user);

    --  set sel signal to ROMs
    regcode: reg6bits port map(
                                CLK_500hz => Clock500, 
                                EN => E1, 
                                RST => R2, 
                                D => Switches(5 downto 0), 
                                Q => sel(5 downto 0));

    -- Get rom sequence by sel key
    ROM0Sequence: ROM0 port map(
                                address => sel(5 downto 2), 
                                data => rom0_s(15 downto 0));

    ROM1Sequence: ROM1 port map(
                                address => sel(5 downto 2), 
                                data => rom1_s(15 downto 0));

    ROM2Sequence: ROM2 port map(
                                address => sel(5 downto 2), 
                                data => rom2_s(15 downto 0));

    ROM3Sequence: ROM3 port map(
                                address => sel(5 downto 2), 
                                data => rom3_s(15 downto 0));

    --Select CODE by ROM trough sel
    GetCodeSelected: mux4x1bits16 port map(
        in00 => rom0_s(15 downto 0), 
        in01 => rom1_s(15 downto 0), 
        in10 => rom2_s(15 downto 0), 
        in11 => rom3_s(15 downto 0), 
        SEL_MUX_ROM => sel(1 downto 0), 
        dataout => code(15 downto 0));

    IsEqualSequence0: Comp_0 port map(        
        USER => user(3 downto 0),
        CODE => code(3 downto 0),
        ISEQUAL => cmp0_s);
    
    IsEqualSequence1: Comp_1 port map(
        USER => user(7 downto 4),
        CODE => code(7 downto 4),
        ISEQUAL => cmp1_s);

    IsEqualSequence2: Comp_2 port map(
        USER => user(11 downto 8),
        CODE => code(11 downto 8),
        ISEQUAL => cmp2_s);

    IsEqualSequence3: Comp_3 port map(
        USER => user(15 downto 12),
        CODE => code(15 downto 12),
        ISEQUAL => cmp3_s);

    SumElementsEquals: Soma_P port map(
        P0 => cmp0_s, 
        P1 => cmp1_s, 
        P2 => cmp2_s, 
        P3 => cmp3_s, 
        P => P(2 downto 0));

    IsExistInMyCodeButInWrongPosition: comp_e port map(
        inc => code(15 downto 0), 
        inu => user(15 downto 0), 
        E => E(2 downto 0));

    isEndGame: CompIsEqual4 port map(
        P => P(2 downto 0),
        EndGame => end_gamee);

    regP: reg3bits port map (
        CLK_500hz => Clock500,
        EN => E4,
        RST => R2,
        D => P(2 downto 0),
        Q => P_reg(2 downto 0));

    regE: reg3bits port map(
        CLK_500hz => Clock500,
        EN => E4,
        RST => R2,
        D => E(2 downto 0),
        Q => E_reg(2 downto 0));

    isEndTime: Counter_round port map (
        RST => R2,
        EN => E3,
        CLK_500hz => Clock500,
        EndRound => end_round,
        X => X(3 downto 0));

    SetRounds: DECODER_TERMOMETRICO port map (    
        X => X(3 downto 0),
        TERMO => s_dec_term(15 downto 0));
    
    ledr(15 downto 0) <= s_dec_term(15 downto 0) --and E1; fixme

    fHEX0: bcd7seg port map (    
        bcd_in => code(3 downto 0),
        out_7seg => hex0(6 downto 0));

    fHEX1: bcd7seg port map (    
        bcd_in => code(7 downto 4),
        out_7seg => hex1(6 downto 0));

    fHEX2: bcd7seg port map (    
        bcd_in => code(11 downto 8),
        out_7seg => hex2(6 downto 0));
    
    fHEX3: bcd7seg port map (    
        bcd_in => code(15 downto 12),
        out_7seg => hex3(6 downto 0));
    
    fHEX4: bcd7seg port map (    
        bcd_in => user(3 downto 0),
        out_7seg => hex4(6 downto 0));

    fHEX5: bcd7seg port map (    
        bcd_in => user(7 downto 4),
        out_7seg => hex5(6 downto 0));

    fHEX6: bcd7seg port map (    
        bcd_in => user(11 downto 8),
        out_7seg => hex6(6 downto 0));
    
    fHEX7: bcd7seg port map (    
        bcd_in => user(15 downto 12),
        out_7seg => hex7(6 downto 0));

end arc_data;
