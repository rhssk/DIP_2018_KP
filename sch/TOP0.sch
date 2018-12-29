<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="SW_0" />
        <signal name="SW_1" />
        <signal name="LED_0" />
        <port polarity="Input" name="SW_0" />
        <port polarity="Input" name="SW_1" />
        <port polarity="Output" name="LED_0" />
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
        <block symbolname="and2" name="XLXI_2">
            <blockpin signalname="SW_1" name="I0" />
            <blockpin signalname="SW_0" name="I1" />
            <blockpin signalname="LED_0" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1872" y="1168" name="XLXI_2" orien="R0" />
        <branch name="SW_0">
            <wire x2="1872" y1="1040" y2="1040" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1840" y="1040" name="SW_0" orien="R180" />
        <branch name="SW_1">
            <wire x2="1872" y1="1104" y2="1104" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1840" y="1104" name="SW_1" orien="R180" />
        <branch name="LED_0">
            <wire x2="2160" y1="1072" y2="1072" x1="2128" />
        </branch>
        <iomarker fontsize="28" x="2160" y="1072" name="LED_0" orien="R0" />
    </sheet>
</drawing>