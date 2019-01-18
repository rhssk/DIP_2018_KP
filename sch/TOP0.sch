<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="VGA_GREEN" />
        <signal name="VGA_VSYNC" />
        <signal name="VGA_HSYNC" />
        <signal name="XLXN_8" />
        <signal name="SW_0" />
        <signal name="SW_1" />
        <signal name="LED_0" />
        <signal name="VGA_RED" />
        <signal name="VGA_BLUE" />
        <signal name="PS2_DATA" />
        <signal name="PS2_CLK" />
        <signal name="BTN_EAST" />
        <signal name="CLK_50MHZ" />
        <signal name="LED_7" />
        <port polarity="Output" name="VGA_GREEN" />
        <port polarity="Output" name="VGA_VSYNC" />
        <port polarity="Output" name="VGA_HSYNC" />
        <port polarity="Input" name="SW_0" />
        <port polarity="Input" name="SW_1" />
        <port polarity="Output" name="LED_0" />
        <port polarity="Output" name="VGA_RED" />
        <port polarity="Output" name="VGA_BLUE" />
        <port polarity="Input" name="PS2_DATA" />
        <port polarity="Input" name="PS2_CLK" />
        <port polarity="Input" name="BTN_EAST" />
        <port polarity="Input" name="CLK_50MHZ" />
        <port polarity="Output" name="LED_7" />
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="TOP">
            <timestamp>2019-1-18T2:12:29</timestamp>
            <rect width="336" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="464" y1="-352" y2="-352" x1="400" />
            <line x2="464" y1="-288" y2="-288" x1="400" />
            <line x2="464" y1="-224" y2="-224" x1="400" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
            <line x2="464" y1="-96" y2="-96" x1="400" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
        </blockdef>
        <block symbolname="and2" name="XLXI_2">
            <blockpin signalname="SW_1" name="I0" />
            <blockpin signalname="SW_0" name="I1" />
            <blockpin signalname="LED_0" name="O" />
        </block>
        <block symbolname="TOP" name="XLXI_15">
            <blockpin signalname="CLK_50MHZ" name="CLOCK" />
            <blockpin signalname="BTN_EAST" name="RESET" />
            <blockpin signalname="PS2_CLK" name="PS2_CLOCK" />
            <blockpin signalname="PS2_DATA" name="PS2_DATA" />
            <blockpin signalname="VGA_HSYNC" name="VGA_HSYNC" />
            <blockpin signalname="VGA_VSYNC" name="VGA_VSYNC" />
            <blockpin signalname="VGA_RED" name="VGA_RED" />
            <blockpin signalname="VGA_GREEN" name="VGA_GREEN" />
            <blockpin signalname="VGA_BLUE" name="VGA_BLUE" />
            <blockpin signalname="LED_7" name="KBD_TEST_LED" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1728" y="1312" name="XLXI_2" orien="R0" />
        <branch name="SW_0">
            <wire x2="1728" y1="1184" y2="1184" x1="1696" />
        </branch>
        <branch name="SW_1">
            <wire x2="1728" y1="1248" y2="1248" x1="1696" />
        </branch>
        <branch name="LED_0">
            <wire x2="2016" y1="1216" y2="1216" x1="1984" />
        </branch>
        <iomarker fontsize="28" x="1696" y="1184" name="SW_0" orien="R180" />
        <iomarker fontsize="28" x="1696" y="1248" name="SW_1" orien="R180" />
        <iomarker fontsize="28" x="2016" y="1216" name="LED_0" orien="R0" />
        <instance x="1616" y="2240" name="XLXI_15" orien="R0">
        </instance>
        <branch name="VGA_BLUE">
            <wire x2="2096" y1="2144" y2="2144" x1="2080" />
            <wire x2="2112" y1="2144" y2="2144" x1="2096" />
        </branch>
        <iomarker fontsize="28" x="2112" y="2144" name="VGA_BLUE" orien="R0" />
        <branch name="VGA_GREEN">
            <wire x2="2096" y1="2080" y2="2080" x1="2080" />
            <wire x2="2112" y1="2080" y2="2080" x1="2096" />
        </branch>
        <iomarker fontsize="28" x="2112" y="2080" name="VGA_GREEN" orien="R0" />
        <branch name="VGA_RED">
            <wire x2="2096" y1="2016" y2="2016" x1="2080" />
            <wire x2="2112" y1="2016" y2="2016" x1="2096" />
        </branch>
        <iomarker fontsize="28" x="2112" y="2016" name="VGA_RED" orien="R0" />
        <branch name="VGA_VSYNC">
            <wire x2="2096" y1="1952" y2="1952" x1="2080" />
            <wire x2="2112" y1="1952" y2="1952" x1="2096" />
        </branch>
        <iomarker fontsize="28" x="2112" y="1952" name="VGA_VSYNC" orien="R0" />
        <branch name="VGA_HSYNC">
            <wire x2="2096" y1="1888" y2="1888" x1="2080" />
            <wire x2="2112" y1="1888" y2="1888" x1="2096" />
        </branch>
        <iomarker fontsize="28" x="2112" y="1888" name="VGA_HSYNC" orien="R0" />
        <branch name="PS2_DATA">
            <wire x2="1616" y1="2176" y2="2176" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="1584" y="2176" name="PS2_DATA" orien="R180" />
        <branch name="PS2_CLK">
            <wire x2="1616" y1="2080" y2="2080" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="1584" y="2080" name="PS2_CLK" orien="R180" />
        <branch name="BTN_EAST">
            <wire x2="1616" y1="1984" y2="1984" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="1584" y="1984" name="BTN_EAST" orien="R180" />
        <branch name="CLK_50MHZ">
            <wire x2="1616" y1="1888" y2="1888" x1="1600" />
        </branch>
        <iomarker fontsize="28" x="1600" y="1888" name="CLK_50MHZ" orien="R180" />
        <branch name="LED_7">
            <wire x2="2112" y1="2208" y2="2208" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="2208" name="LED_7" orien="R0" />
    </sheet>
</drawing>